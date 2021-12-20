function nadji_pocetno_SZU(C,I,O)
    n,m=size(C,1), size(C,2)
    A = zeros(n,m)
    ukupnaSuma = sum(O)
    trenutnaSuma = 0
    i,j=1,1
    while trenutnaSuma!=ukupnaSuma
        if I[i]==O[j]
            trenutnaSuma = trenutnaSuma + I[i]
            A[i,j] += I[i]
            i=i+1
            j=j+1
        elseif I[i]>O[j]
            trenutnaSuma = trenutnaSuma + O[j]
            A[i,j] += O[j]
            I[i] = I[i] - O[j]
            j=j+1
        else
            trenutnaSuma = trenutnaSuma + I[i]
            A[i,j] += I[i]
            O[j] = O[j] - I[i]
            i=i+1
        end
    end    
    return sum(A.*C),A
end    

I=[20,15,40]
O=[20,30,25]
C=[2 3 1; 5 4 8; 5 6 8]
optimal, A = nadji_pocetno_SZU(C,I,O);
optimal