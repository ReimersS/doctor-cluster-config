{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../modules/hardware/supermicro-x12spw-tf.nix
    ../modules/nfs/client.nix
    # iommu & xrp driver for sebastians students
    ../modules/vfio/iommu-intel.nix
    ../modules/xrp.nix
  ];

  networking.hostName = "adelaide";

  system.stateVersion = "21.11";

}
