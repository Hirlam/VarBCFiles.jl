
mutable struct VarBCRecord
    class::String 
    key::String 
    label::String 
    ndata::Int64
    npred::Int64
    predcs::Vector{Int64}
    param0::Vector{Float64}
    params::Vector{Float64}
    hstgrm::Vector{Int64} 
    predxcnt::Vector{Int64}
    predmean::Vector{Float64}
    predxcov::Vector{Float64} 
 end
 VarBCRecord() = VarBCRecord("","","",0,0,[],[],[],[],[],[],[])
 
 # show(io::IO, a::VarBCRecord) = print(io, "VarBC $(rpad(a.label,30)) predcs=$(rpad(a.predcs,30)) ndata=$(a.ndata)")
 
 rmdi2missing(x) = x == -2.147e+09 ? NaN : x
 parse2(::Type{String},x) = x  # this should be in Base 
 parse2(::Type{Vector{T}},x ) where T = split(x) |> x-> parse.(T,x) |> x->rmdi2missing.(x)
 parse2(::Type{T},x ) where T = parse(T,x)  
 
 
 const typetable = Dict{Symbol,DataType}(zip(fieldnames(VarBCRecord), VarBCRecord.types))

# Note we cannot implement read from iostream here as information is spread over VARBC.cycle files
