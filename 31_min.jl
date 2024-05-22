function min1(x0, deltax) 
    x = x0
    deltax = 0.1 # Step size
    xbest = x # Save best point
    fbest = x^2 + sin(10x)# Best value up to now
    println(" Initial point: ",xbest," ",fbest)
    deltaf = -1.
    while deltaf < 0. #Inicia um loop que continuará até que a função pare de diminuir.
        # Move x in the descent direction, with step deltax
        dfdx = 2*x + 10*cos(10*x) # Computing the derivative
        x = x - deltax * dfdx/abs(dfdx) # Move x in the -f' direction: Move x na direção de descida, com um passo proporcional à derivada. Isso é uma técnica comum em algoritmos de otimização.
        # Test new point
        deltaf = x^2 + sin(10x) - fbest
        #Write current point
        println("Current point: ",x," ",x^2 + sin(10x)," ",deltaf)
        # If the function decreased, save best point
        if deltaf < 0. 
            xbest = x
            fbest = x^2 + sin(10x)
        else
            println(" Function is increasing. ")
            println(" Best solution found: x = ", xbest, " f(x) = ",fbest)
            return xbest, fbest
        end
    end
end

#xbest, fbest = min1(2.0)
#=
(juliaDM) julia> min1(-2.0,-2.0)
 Initial point: -2.0 3.0870547492723723
Current point: -2.1 3.573344361463944 0.48628961219157185
 Function is increasing. 
 Best solution found: x = -2.0 f(x) = 3.0870547492723723
(-2.0, 3.0870547492723723)

(juliaDM) julia> min1(-1.0,-2.0)
 Initial point: -1.0 1.5440211108893698
Current point: -0.9 0.39788151475824346 -1.1461395961311263
Current point: -0.8 -0.34935824662338166 -0.7472397613816251
Current point: -0.7000000000000001 -0.16698659871878963 0.18237164790459204
 Function is increasing. 
 Best solution found: x = -0.8 f(x) = -0.34935824662338166
(-0.8, -0.34935824662338166)

(juliaDM) julia> min1(0.0,-2.0)
 Initial point: 0.0 0.0
Current point: -0.1 -0.8314709848078965 -0.8314709848078965
Current point: -0.2 -0.8692974268256817 -0.03782644201778518
Current point: -0.1 -0.8314709848078965 0.03782644201778518
 Function is increasing. 
 Best solution found: x = -0.2 f(x) = -0.8692974268256817
(-0.2, -0.8692974268256817)

(juliaDM) julia> min1(1.0,-2.0)
 Initial point: 1.0 0.4559788891106302
Current point: 1.1 0.2100097934492967 -0.24596909566133351
Current point: 1.0 0.4559788891106302 0.24596909566133351
 Function is increasing. 
 Best solution found: x = 1.1 f(x) = 0.2100097934492967
(1.1, 0.2100097934492967)

(juliaDM) julia> min1(2.0,-2.0)
 Initial point: 2.0 4.912945250727628
Current point: 1.9 3.7598772096629522 -1.1530680410646754
Current point: 1.7999999999999998 2.489012753228323 -1.2708644564346292
Current point: 1.6999999999999997 1.9286025081204432 -0.5604102451078798
Current point: 1.5999999999999996 2.272096683334937 0.34349417521449377
 Function is increasing. 
 Best solution found: x = 1.6999999999999997 f(x) = 1.9286025081204432
(1.6999999999999997, 1.9286025081204432)

(juliaDM) julia> min1(2.0,-1.0)
 Initial point: 2.0 4.912945250727628
Current point: 1.9 3.7598772096629522 -1.1530680410646754
Current point: 1.7999999999999998 2.489012753228323 -1.2708644564346292
Current point: 1.6999999999999997 1.9286025081204432 -0.5604102451078798
Current point: 1.5999999999999996 2.272096683334937 0.34349417521449377
 Function is increasing. 
 Best solution found: x = 1.6999999999999997 f(x) = 1.9286025081204432
(1.6999999999999997, 1.9286025081204432)

(juliaDM) julia> min1(2.0,0.0)
 Initial point: 2.0 4.912945250727628
Current point: 1.9 3.7598772096629522 -1.1530680410646754
Current point: 1.7999999999999998 2.489012753228323 -1.2708644564346292
Current point: 1.6999999999999997 1.9286025081204432 -0.5604102451078798
Current point: 1.5999999999999996 2.272096683334937 0.34349417521449377
 Function is increasing. 
 Best solution found: x = 1.6999999999999997 f(x) = 1.9286025081204432
(1.6999999999999997, 1.9286025081204432)

(juliaDM) julia> min1(2.0, 1.0)
 Initial point: 2.0 4.912945250727628
Current point: 1.9 3.7598772096629522 -1.1530680410646754
Current point: 1.7999999999999998 2.489012753228323 -1.2708644564346292
Current point: 1.6999999999999997 1.9286025081204432 -0.5604102451078798
Current point: 1.5999999999999996 2.272096683334937 0.34349417521449377
 Function is increasing. 
 Best solution found: x = 1.6999999999999997 f(x) = 1.9286025081204432
(1.6999999999999997, 1.9286025081204432)

(juliaDM) julia> min1(2.0, 2.0)
 Initial point: 2.0 4.912945250727628
Current point: 1.9 3.7598772096629522 -1.1530680410646754
Current point: 1.7999999999999998 2.489012753228323 -1.2708644564346292
Current point: 1.6999999999999997 1.9286025081204432 -0.5604102451078798
Current point: 1.5999999999999996 2.272096683334937 0.34349417521449377
 Function is increasing. 
 Best solution found: x = 1.6999999999999997 f(x) = 1.9286025081204432
(1.6999999999999997, 1.9286025081204432)
=#