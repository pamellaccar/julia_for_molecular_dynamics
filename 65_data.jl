#=Defina uma estrutura com seus dados, inicialize uma variável com os dados,
e execute o programa com a nova forma de passar os dados.=#

using DelimitedFiles

# Definindo a estrutura OptimizationData
struct OptimizationData
    filename::String
    t::Vector{Float64}
    x0::Vector{Float64}
    niter::Int
    CP0::Float64
    CQ0::Float64
end

# Função para ler dados do arquivo
function read_data(filename)
    data = readdlm(filename)
    CAexp = data[:, 2]
    CBexp = data[:, 3]
    return CAexp, CBexp
end

# Função de simulação
function simulation(k2, km2, time, CP0, CQ0)
    dt = 1.e-1
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

# Função objetivo
function f(k2, km2, max_t, CAexp, CP0, CQ0)
    t_sim, CP = simulation(k2, km2, max_t, CP0, CQ0)
    f_val = sum((CAexp[i] - CP[i])^2 for i in eachindex(CAexp, CP))
    return f_val
end

# Função Simplex
function simplex(data::OptimizationData)
    CAexp, CBexp = read_data(data.filename)

    x = copy(data.x0)
    fx = f(x, maximum(data.t), CAexp, data.CP0, data.CQ0)

    for iter in 1:data.niter
        if f(x, maximum(data.t), CAexp, data.CP0, data.CQ0) < fx
            fx = f(x, maximum(data.t), CAexp, data.CP0, data.CQ0)
        end

        xav = 0.5 * (x[1] + x[2])
        xtrial = x[end] + 2 * (xav - x[end])
        ftrial = f(xtrial, maximum(data.t), CAexp, data.CP0, data.CQ0)

        if ftrial < fx
            x[end] = xtrial
            fx = ftrial
            println(" ponto aceito: ", x[end], " f = ", fx)
        else
            println(" A função está aumentando ")
            xtemp = copy(x) 
            ftemp = fx
            for j in 1:10
                xtemp[end] = x[end] + rand() * (xtrial - x[end])
                ftemp = f(xtemp, maximum(data.t), CAexp, data.CP0, data.CQ0)
                if ftemp < fx
                    x[end] = xtemp[end]
                    fx = ftemp
                    println("busca linear passou no teste ", j)
                    println(" novo ponto: ", x[end], " f = ", fx)
                    break
                end
            end

            if ftemp > fx
                println(" Melhor ponto: ", x[1], " f = ", fx)
                return x[1], fx
            end
        end
    end

    println(" Número máximo de testes. ")
    println(" Melhor ponto: ", x[1], " f = ", fx)
    return x[1], fx
end

# Definindo dados para otimização
dados_otimizacao = OptimizationData(
    filename = "55_cineti.jl",
    t = [0.0],
    x0 = [0.003, 0.006],
    niter = 1000,
    CP0 = 10.0,
    CQ0 = 50.0
)

# Chamando a função simplex com os dados encapsulados
simplex(dados_otimizacao)
