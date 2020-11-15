
using Test, VarBCFiles

# Check that we only allow version 6 files
@test_throws AssertionError("version == \"VARBC_cycle.version006\"") read("VARBC.cycle_v5",VarBC)

v1 = read("VARBC.cycle1",VarBC)
v2 = read("VARBC.cycle2",VarBC)

@test v1 != v2

# Check that rmdi2nan works 
@test isnan(v2[1].param0[1])

@testset "merge" begin
     @test length(v1) == 1080
     @test length(v2) == 1043
     merge!(v1,v2)
     @test length(v1) == 1083
    
end
