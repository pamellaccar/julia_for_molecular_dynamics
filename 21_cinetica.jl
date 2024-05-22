#discretização equações diferenciais de [A] e [B]

-[A]*(t+dt) = [A]*(t)-(k1*[A]-km1*[B])*(t)*dt
[B]*(t+dt) = [B]*(t)-(k1*[A]-km1[B])*(t)*dt


CA[i] = CA[i-1] - k1*CA[i-1]*dt + km1*CB[i-1]*dt
CB[i] = CB[i-1] + k1*CA[i-1]*dt - km1*CB[i-1]*dt