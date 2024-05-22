#=vetores em funções
defina x usando x = [ 2, 2 ]. (a diferença é que não há um ponto depois de cada número 2). O que aconteceu? =#

f(x :: Vector{Float64}) = 2*x

#Ao utilizar [2,2] como vetor, o código dá erro pois foi definido que a variável deveria ser ponto flutuante.