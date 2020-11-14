

# VarBCFiles

[![Build Status](https://travis-ci.com/roelstappers/VarBCFiles.jl.svg?branch=master)](https://travis-ci.com/roelstappers/VarBCFiles.jl) [![Coverage Status](https://coveralls.io/repos/github/roelstappers/VarBCFiles.jl/badge.svg?branch=master)](https://coveralls.io/github/roelstappers/VarBCFiles.jl?branch=master)

This package reads `VarBC.cycle` files version 6.

# Examples 


```julia
julia> v = read("test/VARBC.cycle1",VarBC)
VarBC with 1080 records for 2019-08-02T12:00:00
```

```julia 
julia> v[1]
VarBC Record
label  = D0MZ8zJj 16199110       1     6
predcs = [0]
ndata  = 1
param0 = [1110.0]
params = [1110.0]
```

```julia
julia> filter(x-> x.ndata !=0 ,v)
967-element Array{VarBCRecord,1}:
 D0MZ8zJj 16199110       1     6
 jyMWkv4j 16199110       1     2
 xPjBCo1h 16199110       1    17
 PwdHED+0 16199110       1    14
 5pmWgmxN 16199110       1     5
 U746kkHz 16199110       1    31
 HQqIkVWl 16199110       1    27
 Q/cKvkgk 16199110       1    10
 JSFLCdB3 16199110       1    11
 tIx4MoYt 16199110       1     9
 lFMOm0Xo 16199110       1    49
 H3hkuVTw 16199110       1    40
 ⋮
 wcJe6MSE 16199110       1     7
 cUi3XsaH 16199110       1    11
 kS+SRvIv 16199110       1    34
 018n5/Pd 16199110       1    21
 RkWc40j+ 16199110       1     9
 i0qVCwno 16199110       1    46
 /0yFhs4g 16199110       1     5
 mcCM84az 16199110       1    15
 g1eZzs8Z 16199110       1     4
 ixMAAIkv 16199110       1    57
 Fwq3o+ap 16199110       1    12
 5bGxy6PZ 16199110       1    65
```