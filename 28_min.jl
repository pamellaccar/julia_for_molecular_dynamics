#deltax como parâmetro da funcao

function min1(x0, deltax)
    x = x0
    #deltax = 0.1 # Step size
    xbest = x # Save best point
    fbest = x^2 # Best value up to now
    println(" Initial point: ",xbest," ",fbest)
    deltaf = -1.
    while deltaf < 0. #Inicia um loop que continuará até que a função pare de diminuir.
        # Move x in the descent direction, with step deltax
        dfdx = 2*x # Computing the derivative
        x = x - deltax * dfdx/abs(dfdx) # Move x in the -f' direction: Move x na direção de descida, com um passo proporcional à derivada. Isso é uma técnica comum em algoritmos de otimização.
        # Test new point
        deltaf = x^2 - fbest
        #Write current point
        println("Current point: ",x," ",x^2," ",deltaf)
        # If the function decreased, save best point
        if deltaf < 0. 
            xbest = x
            fbest = x^2
        else
            println(" Function is increasing. ")
            println(" Best solution found: x = ", xbest, " f(x) = ",fbest)
            return xbest, fbest
        end
    end
end

