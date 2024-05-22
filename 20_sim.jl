function sim1( CA0, k1, time )
    dt = 1.e-1 # Time-step
    nsteps = Int64(time/dt) # Number of steps
    t = Vector{Float64}(undef,nsteps)
    CA = Vector{Float64}(undef,nsteps)
    CA[1] = CA0
    t[1] = 0.
    for i in 2:nsteps
        CA[i] = CA[i-1] - k1*CA[i-1]*dt
        t[i] = t[i-1]+dt
    end
    return t, CA
end

t, c = sim1( 10. , 0.2, 100. )
plot(t,c,xlabel="time",ylabel="[A]", label="CA")

nsteps = length(t)
CA_exact = Vector{Float64}(undef,nsteps)
for i in 1:length(CA_exact)
CA_exact[i] = CA0*exp(-k1*t[i])
end
 plot!(t,CA_exact,label="Exact")