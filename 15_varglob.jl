#laço de escopo global:
x = 1 
function f()
    global x 
    for i in 1:2
        println(" volta: ",i)
        if i == 1
            y = 1
        end
        println(" y = ",y)
    end
end;