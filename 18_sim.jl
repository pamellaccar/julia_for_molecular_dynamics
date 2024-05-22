function sim1(CA0, k1, time, dt) #dt = 1.e-1 # Time-step #por que se eu manter essa linha, dá erro?
    for i in 1:2
      if CA0 < 0.0 
        println("O valor de CA0 deve ser positivo.")
        break
      end
    end
    nsteps = Int64(time/dt) # Number of steps
    t = Vector{Float64}(undef,nsteps)
    CA = Vector{Float64}(undef,nsteps)
    CA[1] = CA0
    t[1] = 0.
      
    for i in 2:nsteps
      CA[i] = CA[i-1] - k1*CA[i-1]*dt
      t[i] = t[i-1]+dt
    end
        return t, CA
end 