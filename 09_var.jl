#=Produto interno de dois vetores
A função sum() retorna a soma dos elementos de um vetor. Combine as
informações que você já aprendeu com esta e calcule o produto interno de
depois vetores.=#

a = [2, 3]
b = [3, 4]
c = [4, 5]
prod = sum(a.*b.*c) #multiplicação ponto a ponto (elemento a elemento em arrays)
println(prod)

#= Isso significa que cada elemento correspondente nos arrays a, b e c é multiplicado 
entre si para criar um novo array resultante. =#