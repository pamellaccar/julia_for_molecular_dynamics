function simplex(f, x0, niter)
    # Initial point: x0 contains 3 vectors of dimension 2
    x = copy(x0)
    # Initial function values
    fx = zeros(3)
    for i in 1:3
        fx[i] = f(x[i])
    end
    xtemp = zeros(2)
    ftemp = 0.
    xav = zeros(2)
    xtrial = zeros(2)
    println(" Initial points: ")
    for i in 1:3
        println(x[i]," ",fx[i])
    end
    # Convergence criterium desired
    convcrit = 1.e-10
    # Main interation
for iter in 1:niter
    println(" ------ ITERATION: ", iter)

    # Ordena os pontos do melhor para o pior
    for i in 1:3
        j = i
        while j > 1 && fx[j-1] > fx[j]
            ftemp = fx[j-1]
            fx[j-1] = fx[j]
            fx[j] = ftemp
            xtemp[1] = x[j-1][1]
            xtemp[2] = x[j-1][2]
            x[j-1][1] = x[j][1]
            x[j-1][2] = x[j][2]
            x[j][1] = xtemp[1]
            x[j][2] = xtemp[2]
            j = j - 1
        end
    end

    # Condição de convergência
    if (fx[3] - fx[2] < convcrit) && (fx[3] - fx[1] < convcrit)
        println(" Precision reached. ")
        println(" Best point found: ", x[1], " f = ", fx[1])
        return x[1], fx[1]
    end

    # Calcula a média dos melhores pontos
    @. xav = 0.5 * (x[1] + x[2])

    # Calcula o ponto de teste
    @. xtrial = x[3] + 2 * (xav - x[3])
    ftrial = f(xtrial)

    # Se ftrial for melhor que fx[3], substitui o ponto 3 pelo ponto de teste
    if ftrial < fx[3]
        fx[3] = ftrial
        @. x[3] = xtrial
        println(" Accepted point: ", x[3], " f = ", fx[3])
    else
        # Busca linear
        println(" Function increased. Trying line search. ")
        for j in 1:10
            @. xtemp = x[3] + rand() * (xtrial - x[3])
            ftemp = f(xtemp)
            if ftemp < fx[3]
                fx[3] = ftemp
                @. x[3] = xtemp
                println("Line search succeeded at trial ", j)
                println(" New point: ", x[3], " f = ", fx[3])
                break  # Sai do loop de busca linear
            end
        end

        # Se a busca linear não encontrar um ponto melhor, encerra
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
f(x::Vector{Float64}) = x[1]^2 + sin(x[2])

# Ponto inicial: 3 vetores de dimensão 2
x0 = [Vector{Float64}(undef, 2) for i in 1:3]
for i in 1:3
    x0[i][1] = -10. + 20. * rand()
    x0[i][2] = -10. + 20. * rand()
end

# Minimizar
niter = 1000
simplex(f, x0, niter)