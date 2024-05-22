#laços break x continue 
for i in 1:10
    if i == 7
        continue
    end
    println(i)
end

#= solução
1
2
3
4
5
6
8
9
10
=#

for i in 1:10
    if i == 7
        break
    end
    println(i)
end

#= solução
1
2
3
4
5
6
=#