function ordenar(fx, x)
    n = length(fx)
    
    for i in 1:n
        j = i
        while j > 1 && fx[j-1] > fx[j]
            # Troca de valores em fx
            ftemp = fx[j-1]
            fx[j-1] = fx[j]
            fx[j] = ftemp

            # Troca de vetores em x
            xtemp = x[j-1]
            x[j-1] = x[j]
            x[j] = xtemp

            j = j - 1
        end
    end

    return fx, x
end

fx = [3, 1, 2]
x = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

fx, x = ordenar(fx, x)

println("fx ordenado: ", fx)
println("x ordenado: ", x)
