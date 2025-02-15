{ inputs, self, ... }: {

  # packages for x86 only
  flake.packages.x86_64-linux = let 
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in {
    sfc-drivers = pkgs.callPackage ./xilinx/sfc-driver.nix {
      inherit (pkgs.linuxPackages) kernel;
    };

    xrt = pkgs.callPackage ./xilinx/xrt.nix { };
    xrt-drivers = pkgs.callPackage ./xilinx/xrt-drivers.nix {
      inherit (self.packages.x86_64-linux) xrt;
      inherit (pkgs.linuxPackages_5_10) kernel;
    };
    xntools-core = pkgs.callPackage ./xilinx/xntools-core.nix { };

    firmware-sn1000 = pkgs.callPackage ./xilinx/firmware-sn1000.nix { };

    xilinx-env = pkgs.callPackage ./xilinx/fhs-env.nix { };
  };

  # packages for many targets:
  perSystem =
    { pkgs
    , ...
    }: {
      packages = {
        xilinx-firmware = pkgs.callPackage ./xilinx/firmware.nix { };
        xilinx-cable-drivers = pkgs.callPackage ./xilinx/cable-drivers { };
        intel-cable-drivers = pkgs.callPackage ./intel-fpgas/cable-drivers.nix { };
      };
    };
}
