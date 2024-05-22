#=Crie diferentes funções, com diferentes números de variáveis, e teste o método
acima.=#

#Exemplos usando três métodos diferentes do pacote Optim (Newton):
using Optim

# Definindo uma função quadrática multivariada
quad(x) = x' * [1.0 0.5; 0.5 1.0] * x
x0 = [0.0, 0.0]

# Minimizando a função usando o método de Newton
result = optimize(quad, x0, Newton())
minimum_value = Optim.minimum(result)
argmin_value = Optim.minimizer(result)

println("Valor mínimo: ", minimum_value)
println("Argumento que minimiza a função: ", argmin_value)
