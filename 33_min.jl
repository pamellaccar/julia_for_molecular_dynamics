function min1(x0, precision)
    xbest = x0
    fbest = xbest^2 
    println("Initial point: ", xbest, " ", fbest)
    deltaf = -1.0
    deltax = 0.1
    while abs(deltaf) > precision
        dfdx = 2 * xbest
        if abs(dfdx) < precision #Verifica se a magnitude da derivada é menor que a precisão. Se for, o ponto atual é considerado um ponto crítico.
            println("Critical point found.")
            println("xbest = ", xbest, " fbest = ", fbest, " dfdx = ", dfdx)
            return xbest, fbest
        end
        xtrial = xbest - deltax * dfdx  #compute function value at trial point 
        ftrial = xtrial^2 # If the function decreased, accept trial point and increase step
        deltaf = xtrial^2 - fbest
        if ftrial < fbest
            xbest = xtrial
            println("accepted:", xbest, "", fbest, "", deltax, "", dfdx)
            deltax = deltax * 2
        else
            println("not accepted:", xbest, "", fbest, "", deltax, "", dfdx)
            deltax = deltax / 2
        end
    end
end


