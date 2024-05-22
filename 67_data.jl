#= Verifique o que acontece se você chama a função com dados que não corres-
pondem a nenhum dos conjuntos de tipos dos métodos que foram definidos.
A definição obsessiva dos tipos é muito importante, em geral, para evitar
erros na programação e no uso das funções.


R= Chamar uma função com dados que não correspondem aos tipos esperados gerará um erro indicando 
que não é possível encontrar um método apropriado. Isso pode acontecer em tipos incorretos para x0, 
data ou niter, por exemplo.=#

#Isso poderia ser observado na chamada do simplex:
x0 = [0.003, "0.006"]
data = ([1.0, 2.0], ["a", "b"])
niter = 1000.5

try
    simplex((x, data) -> f(x, data, maximum(data[1])), x0, data, niter)
catch e
    println("Erro: ", e)
end
