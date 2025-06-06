{
  services.gns3-server = {
    enable = false;
    settings = {
      Server = {
        appliances_path = "/home/myamusashi/GNS3/appliances";
        configs_path = "/home/myamusashi/GNS3/configs";
        images_path = "/home/myamusashi/GNS3/images";
        projects_path = "/home/myamusashi/GNS3/projects";
        symbols_path = "/home/myamusashi/GNS3/symbols";
      };
    };
  };
}
