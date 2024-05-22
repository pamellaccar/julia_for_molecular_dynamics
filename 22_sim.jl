function sim2( CA0, CB0, k1, km1, time)
    dt = 1.e-1 # Time-step
    nsteps = Int64(time/dt) # Number of steps
    t = Vector{Float64}(undef,nsteps)
    CA = Vector{Float64}(undef,nsteps)
    CB = Vector{Float64}(undef,nsteps)
    CA[1] = CA0
    CB[1] = CB0
    t[1] = 0.
    for i in 2:nsteps
        CA[i] = CA[i-1] - k1*CA[i-1]*dt + km1*CB[i-1]*dt
        CB[i] = CA0 + CB0 - CA[i]
        t[i] = t[i-1] + dt
    end
    return t, CA, CB 
end

# salvando em um arquivo para atividade 55 da apostila
results = hcat(t, CA, CB)
open("55_cineti.jl", "w") do io
    #println(io, "Time\tCA\tCB")
        #println(io, "$t\t$CA\t$CB")

    for row in eachrow(results)
        println(io, join(row, "\t"))
    end
end

using Plots
t, CA, CB = sim2(10., 50., 0.05, 0.07, 100.)
plot(t, CA, xlabel="time",ylabel="[C]")
plot!(t, CB)