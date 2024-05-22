using DelimitedFiles

function computef(CP0, CQ0, k2, km2, time)
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

    function f(CP, CAexp)
        f_val = 0.0
        for i in 1:length(CAexp)
            f_val += (CAexp[i] - P[i])^2
        end
        return f_val
    end

    # Leitura dos dados experimentais
    CAexp, CBexp = dados_experimentais(dados_filename)

    # Avaliar a similaridade
    similaridade = f(CP, CAexp)

    return similaridade
end

# Parâmetros iniciais para a simulação
CP0, CQ0, k2, km2, time = 10.0, 50.0, 0.003, 0.006, 100.0

# Chamar a função computef
similaridade_result = computef(CP0, CQ0, k2, km2, time)

# Exibir a similaridade
println("Similaridade entre os resultados simulados e experimentais: ", similaridade_result)
