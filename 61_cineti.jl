#=  Modifique o seu programa da atividade anterior de tal forma que a leitura
dos dados seja feita uma única vez.=#

using DelimitedFiles

# Variáveis globais para armazenar os dados
global CAexp
global CBexp

function read_data(filename)
    data = readdlm(filename)
    global CAexp = data[:, 2]
    global CBexp = data[:, 3]
end

function simulation(k2, km2, time)
    CP0, CQ0 = 10.0, 50.0
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

function f(k2, km2, max_t)
    t_sim, CP = simulation(k2, km2, max_t)
    f_val = sum((CAexp[i] - CP[i])^2 for i in eachindex(CAexp, CP))
    return f_val
end

function simplex(f, x0, niter)
    x = copy(x0)
    fx = f(x, maximum(t))
    convcrit = 1e-10

    for iter in 1:niter
        if f(x, maximum(t)) < fx
            fx = f(x, maximum(t))
        end

        xav = 0.5 * (x[1] + x[2])
        xtrial = x[end] + 2 * (xav - x[end])
        ftrial = f(xtrial, maximum(t))

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
                ftemp = f(xtemp, maximum(t))
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

# Leitura dos dados no programa principal
dados_filename = "55_cineti.jl"
read_data(dados_filename)

# Defina t aqui
global t = [0.0]

# Parâmetros iniciais para o Simplex (k2 e km2)
x0 = [0.003, 0.006]

# Minimizando
niter = 1000
simplex((x, max_t) -> f(x[1], x[2], max_t), x0, niter)
