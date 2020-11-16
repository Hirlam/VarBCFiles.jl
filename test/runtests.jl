
using Test, VarBCFiles


@testset "Only version 6" begin
   # Check that we only allow version 6 files
   @test_throws AssertionError("version == \"VARBC_cycle.version006\"") read("VARBC.cycle_v5",VarBC)
end 

v1 = read("VARBC.cycle1",VarBC)
v2 = read("VARBC.cycle2",VarBC)

# Check that we write back file exactly as we read them
@testset "write" begin
     file, = mktemp()
     write(file,v2)
     @test read(file) == read("VARBC.cycle2") # this reads files as Array{UInt8,1}
     rm(file)
end

@testset "merge" begin
     @test length(v1) == 1080
     @test length(v2) == 1043
     merge!(v1,v2)
     @test length(v1) == 1083    
end

@testset "Equality operator" begin 
    @test v1 != v2
end 

@testset "Conversions" begin
    # Check that rmdi2nan works 
    @test isnan(v2[1].param0[1])
end
