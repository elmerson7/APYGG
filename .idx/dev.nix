# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{pkgs}: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
  services.docker.enable = true;

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.php82
    # pkgs.php82Packages.composer
    # pkgs.nodejs_20
    pkgs.htop
    pkgs.nano
    pkgs.openssh
    pkgs.gnutar
  ];
  # Sets environment variables in the workspace
  env = {};
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
      "eamodio.gitlens"
      "ms-azuretools.vscode-docker"
      "christian-kohler.path-intellisense"
      "Durzn.brackethighlighter"
      "naumovs.color-highlight"
      "PKief.material-icon-theme"
      "zobo.php-intellisense"
      "onecentlin.laravel5-snippets"
      "Atishay-Jain.All-Autocomplete"
      "earshinov.simple-alignment"
      "oderwat.indent-rainbow"
    ];
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        # Example: install JS dependencies from NPM
        # npm-install = "npm install";
        # Open editors for the following files by default, if they exist:
        default.openFiles = [ "README.md" "resources/views/welcome.blade.php" ];
      };
      # Runs when the workspace is (re)started
      onStart = {
        # Example: start a background task to watch and re-build backend code
        # watch-backend = "npm run watch-backend";
        # Inicia el contenedor Docker
        start-docker-container = ''
          docker start api-laravel &&
          docker exec -it api-laravel bash -c "
            php artisan serve
          "
        '';
      };
      
    };
    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = {
        # web = {
        #   command = ["php" "artisan" "serve" "--port" "$PORT" "--host" "0.0.0.0"];
        #   manager = "web";
        # };
      };
    };
  };
}
