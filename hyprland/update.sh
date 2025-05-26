#!/usr/bin/env nix-shell
#! nix-shell -i bash -p common-updater-scripts fd jq curl
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

# 3. FUNGSI BARU: Dapatkan latest release tag
echo ""
echo "Fetching latest release information..."

# Method 1: Dapatkan latest release (recommended)
latest_release_data="$(curl --silent "https://api.github.com/repos/$OWNER/$REPO/releases/latest" \
	-H "Accept: application/vnd.github.v3+json")"

# Cek apakah ada release yang ditemukan
if [ "$(jq -r '.tag_name // empty' <<<"$latest_release_data")" != "" ]; then
	latest_tag="$(jq -r '.tag_name' <<<"$latest_release_data")"
	release_name="$(jq -r '.name // .tag_name' <<<"$latest_release_data")"
	release_published_at="$(jq -r '.published_at' <<<"$latest_release_data")"
	release_target_commitish="$(jq -r '.target_commitish' <<<"$latest_release_data")"
	is_prerelease="$(jq -r '.prerelease' <<<"$latest_release_data")"

	echo "Latest release tag: $latest_tag"
	echo "Release name: $release_name"
	echo "Release date: ${release_published_at%T*}"
	echo "Target branch/commit: $release_target_commitish"
	echo "Is prerelease: $is_prerelease"

	# 4. Dapatkan commit hash dari tag tersebut
	tag_commit_data="$(curl --silent "https://api.github.com/repos/$OWNER/$REPO/git/refs/tags/$latest_tag" \
		-H "Accept: application/vnd.github.v3+json")"

	if [ "$(jq -r '.object.sha // empty' <<<"$tag_commit_data")" != "" ]; then
		tag_commit_sha="$(jq -r '.object.sha' <<<"$tag_commit_data")"
		echo "Tag commit SHA: $tag_commit_sha"

		# Cek apakah latest commit sama dengan tag commit
		if [ "$commit_hash" = "$tag_commit_sha" ]; then
			echo "✓ Latest commit matches latest release tag!"
			use_tag_version=true
		else
			echo "ℹ Latest commit is ahead of latest release tag"
			use_tag_version=false
		fi
	else
		echo "Warning: Could not fetch commit SHA for tag $latest_tag"
		use_tag_version=false
	fi
else
	echo "No releases found, falling back to commit-based versioning"
	latest_tag=""
	use_tag_version=false
fi

# Method 2 (Alternative): Dapatkan semua tags dan ambil yang terbaru
echo ""
echo "Fetching all tags for reference..."
all_tags_data="$(curl --silent "https://api.github.com/repos/$OWNER/$REPO/tags?per_page=5" \
	-H "Accept: application/vnd.github.v3+json")"

if [ "$(jq -r 'length' <<<"$all_tags_data")" -gt 0 ]; then
	echo "Recent tags:"
	jq -r '.[] | "  - \(.name) (commit: \(.commit.sha[0:7]))"' <<<"$all_tags_data"
fi

# 5. Tentukan versi yang akan digunakan
if [ "$use_tag_version" = true ] && [ -n "$latest_tag" ]; then
	# Gunakan tag sebagai versi
	version_for_nixpkgs="$latest_tag"
	commit_to_use="$tag_commit_sha"
	version_type="release"
	echo ""
	echo "Using release version: $version_for_nixpkgs"
else
	# Gunakan tanggal commit sebagai versi
	version_for_nixpkgs="unstable-$commit_date_short"
	commit_to_use="$commit_hash"
	version_type="unstable"
	echo ""
	echo "Using unstable version: $version_for_nixpkgs"
fi

echo "Final version for Nixpkgs: $version_for_nixpkgs"
echo "Commit to use: $commit_to_use"

# 6. Update versi dan revisi di file Nixpkgs (uncomment jika diperlukan)
# echo "Updating source version for hyprland package..."
# update-source-version hyprland "$version_for_nixpkgs" --rev="$commit_to_use" --ignore-same-hash

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
  "latest_release": {
    "tag": "$latest_tag",
    "name": "$release_name",
    "published_at": "${release_published_at:-}",
    "is_prerelease": "${is_prerelease:-false}",
    "matches_latest_commit": $use_tag_version
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
	if [ -n "$latest_tag" ]; then
		echo "  Latest Release: $latest_tag"
	fi
else
	echo "Error: Failed to create info.json"
	exit 1
fi

echo ""
echo "Script finished successfully."
