function simplex(f, x0, niter, scale_factor)
    x = copy(x0)
    # Initial function values
    fx = [f(xi) for xi in x]
    xtemp = zeros(3)
    ftemp = 0.0
    xav = zeros(3)
    xtrial = zeros(3)
    println(" Initial points: ")
    for i in 1:3
        println(x[i], " ", fx[i])
    end
    # Convergence criterion desired
    convcrit = 1e-10
    # Main iteration
    for iter in 1:niter
        println(" ------ ITERATION: ", iter)
        # Order the points from best to worst
        sorted = sort!(x, by=x -> f(x))
        fx = [f(xi) for xi in x]
        println(sorted)
        for i in 1:3
            println(x[i], " ", fx[i])
        end
        # Check convergence
        if (fx[3] - fx[2] < convcrit) && (fx[3] - fx[1] < convcrit)
            println(" Precision reached. ")
            println(" Best point found: ", x[1], " f = ", fx[1])
            return x[1], fx[1]
        end
        # Compute average of best points
        @. xav = 0.5 * (x[1] + x[2])
        # Compute trial point
        @. xtrial = x[3] + 2 * (xav - x[3])
        ftrial = f(xtrial)
        # If ftrial is better than fx[3], replace point 3 with trial point
        if ftrial < fx[3]
            fx[3] = ftrial
            x[3] = xtrial
            println(" Accepted point: ", x[3], " f = ", fx[3])
        else
            println(" Function increased. Trying line search. ")
            # Try up to 10 different points in the direction x[3]+gamma*(xtrial-x[3])
            for j in 1:10
                xtemp = x[3] + rand() * (xtrial - x[3])
                ftemp = f(xtemp)
                if ftemp < fx[3]
                    fx[3] = ftemp
                    x[3] = xtemp
                    println("Line search succeeded at trial ", j)
                    println(" New point: ", x[3], " f = ", fx[3])
                    break  # exits from line search loop
                end
            end
            # If the line search didn't find a better point, stop
            if ftemp > fx[3]
                println(" End of search. ")
                println(" Best point found: ", x[1], " f = ", fx[1])
                return x[1], fx[1]
            end
        end
    end
    println(" Maximum number of trials reached. ")
    println(" Best point found: ", x[1], " f = ", fx[1])
    return x[1], fx[1]
end

# Função a ser minimizada
f(x::Vector{Float64}) = x[1]^2 + x[2]^2 + x[3]^2

# Ponto inicial: 3 vetores de dimensão 3
x0 = [rand(3) for i in 1:3]

# Minimizar
niter = 1000
simplex(f, x0, niter, 0.1)
