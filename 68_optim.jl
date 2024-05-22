#=Crie diferentes funções, com diferentes números de variáveis, e teste o método
acima.=#

#Exemplos usando três métodos diferentes do pacote Optim (BFGS):
using Optim

# Definindo a função que queremos minimizar
f(x) = (x - 3)^2 + 5
x0 = [0.0]

# Minimizando a função usando o método de BFGS
result = optimize(f, x0, BFGS())
minimum_value = Optim.minimum(result)
argmin_value = Optim.minimizer(result)

println("Valor mínimo: ", minimum_value)
println("Argumento que minimiza a função: ", argmin_value)


