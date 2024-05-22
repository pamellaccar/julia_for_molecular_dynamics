#= cinética enzimática é o estudo das taxas de reações catalisadas por enzimas e quais os fatores
que afetam a velocidade das reações enzimáticas. No mecanismo de Michaellis-Menten: considera-se que 
a formação do produto (P) a partir do complexo ES é a fase lenta do processo enzimático e 
portanto que ES se mantém sempre em equilíbrio com E e S =#

# Definir as equações diferenciais para a cinética de Michaelis-Menten
function sim_mm(CE0, CS0, CES0, CP0, kr, kf, kcat, time, dt)
    nsteps = Int(time / dt)  # Número de passos
    t = Vector{Float64}(undef, nsteps)
    CE = Vector{Float64}(undef, nsteps)
    CS = Vector{Float64}(undef, nsteps)
    CES = Vector{Float64}(undef, nsteps)
    CP = Vector{Float64}(undef, nsteps)

    # Condições iniciais
    CE[1] = CE0
    CS[1] = CS0
    CES[1] = CES0
    CP[1] = CP0
    t[1] = 0.0

    for i in 2:nsteps
        CE[i] = CE[i-1] - kr * CE[i-1] * CS[i-1] * dt + kf * CES[i-1] * dt
        CS[i] = CS[i-1] - kr * CE[i-1] * CS[i-1] * dt + kf * CES[i-1] * dt
        CES[i] = CES[i-1] + kr * CE[i-1] * CS[i-1] * dt - (kf + kcat) * CES[i-1] * dt
        CP[i] = CP[i-1] + kcat * CES[i]
        t[i] = t[i-1] + dt
    end
    return t, CE, CS, CES, CP
end

# Resolver as equações diferenciais
t, CE, CS, CES, CP = sim_mm(10.0, 50.0, 20.0, 0.0, 1e-2, 1e-6, 1e-14, 100.0, 1.0)

using Plots
plot(t, [CE CS CES CP], xlabel="Tempo", ylabel="Concentração",
    label=["E" "S" "ES" "P"], legend=true)



