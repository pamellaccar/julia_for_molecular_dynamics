# Function to be minimized
f(x::Vector{Float64}) = x[1]^2 + x[2]^2
# Minimizer by random search
function randomsearch(f,ntrial)
    fbest = 1.e30
    x = Vector{Float64}(undef,2)
    xbest = Vector{Float64}(undef,2)
    for i in 1:ntrial
        x[1] = xbest[1] + 1.e-3*(-1.e0 + 2.e0 * rand())
        x[2] = xbest[2] + 1.e-3*(-1.e0 + 2.e0 * rand())
        fx = f(x)
        if fx < fbest
            fbest = fx
            xbest[1] = x[1]
            xbest[2] = x[2]
            println(i," New best point: ", x," f(x) = ", fx)
        end
    end
println(" Best point found: ",xbest," f = ", fbest)
end

randomsearch(f,1000)