#discretização no lugar do balanço de massa
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
        CB[i] = CB[i-1] + k1*CA[i-1]*dt - km1*CB[i-1]*dt
        t[i] = t[i-1] + dt
    end
    return t, CA, CB
end

using Plots
t, CA, CB = sim2(10., 50., 0.2, 0.7, 100.)
plot(t,CA, xlabel="time",ylabel="[A]")
plot!(t, CB)
#savefig("plot23.png")