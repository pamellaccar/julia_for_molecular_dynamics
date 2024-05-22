# ao inves de parar quando aumenta, ela deve continuar sem salvar o ponto de maior valor

function atividade21(x0,deltax,ntrial)
    x = x0
    xbest = x # Save best point
    fbest = x^2 # Best value up to now
    println(" Initial point: ",xbest," ",fbest)
    deltaf = -1.
    for i in 1:ntrial #USANDO FOR
      # Move x in the descent direction, with step deltax
      dfdx = 2*x # Computing the derivative
      x = x - deltax * dfdx/abs(dfdx) # Move x in the -f' direction
      # Test new point
      deltaf = x^2 - fbest
      # Write current point
      println(i," Current point: ",x," ",x^2," ",deltaf)
      # If the function decreased, save best point
      if deltaf < 0.
        xbest = x
        fbest = x^2
      end 
    end
    return xbest, fbest
  end
  