#= Use o método para obter as constantes de velocidade da reação química que
estudamos, substituindo o seu simplex por esta implementação.=#

using Optim
using Plots
using DelimitedFiles

function read_data(filename)
    data = readdlm(filename)
    CAexp = data[:, 2]
    CBexp = data[:, 3]
    return CAexp, CBexp
end

function simulation(k2, km2, time, CP0, CQ0, dt)
    nsteps = max(1, Int64(time / dt))
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
    return t, CP
end

function f(x, data, max_t)
    CAexp, CBexp = data
    k2, km2 = x
    CP0, CQ0 = 10.0, 50.0
    dt = 1.e-1

    t_sim, CP = simulation(k2, km2, max_t, CP0, CQ0, dt)
    f_val = sum((CAexp[i] - CP[i])^2 for i in eachindex(CAexp, CP))
    return f_val
end

# Leitura dos dados no programa principal
dados_filename = "55_cineti.jl"
data = read_data(dados_filename)

# Defina t aqui
t = [0.0]

# Parâmetros iniciais para o Optim (k2 e km2)
x0 = [0.003, 0.006]

# Função objetivo para o Optim
objective(x) = f(x, data, maximum(data[1]))

# Minimizando a função objetivo usando o método de gradiente descendente do Optim
result = optimize(objective, x0, GradientDescent())

# Extraindo o resultado
k_optimal = Optim.minimizer(result)

println("Constantes de Velocidade Ótimas: k2 = ", k_optimal[1], ", km2 = ", k_optimal[2])
