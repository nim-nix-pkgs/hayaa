{
  description = ''Conway's Game of Life implemented in Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-hayaa-v0_2_0.flake = false;
  inputs.src-hayaa-v0_2_0.ref   = "refs/tags/v0.2.0";
  inputs.src-hayaa-v0_2_0.owner = "angus-lherrou";
  inputs.src-hayaa-v0_2_0.repo  = "hayaa";
  inputs.src-hayaa-v0_2_0.type  = "github";
  
  inputs."illwill".owner = "nim-nix-pkgs";
  inputs."illwill".ref   = "master";
  inputs."illwill".repo  = "illwill";
  inputs."illwill".dir   = "v0_3_0";
  inputs."illwill".type  = "github";
  inputs."illwill".inputs.nixpkgs.follows = "nixpkgs";
  inputs."illwill".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-hayaa-v0_2_0"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-hayaa-v0_2_0";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}