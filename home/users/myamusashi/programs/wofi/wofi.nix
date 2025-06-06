{
  programs.wofi = {
    enable = true;
    style = ''
      window {
      margin: 0px;
      border: 1px solid #C0A36E;
      background-color: #0F111A;
      }

      #input {
      margin: 5px;
      border: none;
      color: #E5E9F0;
      background-color: #3B4252;
      }

      #inner-box {
      margin: 5px;
      border: none;
      background-color: #282828;
      }

      #outer-box {
      margin: 5px;
      border: none;
      background-color: #282828;
      }

      #scroll {
      margin: 0px;
      border: none;
      }

      #text {
      margin: 5px;
      border: none;
      color: #E5E9F0;
      }

      #entry:selected {
      background-color: #4C566A;
      }
    '';
    settings = {
      pre_display_exec = true;
      image_size = 128;
    };
  };
}
