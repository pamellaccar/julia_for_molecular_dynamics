#=Escreva o laço explícito que faz o produto componente a componente dos
vetores, e salva o resultado em um terceiro vetor. =#

x = [ 2, 3 ]; y = [ 3, 4 ];
z = similar(x)
for i in 1:2 
    z[i] = x[i] * y[i]
    end
println(z)


#=for i in 1:2 cria um loop que itera sobre os valores no intervalo de 1 a 2, inclusive. Neste caso específico, 
o loop irá iterar duas vezes, uma vez com i assumindo o valor 1 e depois com i assumindo o valor 2. 
O loop começa com i igual a 1 e, em seguida, executa o bloco de código dentro do loop (no caso, 
apenas a instrução println(i)). Depois disso, ele incrementa i para 2 e executa o bloco de código novamente. 
Quando i se torna 3, o loop termina porque atingiu o limite superior do intervalo (2, no caso). =#