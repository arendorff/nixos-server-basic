# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixcloud"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mo = {
    isNormalUser = true;
    description = "mo";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	lshw
	vim
	git
	curl
	wget
	tldr
	htop
	iotop
	tmux
	ranger
	neofetch
	ncdu
	tree
	ripgrep
	moreutils 
	edir
	smartmontools
    hdparm 
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 
    69 # ssh 
    # 443 80 81 # nginx proxy manager
    # 8888 # heimdall 
    # 4333 # heimdall
    # 8080 # vaultwarden
    # 4433 # nextcloud
  ];

  networking.firewall.allowedUDPPorts = [ 
    # 443 80 81
    # 8080
  ];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?


########################################################

# disable going to sleep when laptop lid is closed. 
# services.logind.lidSwitch = "ignore";

### OPENSSH ###

# Enable the OpenSSH daemon.
services.openssh = {
	enable = true;
	passwordAuthentication = false;
	permitRootLogin = "no";
	ports = [ 69 ];
};

# set ssh keys 
users.users.mo.openssh.authorizedKeys.keys = [
	# x280
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnmfNPGN7U2CteYDv3I/hevzoTInSG1pJB/aEDD03KEXXeuE4a/gcZ3Uyaoth/Lc+B9rUQbYTNduj3zn7Iu29W2HInoVr2MpAtBkFBo+/8KBxO22/OP2afdAWIOINqTFZKh+SF46Mb/m0CuchyqrC+PqfJgI3iZZTjqdwq3TbFKIyyesPWA+Gut1iRXWefyBMkEIIXCkbqPgTbmbOBHz1tR5b4BDdwJKHCK5HezMcFfhGCLnKBnxfgj7xrlXE93BODEQNoNmni0OPU5R34XXJ1v1kmo5mFcQP4lvEiFYSLkIbTX/keveOrnovSUS/bNkvmRwjPxR9s3dJ2i57XUInvF1ay+XjX8tfgqhmcT3ono22BD9rQ786LShdS6Ifl1tZyJbYuMg6v/BzhASETfuuHGQiFni3N53I/ZxzWPXuiosVf1Z8q+ZXxmEJqGuS7+iaV74aDgiZ4Cav9YPmuYDRGq6FsP1R0dcp5tm8TDY0tSsrMulHSxl92JuuIs2Fxyo8= mo@x280"
	# corsair
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMCRMYXY2laKgQlmx3MnYTOGw6zymFhydwSi8rngJNRWVFC7VW5g3/hiSt237TaWLH9DZSs6+ynTDpreGNYYOKW4/KWQxbXwnTTK1RuNcwfXdX5X7gmtmp9vCLDUkwTqURE55FWPxpn/IKqqb+iFBkIO/nPDsZ7BWnOplsa7OkEDwPsSRNHBmZsMIC9tRYGkUGOXAxq+bLBQ7XleclxzJ+Jyf8fD1imGcbF2fFZjPb4TT24sjob5Y20GftmYXXCtqgSpqoTLOSbzozP3Rp3jiZG63CKkDUUussKZOz9uvgbUGbrw0Lna4Ik4IT6vrXjFDgkt9jWsC77JShclE8buqmTVIWZSO3krmHZgbkOEYDk9hjTbiBBgrjZIkA+lVB671S7McPnPGFEVIvxiByezIjucwdo6USjr7C0z11KaRQCpli+pPC63GDVE1CHVMOJN4SDobisN2pjmIiKhC8iVo0kME/mqos0AgFnn8U9HCSAiBmOjEyashaxnCALJKOxB0= mo@corsair"
    # note: ssh-copy-id will add user@clientmachine after the public key
    # but we can remove the "@clientmachine" part
];

### FISH ###

# make fish the default shell for all users
users.defaultUserShell = pkgs.fish;

programs.fish = {
  enable = true;
  # set abbreviations
  shellAbbrs = {
    vim = "nvim";
    vi = "nvim";
    v = "nvim";
    nrs = "sudo nixos-rebuild switch";
    nrsu = "sudo nixos-rebuild switch --upgrade";
    nrb = "sudo nixos-rebuild boot";
    nrbu = "sudo nixos-rebuild boot --upgrade";
    ga = "git add";
    gs = "git status";
    gc = "git commit -m";
    gp = "git push -u origin main";
  };
};


### DOCKER ###

# enable docker
virtualisation.docker.enable = true;


### NIX STORE GARBAGE COLLECTION ###

nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
};


### AUTOMATIC UPGRADES/UPDATES###

system.autoUpgrade = {
  enable = true;
  dates = "daily";
  rebootWindow = {
    lower = "03:00";
    upper = "04:00";
  };
};

### AUTOMATIC SHUTDOWN ###

# Enable cron service
# services.cron = {
# 	enable = true;
# 	systemCronJobs = [
# 		# shut down at 24:00 every day.
# 		"0 0 * * *	root	shutdown now"
# 
# 		# mirror syncthing directory to to other drive.
# 		"0 13  * * *	root	rsync -aruvhP /home/mo/syncthing/ /mnt/mergerfs/moritz/syncthing-mirror/"
# 	];
# };

### NEOVIM CONFIG ###

programs.neovim = {
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  configure = {
    # custom vimrc
    customRC = ''
    " " "" formatting
    set linebreak " to make vim not split words when breaking a line
    set tabstop=4
    set shiftwidth=0 "number of spaces used for each step auf autoindent, >>, etc.
    set softtabstop=2
    set expandtab " use spaces instead of tabs.
    set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
    set shiftround " tab / shifting moves to closest tabstop.
    set noautoindent " Match indents on new lines.
    set smartindent " Intellegently dedent / indent new lines based on rules
    set breakindent " wrapping text respects indentation
    set ignorecase " case insensitive search
    set smartcase " If there are uppercase letters, become case-sensitive.
    set incsearch " live incremental searching
    set showmatch " live match highlighting
    set nohlsearch " highlight matches of search
    set gdefault " use the `g` flag by default.
    " move about
    nnoremap j gj
    nnoremap k gk
    vnoremap j gj
    vnoremap k gk
    inoremap fj <Esc>
    inoremap jf <Esc>
    inoremap JF <Esc>
    inoremap FJ <Esc>
    tnoremap fj <C-\><C-N>
    tnoremap jf <C-\><C-N>
    tnoremap JF <C-\><C-N>
    tnoremap FJ <C-\><C-N>
    "S and T (shift+left/right) to move to end or beginning of line.
    nnoremap H ^
    vnoremap H ^
    nnoremap L $
    vnoremap L $
    " change Y to y$
    nnoremap Y y$
    '';
    # vim plugins to be loaded
    packages.myVimPackage = with pkgs.vimPlugins; {
      # loaded on launch
      start = [
        vim-plug
        vim-nix
        vim-fish
        vim-commentary
        vim-surround
        vim-repeat  ];
      # manually loadable by calling `:packadd $plugin-name`
      opt = [ ];
    };
  };
};

} # end of config



