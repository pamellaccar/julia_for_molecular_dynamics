#erro no balanço de massa
using Plots

function sim2( CA0, CB0, k1, km1, time, dt)
  nsteps = Int64(time/dt)

  t = Vector{Float64}(undef,nsteps)
  CA = Vector{Float64}(undef,nsteps)
  CB = Vector{Float64}(undef,nsteps)
  err = Vector{Float64}(undef,nsteps)

  CA[1] = CA0
  CB[1] = CB0
  err[1] = 0.
  t[1] = 0.
  for i in 2:nsteps
    CA[i] = CA[i-1] - k1*CA[i-1]*dt + km1*CB[i-1]*dt
      
    CB[i] = CB[i-1] + k1*CA[i-1]*dt - km1*CB[i-1]*dt
      
    err[i] = abs(CA0 + CB0 - CA[i] - CB[i])
      
    t[i] = t[i-1] + dt
  end
  return t, CA, CB, err
end

dt = 1e-6
t, CA, CB, err = sim2(10.,50.,1e-2,1e-6, 100., dt)
@show mean(err)

plot(t, err, label = "dt = $dt")

#reduzir o valor de dt  e das constantes aumenta o erro até certo ponto onde ele começa a diminuir
