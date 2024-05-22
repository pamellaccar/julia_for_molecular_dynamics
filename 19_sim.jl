function sim1(CA0, CB0, k1, time, dt)
    if CA0 < 0.0
        println("O valor de CA0 deve ser positivo.")
    end
    
    nsteps = Int64(time / dt)  # Número de passos
    t = Vector{Float64}(undef, nsteps)
    CA = Vector{Float64}(undef, nsteps)
    CB = Vector{Float64}(undef, nsteps)
    
    CA[1] = CA0
    CB[1] = CB0  # Inicialmente, CB é 0
    t[1] = 0.0
    
    for i in 2:nsteps
        CA[i] = CA[i-1] - k1 * CA[i-1] * dt
        CB[i] = CB[i-1] + k1 * CA[i-1] * dt  
        t[i] = t[i-1] + dt
    end
    
    return t, CA, CB
end

using Plots

CA0 = 1.0
k1 = 0.1
CB0 = 0.0
time = 10.0
dt = 0.1
t, CA, CB = sim1(CA0, CB0, k1, time, dt)
plot(t, CA, label="CA", xlabel="Tempo", ylabel="[C]", legend=:topright)
plot!(t, CB, label="CB")
#usando t, CA, CB = sim1(CA0, CB, k1, time, dt)
