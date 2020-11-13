
using Dates, Test, VarBCFiles

@test_throws AssertionError("version == \"VARBC_cycle.version006\"") read("VARBC.cycle_v5",VarBC)

v1 = read("VARBC.cycle1",VarBC)
v2 = read("VARBC.cycle2",VarBC)

@test v1 != v2

@testset "merge" begin
     @test length(v1) == 1080
     @test length(v2) == 1043
     merge!(v1,v2)
     @test length(v1) == 1083
    
end
