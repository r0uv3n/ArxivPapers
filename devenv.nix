{ pkgs, lib, config, inputs, ... }:

{
  config = {
    # https://devenv.sh/basics/
    env.GREET = "devenv";

    # https://devenv.sh/packages/
    packages = [ pkgs.git ];

    # https://devenv.sh/languages/
    # languages.rust.enable = true;

    # https://devenv.sh/processes/
    # processes.cargo-watch.exec = "cargo-watch";

    # https://devenv.sh/services/
    # services.postgres.enable = true;

    # https://devenv.sh/scripts/
    scripts.hello.exec = ''
      echo hello from $GREET
    '';

    enterShell = ''
      hello
      git --version
    '';

    # https://devenv.sh/tasks/
    # tasks = {
    #   "myproj:setup".exec = "mytool build";
    #   "devenv:enterShell".after = [ "myproj:setup" ];
    # };

    # https://devenv.sh/tests/
    enterTest = ''
      echo "Running tests"
      git --version | grep --color=auto "${pkgs.git.version}"
    '';

    languages.python = {
      enable = true;
      venv.enable = true;
      venv.requirements = ./requirements.txt;
    };

    # https://devenv.sh/pre-commit-hooks/
    # pre-commit.hooks.shellcheck.enable = true;

    # See full reference at https://devenv.sh/reference/options/
  };


  options = {
    arxiv-papers.package = pkgs.lib.mkOption {
      type = config.lib.types.outputOf lib.types.package;
      description = "Create audio podcasts from arxiv papers";
      default = pkgs.buildPythonPackage {
        format = "pyproject";
      };

      defaultText = "ArxivPapers";
    };
  };

}
