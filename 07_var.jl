#= Defina duas funções de mesmo nome, que recebem tipos diferentes, e mostre
como chamando a função com parâmetros diferentes uma o outra versão da
função é acionada.=#


function f(x :: Float64)
    return x^2 + x - 1.
    println(f(x)) 
end

function f(x :: Int64 )
    return x + 2
    println(f(x))
 end

#=f (generic function with 2 methods)

julia> x=4.5
4.5

julia> f(x)
23.75

julia> x=20
20

julia> f(x)
22

=#