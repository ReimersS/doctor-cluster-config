{
  config,
  lib,
  pkgs,
  ...
}: {
  # This adds the XRP nvme driver
  # Needed for sys-lab 22/23
  config = {
    boot.kernelPackages = pkgs.linuxPackages_5_12;

    # https://github.com/xrp-project/linux
    boot.kernelPatches = [
      {
        name = "xrp";
        patch = builtins.fetchurl {
              url = "https://github.com/xrp-project/linux/commit/c8d074d1db7fe3e3feb94f984272f17edf3fbfed.patch";
        };
        extraConfig = ''
          DEBUG_INFO y
          BPF_SYSCALL y
          DEBUG_INFO_BTF y
          UIO y
          UIO_PCI_GENERIC y
        '';
      }
    ];
  };
}
