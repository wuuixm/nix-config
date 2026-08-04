{
  description = "Gardenia NixOS configuration";

  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];

    trusted-substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs.git?shallow=1&ref=nixos-26.05";

    nixpkgs-unstable.url = "git+https://github.com/NixOS/nixpkgs.git?shallow=1&ref=nixpkgs-unstable";

    home-manager = {
      url = "git+https://github.com/nix-community/home-manager.git?shallow=1&ref=release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "git+https://github.com/ryantm/agenix.git?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "git+https://github.com/schembriaiden/helium-browser-nix-flake.git?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "git+https://github.com/noctalia-dev/noctalia.git?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    res-moqi-rime = {
      url = "git+https://github.com/gaboolic/rime-shuangpin-fuzhuma.git?shallow=1";
      flake = false;
    };

    rust-overlay = {
      url = "git+https://github.com/oxalica/rust-overlay?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @ inputs: {
    nixosConfigurations.Gardenia = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        pkgs-unstable = import nixpkgs-unstable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };

      modules = [
        ./os-modules

        home-manager.nixosModules.home-manager

        ({ config, inputs, ... }: {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; } // config._module.args;
            sharedModules = [ ];
            users.wuuixm.imports = [ ./hm-modules ];
          };
        })
      ];
    };
  };
}
