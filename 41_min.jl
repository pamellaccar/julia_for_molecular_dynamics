using Plots
# Inicializando um vetor para armazenar os valores
valores = zeros(2000)

# Loop para gerar e armazenar os valores aleatórios
for i in 1:2000
    valores[i] = rand(1:2000)
end

#gerando um gráfico dos números aleatórios 
plot(valores, size=(1000, 400), framestyle=:box, xlabel="random", ylabel="values", label="")
#savefig("plot41.png")
