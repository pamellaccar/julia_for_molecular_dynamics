function sim2(CA0,CB0,k1,km1,time,dt) 
    nsteps = Int64(time/dt) 
    t = Vector{Float64}(undef,nsteps)
    CA = Vector{Float64}(undef,nsteps)
    CB = Vector{Float64}(undef,nsteps)
    err = Vector{Float64}(undef,nsteps)
    CA[1] = CA0
    CB[1] = CB0
    t[1] = 0.
    err[1] = 0
   for i in 2:nsteps
     CA[i] = CA[i-1] - k1*CA[i-1]*dt + km1*CB[i-1]*dt 
     CB[i] = CB[i-1] + k1*CA[i-1]*dt - km1*CB[i-1]*dt 
     t[i] = t[i] + dt
     err[i] = abs(( CA[i] + CB[i] ) - ( CA0 + CB0 )) 
        if err[i] > 1.e-20
            println("erro muito alto", err[i])
            break
        else
    end
    return t, CA, CB, err
    end
end
t, CA, CB, err = sim2( 10., 50., 1e-2, 1e-6, 100., 0.007)
    @show mean(err)

