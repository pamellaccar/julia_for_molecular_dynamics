#=Crie diferentes funções, com diferentes números de variáveis, e teste o método
acima.=#

#Exemplos usando três métodos diferentes do pacote Optim (gradiente descendente):

using Optim

# Definindo uma função quadrática multivariada
quad(x) = x' * [2.0 0.5; 0.5 1.0] * x

function grad_quad(x)
    return 2 * [2.0*x[1] + 0.5*x[2], 0.5*x[1] + x[2]]
end
x0 = [0.0, 0.0]

# Minimizando a função usando o método de gradiente descendente
result = optimize(quad, grad_quad, x0, GradientDescent())
minimum_value = Optim.minimum(result)
argmin_value = Optim.minimizer(result)

println("Valor mínimo: ", minimum_value)
println("Argumento que minimiza a função: ", argmin_value)
