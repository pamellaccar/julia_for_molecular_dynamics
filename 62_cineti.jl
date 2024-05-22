#= Modifique a função e o programa simplex para passar todos os dados como
parâmetros. Teste. O resultado deve ser o mesmo e, talvez, seja possível
perceber que ficou mais rápido.
=#

using DelimitedFiles

function computef(CP0, CQ0, k2, km2, time, dt=1.e-1)
    data = readdlm(filename)
    CAexp = data[:, 2]
    CBexp = data[:, 3]
    return CAexp, CBexp
end

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

function f(k2, km2, max_t, CAexp, CP0, CQ0)
    t_sim, CP = simulation(k2, km2, max_t, CP0, CQ0)
    f_val = sum((CAexp[i] - CP[i])^2 for i in eachindex(CAexp, CP))
    return f_val
end

function simplex(f, x0, niter, CAexp, CP0, CQ0, max_t)
    x = copy(x0)
    fx = f(x, max_t, CAexp, CP0, CQ0)
    convcrit = 1e-10

    for iter in 1:niter
        if f(x, max_t, CAexp, CP0, CQ0) < fx
            fx = f(x, max_t, CAexp, CP0, CQ0)
        end

        xav = 0.5 * (x[1] + x[2])
        xtrial = x[end] + 2 * (xav - x[end])
        ftrial = f(xtrial, max_t, CAexp, CP0, CQ0)

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
                ftemp = f(xtemp, max_t, CAexp, CP0, CQ0)
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
CAexp, CBexp = read_data(dados_filename)

# Defina t aqui
t = [0.0]

# Parâmetros iniciais para o Simplex (k2 e km2)
x0 = [0.003, 0.006]

# Valores iniciais de CP0 e CQ0
CP0, CQ0 = 10.0, 50.0

# Minimizando
niter = 1000
simplex((x, max_t, CAexp, CP0, CQ0) -> f(x[1], x[2], max_t, CAexp, CP0, CQ0), x0, niter, CAexp, CP0, CQ0, maximum(t))
