function [C] = MatMulStrassen(A,B)
  max_recursion_depth (5000, "local")

  sza = size(A);
  szb = size(B);
  if(sza(1)!=szb(1) || sza(2)!=szb(2))
    disp('Nie odpowiednie rozmiary macierzy');
    C(1:sza(2),1:szb(1))=0;
    return
  endif
  if(!IsPow2(sza(1)) || !IsPow2(sza(2)) || !IsPow2(szb(1)) || !IsPow2(szb(2)))
    disp('Rozmiary nie s? pot?gami 2');
    C(1:sza(2),1:szb(1))=0;
    return
  endif
  
  n = sza(1);
    
  nhalf = n/2;
  
  A11 = A(1:nhalf,1:nhalf);
  A21 = A(nhalf+1:n,1:nhalf);
  A12 = A(1:nhalf,nhalf+1:n);
  A22 = A(nhalf+1:n,nhalf+1:n);
  
  B11 = B(1:nhalf,1:nhalf);
  B21 = B(nhalf+1:n,1:nhalf);
  B12 = B(1:nhalf,nhalf+1:n);
  B22 = B(nhalf+1:n,nhalf+1:n);
  
  if(n==2)
    P1 = (A11+A22) * (B11+B22);
    P2 = (A21+A22) * (B11);
    P3 = (A11) * (B12-B22);
    P4 = (A22) * (B21-B11);
    P5 = (A11+A12) * (B22);
    P6 = (A21-A11) * (B11+B12);
    P7 = (A12-A22) * (B21+B22);
  else
    P1 = MatMulStrassen(A11+A22,  B11+B22);
    P2 = MatMulStrassen(A21+A22,  B11);
    P3 = MatMulStrassen(A11,      B12-B22);
    P4 = MatMulStrassen(A22,      B21-B11);
    P5 = MatMulStrassen(A11+A12,  B22);
    P6 = MatMulStrassen(A21-A11,  B11+B12);
    P7 = MatMulStrassen(A12-A22,  B21+B22);
  endif
  
  C(1:nhalf,1:nhalf)      = P1 + P4 - P5 + P7;
  C(1:nhalf,nhalf+1:n)    = P3 + P5;
  C(nhalf+1:n,1:nhalf)    = P2 + P4;
  C(nhalf+1:n,nhalf+1:n)  = P1 - P2 + P3 + P6;
  return
endfunction