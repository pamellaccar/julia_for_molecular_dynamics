#= Defina uma estrutura que tenha o nome (tipo String), idade e altura de
uma pessoa, inicialize-a com seus dados, e teste o acesso às informações que
ela contém. =#

struct Pessoa
    nome::String
    idade::Int
    altura::Float64
end

# Criando uma instância da estrutura Pessoa
pessoa1 = Pessoa("Pamella", 30, 1.77)

# Acessando as informações
println("Nome: ", pessoa1.nome)
println("Idade: ", pessoa1.idade)
println("Altura: ", pessoa1.altura)
