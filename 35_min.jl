using LinearAlgebra

function min2(x0, y0, precision)
    xbest, ybest = x0, y0
    fbest = xbest^2 + ybest^2
    println("Initial point: x = ", xbest, ", y = ", ybest, ", fbest = ", fbest)
    deltaf = -1.0
    deltax, deltay = 0.1, 0.1
    
    while abs(deltaf) > precision
        dfdx = 2 * xbest
        dfdy = 2 * ybest
        gradient = [dfdx, dfdy]
        
        if norm(gradient) < precision
            println("Critical point found.")
            println("xbest = ", xbest, ", ybest = ", ybest, ", fbest = ", fbest, ", gradient = ", gradient)
            return xbest, ybest, fbest
        end
        
        xtrial, ytrial = xbest - deltax * dfdx, ybest - deltay * dfdy
        ftrial = xtrial^2 + ytrial^2
        deltaf = norm(gradient)  
        
        if ftrial < fbest
            xbest, ybest = xtrial, ytrial
            println("Accepted: xbest = ", xbest, ", ybest = ", ybest, ", fbest = ", fbest, ", deltax = ", deltax, ", deltay = ", deltay, ", gradient = ", gradient)
            deltax, deltay = deltax * 2, deltay * 2
        else
            println("Not accepted: xbest = ", xbest, ", ybest = ", ybest, ", fbest = ", fbest, ", deltax = ", deltax, ", deltay = ", deltay, ", gradient = ", gradient)
            deltax, deltay = deltax / 2, deltay / 2
        end
    end
end
