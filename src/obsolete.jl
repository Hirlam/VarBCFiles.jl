
"""
Read a single VarBC record from IOstream
"""
#function read(io::IO,::Type{VarBC})
# Helper function. reads a single line and parses content after = as type T
#    readline2(io::IO,::Type{T}) where T = readline(io) |> x -> split(x, '=')[2] |> x -> parse2(T,x) 

#    ix    = readline2(io,Int)  # ix not used 
#    println("reading $ix" )
#    class = readline2(io,String)
#    key   = readline2(io,String)
#    label = readline2(io,String)
#    ndata = readline2(io,Int64)
#    npred = readline2(io,Int64)
#    predcs = readline2(io,Vector{Int64})
#    param0 = readline2(io,Vector{Float64})
#    params = readline2(io,Vector{Float64})
#    hstgrm = readline2(io,Vector{Int64})
#    VarBC(class,key,label,ndata,npred,predcs,param0,params,hstgrm) 
#end 