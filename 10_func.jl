#=Crie um arquivo que contenha uma função f (x). Carregue o arquivo como
mencionado acima e calcule o valor da função em um ponto, no modo inte-
rativo=#

function test(x)
    y = x + 2
    return y
end

#=
julia> include("10_func.jl")

julia> test(6)
8
=#