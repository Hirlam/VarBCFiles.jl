# VarBCFiles


[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://roelstappers.github.io/VarBCFiles.jl/dev)  [![](https://github.com/roelstappers/VarBCFiles.jl/actions/workflows/runtests.yml/badge.svg)](https://github.com/roelstappers/VarBCFiles.jl/actions/workflows/runtests.yml) [![](https://github.com/roelstappers/VarBCFiles.jl/actions/workflows/Documenter.yml/badge.svg)](https://github.com/roelstappers/VarBCFiles.jl/actions/workflows/Documenter.yml)

Read, write and merge`VARBC.cycle` files version 6



## Installation 

This package is registered in the [Harmonie Registry](https://github.com/Hirlam/HarmonieRegistry). Hit `]` in the Julia REPL to go into package mode and add the Harmonie registry 

```julia
pkg> registry add General
pkg> registry add https://github.com/Hirlam/HarmonieRegistry
```

### Install stable version  

To add the latest version 

```julia
pkg> add VarBCFiles
```

### Install development version

To develop VarBCFiles 

```julia
pkg> dev VarBCFiles
```

This will put a git clone in `$HOME/.julia/dev/VarBCFiles/` by default. 
