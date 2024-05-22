using LinearAlgebra

function min_n(x0, precision)
    xbest = x0
    fbest = dot(xbest, xbest)  # Representa a função como um produto escalar
    println("Initial point: x = ", xbest, ", fbest = ", fbest)
    deltaf = -1.0
    deltax = 0.1
    
    while deltaf > precision
        gradient = 2 * xbest  # Vetor gradiente
        if norm(gradient) < precision
            println("Critical point found.")
            println("xbest = ", xbest, ", fbest = ", fbest, ", gradient = ", gradient)
            return xbest, fbest
        end
        
        xtrial = xbest - deltax * gradient
        ftrial = dot(xtrial, xtrial)  # Representa a função como um produto escalar
        deltaf = norm(gradient)
        
        if ftrial < fbest
            xbest .= xtrial  # Atualiza xbest usando broadcast
            println("Accepted: xbest = ", xbest, ", fbest = ", fbest, ", deltax = ", deltax, ", gradient = ", gradient)
            deltax = deltax * 2
        else
            println("Not accepted: xbest = ", xbest, ", fbest = ", fbest, ", deltax = ", deltax, ", gradient = ", gradient)
            deltax = deltax / 2
        end
    end
end

# Exemplo de chamada
min_n(Vector{Float64}(undef, 1000), 0.01)
