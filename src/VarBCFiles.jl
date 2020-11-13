module VarBCFiles

using Dates
import Base: read, show, size, getindex, vcat, ==
export VarBC

include("VarBCRecord.jl")

mutable struct VarBC <: AbstractArray{VarBCRecord,1}
    datetime::DateTime
    records::Array{VarBCRecord,1}
end

size(a::VarBC) = (length(a.records),)
getindex(a::VarBC,i::Int) = a.records[i] 
show(io::IO, ::MIME"text/plain", a::VarBC) = println(io, "VarBC with $(length(a)) records for $(a.datetime)")

vcat(a::VarBC,b::VarBC) = a.datetime == b.datetime ? VarBC(a.datetime,[a.records; b.records]) : throw("datetimes not equal")

==(a::VarBC,b::VarBC) = a.datetime == b.datetime && a.records == a.records

# gettype(fieldname) = typetable[fieldname]  

function read(fname::String,::Type{VarBC})
    io = open(fname)
    version = readline(io)
    str, date, time = split(readline(io))
    numrecord, dummy1 = split(readline(io))
#     @info "Reading $numrecord records from $fname valid for $date $time"
    
    dt = DateTime("$(date)$(lpad(time,6,"0"))","yyyymmddHHMMSS") 
    records = [VarBCRecord() for i in 1:parse(Int,numrecord)] 
    out = VarBC(dt,records)
    ind = 0
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
