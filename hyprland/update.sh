#!/usr/bin/env nix-shell
#! nix-shell -i bash -p common-updater-scripts fd jq curl nix
set -eou pipefail

OWNER="hyprwm"
REPO="Hyprland"
BRANCH_TO_TRACK="main"

echo "Fetching latest commit information for $OWNER/$REPO on branch $BRANCH_TO_TRACK..."

# 1. Dapatkan data commit terakhir dari branch yang ditentukan
latest_commit_data="$(curl --silent "https://api.github.com/repos/$OWNER/$REPO/commits/$BRANCH_TO_TRACK" \
	-H "Accept: application/vnd.github.v3+json")"

# Periksa apakah curl berhasil dan mendapatkan data
if [ -z "$latest_commit_data" ] || [ "$(jq -r '.sha // empty' <<<"$latest_commit_data")" == "" ]; then
	echo "Error: Failed to fetch latest commit data or data is empty."
	exit 1
fi

# 2. Ekstrak informasi yang dibutuhkan dari data commit
commit_hash="$(jq -r '.sha' <<<"$latest_commit_data")"
commit_message_full="$(jq -r '.commit.message' <<<"$latest_commit_data")"
commit_message="$(echo "$commit_message_full" | head -n 1)"
committer_date_full="$(jq -r '.commit.committer.date' <<<"$latest_commit_data")"
commit_date_short="${committer_date_full%T*}"

echo "Latest commit hash: $commit_hash"
echo "Commit date: $commit_date_short"
echo "Commit message: $commit_message"

# 3. FUNGSI BARU: Dapatkan hash SHA256 menggunakan nix store prefetch-file
echo ""
echo "Fetching SHA256 hash for the tarball..."

# Buat URL tarball dari commit hash
tarball_url="https://github.com/$OWNER/$REPO/archive/$commit_hash.tar.gz"
echo "Tarball URL: $tarball_url"

# Dapatkan hash menggunakan nix store prefetch-file
echo "Prefetching tarball to get hash..."
prefetch_result="$(nix store prefetch-file --hash-type sha256 --json "$tarball_url" 2>/dev/null || echo '{}')"
if [ "$(jq -r '.hash // empty' <<<"$prefetch_result")" != "" ]; then
	tarball_hash="$(jq -r '.hash' <<<"$prefetch_result")"
	echo "✓ Tarball hash: $tarball_hash"
else
	echo "Warning: Failed to prefetch tarball hash, will use placeholder"
	tarball_hash="sha256-PLACEHOLDER"
fi

# 4. Dapatkan latest release tag
echo ""
echo "Fetching latest release information..."
latest_release_data="$(curl --silent "https://api.github.com/repos/$OWNER/$REPO/releases/latest" \
	-H "Accept: application/vnd.github.v3+json" 2>/dev/null || echo '{}')"

if [ "$(jq -r '.tag_name // empty' <<<"$latest_release_data")" != "" ]; then
	latest_release_tag="$(jq -r '.tag_name' <<<"$latest_release_data")"
	release_published_at="$(jq -r '.published_at' <<<"$latest_release_data")"
	is_prerelease="$(jq -r '.prerelease' <<<"$latest_release_data")"
	echo "Latest release: $latest_release_tag"
else
	echo "No releases found or failed to fetch release data"
	latest_release_tag=""
	release_published_at=""
	is_prerelease="false"
fi

# 5. Method 2 (Alternative): Dapatkan semua tags dan ambil yang terbaru
echo ""
echo "Fetching all tags for reference..."
all_tags_data="$(curl --silent "https://api.github.com/repos/$OWNER/$REPO/tags?per_page=5" \
	-H "Accept: application/vnd.github.v3+json")"

if [ "$(jq -r 'length' <<<"$all_tags_data")" -gt 0 ]; then
	echo "Recent tags:"
	jq -r '.[] | "  - \(.name) (commit: \(.commit.sha[0:7]))"' <<<"$all_tags_data"
fi

# Gunakan tanggal commit sebagai versi
version_for_nixpkgs="unstable-$commit_date_short"
commit_to_use="$commit_hash"
version_type="unstable"

echo ""
echo "Using unstable version: $version_for_nixpkgs"
echo "Final version for Nixpkgs: $version_for_nixpkgs"
echo "Commit to use: $commit_to_use"
echo "Hash to use: $tarball_hash"

# 6. Update versi dan revisi di file Nixpkgs (uncomment jika diperlukan)
# echo "Updating source version for hyprland package..."
# update-source-version hyprland "$version_for_nixpkgs" --rev="$commit_to_use" --hash="$tarball_hash" --ignore-same-hash

# 7. Buat info.json dengan informasi lengkap
dir="."
echo ""
echo "Writing commit info to $dir/info.json"

# Escape JSON strings properly
escaped_commit_message="${commit_message//\\/\\\\}"
escaped_commit_message="${escaped_commit_message//\"/\\\"}"

cat >"$dir/info.json" <<EOF
{
  "branch": "$BRANCH_TO_TRACK",
  "commit_hash": "$commit_hash",
  "commit_message": "$escaped_commit_message",
  "date": "$commit_date_short",
  "version_type": "$version_type",
  "version": "$version_for_nixpkgs",
  "commit_used": "$commit_to_use",
  "tarball_url": "$tarball_url",
  "tarball_hash": "$tarball_hash",
  "latest_release": {
    "tag_name": "$latest_release_tag",
    "published_at": "$release_published_at",
    "is_prerelease": $is_prerelease
  }
}
EOF

if [ $? -eq 0 ]; then
	echo "✓ info.json created successfully"
	echo ""
	echo "Summary:"
	echo "  Repository: $OWNER/$REPO"
	echo "  Branch: $BRANCH_TO_TRACK"
	echo "  Version: $version_for_nixpkgs ($version_type)"
	echo "  Commit: ${commit_to_use:0:7}"
	echo "  Hash: $tarball_hash"
	echo ""
	echo "Nix package configuration example:"
	echo "  src = fetchFromGitHub {"
	echo "    owner = \"$OWNER\";"
	echo "    repo = \"$REPO\";"
	echo "    rev = \"$commit_to_use\";"
	echo "    hash = \"$tarball_hash\";"
	echo "  };"
else
	echo "Error: Failed to create info.json"
	exit 1
fi

echo ""
echo "Script finished successfully."
