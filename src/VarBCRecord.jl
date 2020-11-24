
struct VarBCRecord
    pdate::String 
    class::String 
    # key::String 
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
 
 show(io::IO,a::VarBCRecord) = print(io,a.label)

 function show(io::IO,::MIME"text/plain", a::VarBCRecord) 
    println(io, "VarBC Record")
    println(io, "label  = $(a.label)")
    println(io, "predcs = $(a.predcs)")
    println(io, "ndata  = $(a.ndata)")
    println(io, "param0 = $(a.param0)")
    println(io, "params = $(a.params)")
 end

 function ==(a::VarBCRecord,b::VarBCRecord)
     a.pdate == b.pdate &&
     a.class == b.class &&
     a.label == b.label &&
     a.ndata == b.ndata &&
     a.npred == b.npred &&
     b.predcs == b.predcs &&
     a.param0 == b.param0 &&
     a.params == b.params &&
     a.hstgrm == b.hstgrm &&
     a.predxcnt == b.predxcnt &&
     a.predmean == b.predmean && 
     a.predxcov == a.predxcov  
 end  

 # increment(a::VarBCRecord) = a.params - a.param0
 # label(a::VarBCRecord) = a.label
 
 function read(io::IO,::Type{VarBCRecord})
       rmdi2nan(x) = x == -2.147e+09 ? NaN : x
       parsev(::Type{T},x) where T = split(x) |>  x -> parse.(T,x)  |> x -> rmdi2nan.(x)
      
       ix       = readline(io)  # |> x -> replace(x, r"^ix="       => "")  |> x -> parse(Int,x)   # ix not used 
       pdate    = readline(io) |> x -> replace(x, r"^pdate="     => "")  # |> x -> parse(String,x)
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
       key => VarBCRecord(pdate,class,label,ndata,npred,predcs,param0,params,hstgrm,predxcnt,predmean,predxcov) 
   end 

 
function write(io::IO,a::VarBCRecord, key::String, ix::Int)
 
   # Print Float  Int  Array{Float,1} etc.  
   myprint(f::Float64) = isnan(f) ? "-2.147E+09" : @sprintf("% -.3E",f) 
   myprint(i::Int64) = string(i)
   myprint(s::String) = s
   myprint(a::Array{T,1}) where T = join(myprint.(a)," ")

   println(io,"ix=$ix")
   println(io,"pdate=$(myprint(a.pdate))")
   println(io,"class=$(myprint(a.class))")
   println(io,"key=$key")
   println(io,"label=$(myprint(a.label))")
   println(io,"ndata=$(myprint(a.ndata))")
   println(io,"npred=$(myprint(a.npred))")
   println(io,"predcs=$(myprint(a.predcs))")
   println(io,"param0=$(myprint(a.param0))")  
   println(io,"params=$(myprint(a.params))")
   println(io,"hstgrm=$(myprint(a.hstgrm))")
   println(io,"predxcnt=$(myprint(a.predxcnt))")
   println(io,"predmean=$(myprint(a.predmean))")
   println(io,"predxcov=$(myprint(a.predxcov))")   
end 