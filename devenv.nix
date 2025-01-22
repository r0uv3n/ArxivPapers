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
    services.postgres.enable = true;

    # https://devenv.sh/scripts/
    scripts.hello.exec = ''
      echo hello from $GREET
    '';

    enterShell = ''
      hello
      git --version
    '';

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
    arxiv-papers = pkgs.lib.mkOption {
      type = config.lib.types.outputOf lib.types.package;
      description = "Generate audio readthrough of ArXiv papers";
      default = pkgs.python3Packages.buildPythonApplication {
        pyproject = true;
        pname = "arxiv-papers";
        version = "0.1.0";
        src = ./.;
        build-system = [
          pkgs.python3Packages.setuptools
          pkgs.python3Packages.setuptools-scm
        ];
      };

      defaultText = "ArxivPapers";
    };
  };

}
