using Pkg;
using LinearAlgebra;

function rijesi_simplex(A,b,c)
  S=[transpose(b) A I(length(b)) ; 0 c zeros(1,length(b))]
  baza=collect(length(c)+1 :1: length(c)+length(b))
  broj_promjenjivih=size(A,1)
  n=length(b)+1
  m=length(b)+size(A,1)+1
  optimalno = false
  pivot_col_index=0
  pivot_row_index=0
  while !optimalno  
    cmax = -1
    
    for i=2:m
      if S[n,i]>cmax && S[n,i]>0
        cmax = S[n,i]
        pivot_col_index=i
      end
    end

    if cmax==-1  
      optimalno=true
    else 
      min=Inf
    
      pivot_row_index=1
      for i=1:n-1
        if S[i,pivot_col_index]>0
          if S[i,1]/S[i,pivot_col_index] < min
            min = S[i,1]/S[i,pivot_col_index]
            pivot_row_index=i
          end
        end
      end
    
      baza[pivot_row_index] = pivot_col_index-1
      pivot = S[pivot_row_index,pivot_col_index]
      for i=1:m
        S[pivot_row_index,i] = S[pivot_row_index,i]/pivot
      end
    
      for i=1:n
        if i!=pivot_row_index
          koeficijent = S[i,pivot_col_index]
          for j=1:m
            S[i,j] = S[i,j] - S[pivot_row_index,j]*koeficijent
          end
        end
      end
    end
  end
  j=1
  promjenjive=collect(1:1:broj_promjenjivih)
  for i=1:broj_promjenjivih
    if i in baza
      promjenjive[i]=S[j,1]
      j=j+1
    else
      promjenjive[i]=0
    end
  end
  return -S[n,1], promjenjive[1:broj_promjenjivih]
end

A = [0.5 0.3; 0.1 0.2];
b=[150 60]
c=[3 1]

s,x = rijesi_simplex(A,b,c)