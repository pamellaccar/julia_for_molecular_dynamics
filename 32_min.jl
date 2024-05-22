#removendo a normalização na direção da derivada = 
function min1(x0, deltax)
    x = x0
    xbest = x
    fbest = x^2 + sin(10x)
    println("Initial point: ", xbest, " ", fbest)
    deltaf = -1.0
    while deltaf < 0.
        dfdx = 2 * x + 10 * cos(10 * x)
        x = x - deltax * dfdx   # removendo a divisão dfdx/abs(dfdx)
        #Agora, a atualização de x é feita diretamente multiplicando deltax pela derivada dfdx, sem normalização pela magnitude da derivada.
        deltaf = x^2 + sin(10x) - fbest
        println("Current point: ", x, " ", x^2 + sin(10x), " ", deltaf)
        
        if deltaf < 0.0
            xbest = x
            fbest = x^2 + sin(10x)
        else
            println("Function is increasing.")
            println("Best solution found: x = ", xbest, " f(x) = ", fbest)
            return xbest, fbest
        end
    end
end

#removendo a normalização, pode ser necessário ajustar o tamanho do passo (deltax) para garantir a convergência do método
