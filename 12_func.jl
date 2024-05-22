#=Verifique que, nesta última versão, o resultado da função é o mesmo, mas o
vetor externo a ela não foi modificado.=#

function f(x :: Vector)
    y = copy(x)
    y[1] = y[1] + 1
    return y
end