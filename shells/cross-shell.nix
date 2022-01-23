with import <nixpkgs>
{
  crossSystem = {
    config = "riscv64-unknown-linux-gnu";
  };
};

mkShell {
  buildInputs = [ ];
}
