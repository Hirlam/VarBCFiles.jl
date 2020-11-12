module VarBCFiles


import Base: read
export VarBC

mutable struct VarBC
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

VarBC() = VarBC("","","",0,0,[],[],[],[],[],[],[])

rmdi2missing(x) = x == -2.147e+09 ? NaN : x
parse2(::Type{String},x) = x  # this should be in Base 
parse2(::Type{Vector{T}},x ) where T = split(x) |> x-> parse.(T,x) |> x->rmdi2missing.(x)


parse2(::Type{T},x ) where T = parse(T,x)  


const typetable = Dict{Symbol,DataType}(zip(fieldnames(VarBC), VarBC.types))
# gettype(fieldname) = typetable[fieldname]  

function read2(fname::String,::Type{VarBC})
    io = open(fname)
    version = readline(io)
    str, date, time = split(readline(io))
    numrecord, dummy1 = split(readline(io))
    @info "Reading $numrecord records from $fname valid for $date $time"
    
    out = [VarBC() for i in 1:parse(Int,numrecord)] 
    ind = 1 
    while !eof(io)
        fldname, value = readline(io) |> x -> split(x, '=')

        
        fldname == "numpreds" && (println("Warning numpreds field found"); continue)
        # @show getproperty(out[ind], Symbol(fieldname))
        fldname == "ix" ? ind = parse(Int,value) : setproperty!(out[ind], Symbol(fldname), parse2(typetable[Symbol(fldname)],value))
    end
    close(io)
    return out
end 

end # module
