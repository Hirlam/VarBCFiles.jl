
using Dates, Test, VarBCFiles

v1 = read("VARBC.cycle",VarBC)
v2 = read("VARBC.cycle",VarBC)

@test v1.datetime == DateTime(2016,06,01,06,00,00)
@test v1 == v2

v1.datetime = DateTime(2017,06,01,06,00,00)
@test v1 != v2

@testset "vcat" begin
    @test_throws AssertionError("a.datetime == b.datetime") [v1; v2]    # throws because incompatible datetimes
end

