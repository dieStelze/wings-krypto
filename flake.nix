{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            (pkgs.python3.withPackages (ps: with ps; [
              jupyterlab
              jupyterlab-widgets
              jupyter-server-mathjax
              ipython
              ipywidgets
              pandas
              tabulate
              qtconsole
            ]))
          ];
        };
      });

  # use latexmk -pdf -pvc main.tex for constant updates
  # use latexindent -m -l indentconfig.yaml for formatting
}