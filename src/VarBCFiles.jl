module VarBCFiles

using Dates
import Base: read, show, size, getindex, ==, merge!
export VarBC, increment

include("VarBCRecord.jl")

struct VarBC <: AbstractArray{VarBCRecord,1}
    datetime::DateTime
    version::String
    header1::String
    header2::String
    records::Array{VarBCRecord,1}
end

size(a::VarBC) = (length(a.records),)
getindex(a::VarBC,i::Int) = a.records[i] 
show(io::IO, ::MIME"text/plain", a::VarBC) = println(io, "VarBC with $(length(a)) records for $(a.datetime)")

function ==(a::VarBC,b::VarBC) 
    a.datetime == b.datetime &&
    a.header1 == b.header1 &&
    b.header2 == b.header2 &&
    a.version == a.version &&
    a.records == a.records
end

function merge!(a::VarBC,b::VarBC)
    alabels = getfield.(a.records,:label)
    for rec in b.records
        if rec.label ∉ alabels
            push!(a.records,rec) 
        end 
    end 
end 

function read(fname::String,::Type{VarBC})
    io = open(fname)
    version = readline(io); @assert version == "VARBC_cycle.version006"
    header1 = readline(io)
    header2 = readline(io)
    str, date, time = split(header1)
    numrecord, dummy1 = split(header2)

#     @info "Reading $numrecord records from $fname valid for $date $time"
    
    dt = DateTime("$date$(lpad(time,6,"0"))","yyyymmddHHMMSS") 
    out = VarBC(dt,version,header1, header2,VarBCRecord[])
    while !eof(io)
        push!(out.records, read(io,VarBCRecord))        
    end
    close(io)
    return out
end 


end # module
