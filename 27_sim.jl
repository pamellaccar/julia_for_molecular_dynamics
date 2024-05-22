#outra possibilidade de resolucao: usando uma logica diferente das demais questoes

using DifferentialEquations

# Define as equações diferenciais para o mecanismo reacional
function ozon!(du, u, p, t)
    CFCl3, Cl, O3, ClO, O2 = u
    k1, k2, k3, k4 = p
    
    du[1] = -k1 * CFCl3  # Taxa de mudança de CFCl3
    du[2] = k1 * CFCl3 - k2 * Cl * O3  # Taxa de mudança de Cl
    du[3] = -k2 * Cl * O3 - k3 * ClO * O3  # Taxa de mudança de O3
    du[4] = k2 * Cl * O3 - k3 * ClO * O3  # Taxa de mudança de ClO
    du[5] = k3 * ClO * O3  # Taxa de mudança de O2
end

# Condições iniciais e parâmetros
u0 = [1.0, 0.0, 1.0, 0.0, 0.0]  # Condições iniciais [CFCl3, Cl, O3, ClO, O2]
p = [1.0, 2.0, 1.0, 1.0]  # Parâmetros [k1, k2, k3, k4]

# Intervalo de tempo
tspan = (0.0, 100.0)  # Tempo inicial e final

# Resolver as equações diferenciais
prob = ODEProblem(ozon!, u0, tspan, p)
sol = solve(prob, Tsit5())

using Plots

# Plotar as concentrações versus tempo
plot(sol, xlabel="Tempo (s)", ylabel="Concentração",
    label=["CFCl3" "Cl" "O3" "ClO" "O2"], legend=true)
