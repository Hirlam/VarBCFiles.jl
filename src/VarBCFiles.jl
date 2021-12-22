module VarBCFiles

using Dates, Printf, DataStructures, DataFrames
import Base: read, write, show, size, getindex, ==, merge!, length, filter!, keys
import DataFrames: DataFrame
export VarBC, VarBCRecord, increment, label,keys, readParamIncrement

include("VarBCRecord.jl")

struct VarBC  # <: AbstractDict{String, VarBCRecord}
    datetime::DateTime
    version::String
    header1::String
    header2::String
    records::OrderedDict{String,VarBCRecord}
end

length(a::VarBC) = length(a.records)
show(io::IO, ::MIME"text/plain", a::VarBC) = println(io, "VarBC with $(length(a)) records for $(a.datetime)")

"""
    filter!(f,a)

Update VarBCRecords in `a`, removing elements for which `f` is `false`. The function `f` is passed `key=>value` pairs

# Example
```jldoctest

julia> filter!(p-> p.second.label == "sfcobs", a)

```
"""
filter!(f,a::VarBC) = filter!(f,a.records)


"""
    merge!(a,b)

Merges the VarBC Records from `b` into `a`. If a key is present in both `a` and `b` the value from `b` is used. 
Header information in `a` is not taken from `b` 
"""
merge!(a::VarBC,b::VarBC) = merge!(a.records,b.records)
 

"""
    a == b

Returns `true` if `a` and `b` are equal
"""
function ==(a::VarBC,b::VarBC) 
    a.datetime == b.datetime &&
    a.header1 == b.header1 &&
    b.header2 == b.header2 &&
    a.version == a.version &&
    a.records == a.records
end

"""
    keys(a) 

Returns keys 
"""
keys(a::VarBC) = keys(a.records) 

"""
    read(filename,VarBC)

returns a object of type `VarBC` 
"""
function read(fname::String,::Type{VarBC})
    io = open(fname)
    version = readline(io); @assert version == "VARBC_cycle.version006"
    header1 = readline(io)
    header2 = readline(io)
    str, date, time = split(header1)
    numrecord, dummy1 = split(header2)
    dt = DateTime("$date$(lpad(time,6,"0"))","yyyymmddHHMMSS") 
    out = VarBC(dt,version,header1, header2,OrderedDict{String,VarBCRecord}())
    while !eof(io)
       push!(out.records, read(io,VarBCRecord))        
    end
    close(io)
    return out
end


"""
    readParamIncrement(filename,key)

returns namedTuple of paramIncrement 
"""
function readParamIncrement(fname::String,key)
    io = open(fname)
    version = readline(io); 
    @assert version == "VARBC_cycle.version006"
    header1 = readline(io)
    header2 = readline(io)
    str, date, time = split(header1)
    dt = DateTime("$date$(lpad(time,6,"0"))","yyyymmddHHMMSS") 
    while !eof(io)
       rec = read(io,VarBCRecord)
       val = last(rec)
       if key== first(rec)
         return ( ;datetime=dt, zip(Symbol.("p",val.predcs),val.params-val.param0)...)
       end
    end
    close(io)
end

"""
    write(fname,a)

Write VarBC struct to file
"""
function write(fname::String,a::VarBC)
    io = open(fname,"w")
    write(io,a.version,"\n")
    write(io,a.header1,"\n")
    write(io,a.header2,"\n")
    i=1
    for (key,rec) in a.records
        write(io,rec,key,i)
        i=i+1
    end 
    close(io)
end 



end # module
