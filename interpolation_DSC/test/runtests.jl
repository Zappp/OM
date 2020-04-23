using interpolation_DSC, Test

@testset "interpolation_DSC" begin
    x, e, f = 10, 0.001, x -> x^4 + 3x^3 + x^2 + sin(x)
    @test inpol_dsc(f, x, e) == (-1.9712756211432556, -4.915216432826824)
    @test inpol_dsc(f, x, e) == (-8, -4)
end

