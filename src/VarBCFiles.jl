module VarBCFiles

using Dates
import Base: read, show, size, getindex, vcat, ==
export VarBC

include("VarBCRecord.jl")

mutable struct VarBC <: AbstractArray{VarBCRecord,1}
    datetime::DateTime
    version::String
    header1::String
    header2::String
    records::Array{VarBCRecord,1}
end

size(a::VarBC) = (length(a.records),)
getindex(a::VarBC,i::Int) = a.records[i] 
show(io::IO, ::MIME"text/plain", a::VarBC) = println(io, "VarBC with $(length(a)) records for $(a.datetime)")

function vcat(a::VarBC,b::VarBC) 
    @assert a.datetime == b.datetime
    VarBC(a.datetime,a.version, a.header1, a.header2, [a.records; b.records]) 
end

function ==(a::VarBC,b::VarBC) 
    a.datetime == b.datetime &&
    a.header1 == b.header1 &&
    b.header2 == b.header2 &&
    a.version == a.version &&
    a.records == a.records
end 

# gettype(fieldname) = typetable[fieldname]  

function read(fname::String,::Type{VarBC})
    io = open(fname)
    version = readline(io)
    header1 = readline(io)
    header2 = readline(io)
    str, date, time = split(header1)
    numrecord, dummy1 = split(header2)
#     @info "Reading $numrecord records from $fname valid for $date $time"
    
    dt = DateTime("$(date)$(lpad(time,6,"0"))","yyyymmddHHMMSS") 
    records = [VarBCRecord() for i in 1:parse(Int,numrecord)] 
    out = VarBC(dt,version,header1, header2,records)
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
