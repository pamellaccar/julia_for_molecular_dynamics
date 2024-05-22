#=Modifique o programa da atividade 61 usando esta forma de passar os parâ-
metros. Lembre-se de eliminar as variáveis globais.=#

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

function simplex(f, x0, data, niter)
    x = copy(x0)
    fx = f(x, data, maximum(data[1]))

    convcrit = 1e-10
    for iter in 1:niter
        if f(x, data, maximum(data[1])) < fx
            fx = f(x, data, maximum(data[1]))
        end

        xav = 0.5 * (x[1] + x[2])
        xtrial = x[end] + 2 * (xav - x[end])
        ftrial = f(xtrial, data, maximum(data[1]))

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
                ftemp = f(xtemp, data, maximum(data[1]))
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
data = read_data(dados_filename)

# Defina t aqui
t = [0.0]

# Parâmetros iniciais para o Simplex (k2 e km2)
x0 = [0.003, 0.006]

# Minimizando
niter = 1000
simplex((x, data) -> f(x, data, maximum(data[1])), x0, data, niter)
