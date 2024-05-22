using DelimitedFiles
    data = readdlm("55_cineti.jl")
    CAexp = data[:, 2]
    CBexp = data[:, 3]
    return CAexp, CBexp

function simulation(CP0, CQ0, k2, km2, time)
    dt = 1.e-1
    nsteps = Int64(time / dt)
    t = Vector{Float64}(undef, nsteps)
    CP = Vector{Float64}(undef, nsteps)
    CQ = Vector{Float64}(undef, nsteps)
    CP[1] = CP0
    CQ[1] = CQ0
    t[1] = 0.0
    for i in 2:nsteps
        CP[i] = CP[i-1] - k2 * CP[i-1] * dt + km2 * CQ[i-1] * dt
        CQ[i] = CP0 + CQ0 - CP[i]
        t[i] = t[i-1] + dt
    end
    return t, CP, CQ
end

t, CP, CQ = simulation(10.0, 50.0, 0.003, 0.006, 100.0)

function f(P, CAexp)
    f_val = 0.0 #fiz esta alteração pq estava dando erro
    for i in 1:length(CAexp)
        f_val += (CAexp[i] - P[i])^2
    end
    return f_val
end

# Avaliar a similaridade
similaridade = f(CP, CAexp)

# Exibir a similaridade
println("Similaridade entre os resultados simulados e experimentais: ", similaridade)


