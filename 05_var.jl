#= Em Julia, você pode definir um número real de 32 bits usando a notação,
por exemplo, 1.f0, 1.f10, etc. Repita o exemplo anterior para descobrir
quantas ordens de grandeza diferentes são tratáveis com números reais de
32 bits. =#

#Número de 32bits (notação 1.f0)
valor = 1.f0; count = 0
       while !isinf(valor*10)
           count += 1
           valor *= 10
       end
       valor, count
(1.0000001f38, 38)

# oito ordens de grandeza 
1.f8 + 1
1.0f8
1.f7 + 1
1.0000001f7

