
struct VarBCRecord
    class::String 
    key::String 
    label::String
    pdate::String 
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
#  VarBCRecord() = VarBCRecord("","","","",0,0,[],[],[],[],[],[],[])
 
 function show(io::IO, a::VarBCRecord) 
    println(io, "VarBC")
    println(io, "label  = $(a.label)")
    println(io, "predcs = $(a.predcs)")
    println(io, "ndata  = $(a.ndata)")
    println(io, "param0 = $(a.param0)")
    println(io, "params = $(a.params)")
 end
 
 function read(io::IO,::Type{VarBCRecord})
       parsev(::Type{T},x) where T = split(x) |> x -> parse.(T,x)
       rmdi2missing(x) = x == -2.147e+09 ? NaN : x
       ix       = readline(io) |> x -> replace(x, r"^ix="       => "")  |> x -> parse(Int,x)   # ix not used 
       pdate    = readline(io) |> x -> replace(x, r"^pdate"     => "")  # |> x -> parse(String,x)
       class    = readline(io) |> x -> replace(x, r"^class="    => "")  #|> x -> parse(String,x)
       key      = readline(io) |> x -> replace(x, r"^key="      => "")  #|> x -> parse(String,x)
       label    = readline(io) |> x -> replace(x, r"^label="    => "")  #|> x -> parse(String,x)
       ndata    = readline(io) |> x -> replace(x, r"^ndata="    => "")  |> x -> parse(Int64,x)
       npred    = readline(io) |> x -> replace(x, r"^npred="    => "")  |> x -> parse(Int64,x)
       predcs   = readline(io) |> x -> replace(x, r"^predcs="   => "")  |> x -> parsev(Int64,x)
       param0   = readline(io) |> x -> replace(x, r"^param0="   => "")  |> x -> parsev(Float64,x)
       params   = readline(io) |> x -> replace(x, r"^params="   => "")  |> x -> parsev(Float64,x)
       hstgrm   = readline(io) |> x -> replace(x, r"^hstgrm="   => "")  |> x -> parsev(Int64,x)
       predxcnt = readline(io) |> x -> replace(x, r"^predxcnt=" => "")  |> x -> parsev(Int64,x)
       predmean = readline(io) |> x -> replace(x, r"^predmean=" => "")  |> x -> parsev(Float64,x)
       predxcov = readline(io) |> x -> replace(x, r"^predxcov=" => "")  |> x -> parsev(Float64,x)
       VarBCRecord(pdate,class,key,label,ndata,npred,predcs,param0,params,hstgrm,predxcnt,predmean,predxcov) 
   end 

 # parse2(::Type{String},x) = x  # this should be in Base 
 # parse2(::Type{Vector{T}},x ) where T = split(x) |> x-> parse.(T,x) |> x->rmdi2missing.(x)
 # parse2(::Type{T},x ) where T = parse(T,x)  
 
 
 # const typetable = Dict{Symbol,DataType}(zip(fieldnames(VarBCRecord), VarBCRecord.types))

# Note we cannot implement read from iostream here as information is spread over VARBC.cycle files
