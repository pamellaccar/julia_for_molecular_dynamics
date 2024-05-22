#= Substitua a subrotina que calcula a função no programa Simplex da Se-
ção 4.3. Cuidado com os nomes das variáveis, porque as constantes de
velocidade tomarão o lugar do vetor x. =#

using DelimitedFiles

function computef(CP0, CQ0, k2, km2, time, dt=1.e-1)
    dataexp = readdlm("55_cineti.jl")
    CAexp = data[:, 2]
    CBexp = data[:, 3]
   
    function simulation(CP0, CQ0, k2, km2, time, dt=1.e-1)
        CP0, CQ0 = 10.0, 50.0
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
        CAexp, CBexp = dataexp(dados_filename)
        f_val = 0.0
        for i in 1:length(CAexp)
            f_val += (CAexp[i] - P[i])^2
        end
        return f_val
    end
end 

function simplex(f, x0, niter, convcrit = 1e-10)
    x = copy(x0)
    fx = f(x)
    
    for iter in 1:niter
        if fx > f(x)
            fx = f(x)
        end

        xav = 0.5 * (x[1] + x[2])
        xtrial = x[end] + 2 * (xav - x[end])
        ftrial = f(xtrial)

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
                ftemp = f(xtemp)
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


x0 = [0.003, 0.006] # Parâmetros iniciais para o Simplex (k2 e km2)
CP0, CQ0, k2, km2, time = 10.0, 50.0, 0.003, 0.006, 100.0 
dados_filename = "55_cineti.jl"

# Minimizando
niter = 1000
simplex(computef,x0,niter)
