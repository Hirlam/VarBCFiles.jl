
struct VarBCRecord
    ix::Int
    pdate::String 
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
 
 show(io::IO,a::VarBCRecord) = print(io,a.label)

 function show(io::IO,::MIME"text/plain", a::VarBCRecord) 
    println(io, "VarBC Record")
    println(io, "label  = $(a.label)")
    println(io, "predcs = $(a.predcs)")
    println(io, "ndata  = $(a.ndata)")
    println(io, "param0 = $(a.param0)")
    println(io, "params = $(a.params)")
 end

 increment(a::VarBCRecord) = a.params - a.param0
 
 function read(io::IO,::Type{VarBCRecord})
       rmdi2nan(x) = x == -2.147e+09 ? NaN : x
       parsev(::Type{T},x) where T = split(x) |>  x -> parse.(T,x)  |> x -> rmdi2nan.(x)
      
       ix       = readline(io) |> x -> replace(x, r"^ix="       => "")  |> x -> parse(Int,x)   # ix not used 
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
       VarBCRecord(ix,pdate,class,key,label,ndata,npred,predcs,param0,params,hstgrm,predxcnt,predmean,predxcov) 
   end 


    
# note: not finished. Format strings using @printf ?  
function write(io::IO,a::VarBCRecord)
   nan2rmdi(x) = isnan(x) ? -2.147e+09 : x
   println(io,"ix=$(a.ix)")
   println(io,"pdate=$(a.pdate)")
   println(io,"class=$(a.class)")
   println(io,"key=$(a.key)")
   println(io,"label=$(a.label)")
   println(io,"ndata=$(a.ndata)")
   println(io,"npred=$(a.npred)")
   println(io,"predcs=$(join(a.predcs," "))")
   println(io,"param0=$(join(nan2rmdi.(a.param0)," "))")  
   println(io,"params=$(join(nan2rmdi.(a.params)," "))")
   println(io,"hstgrm=$(join(a.hstgrm, " "))")
   println(io,"predxcnt=$(join(nan2rmdi.(a.predxcnt)," "))")
   println(io,"predmean=$(join(nan2rmdi.(a.predmean)," "))")
   println(io,"predxcov=$(join(nan2rmdi.(a.predxcov)," "))")   
end 