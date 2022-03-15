function [C, counter_operation] = MatMulStrassen(A,B)
  sza = size(A);
  szb = size(B);
  counter_operation = 0;
  if(sza(1)~=szb(1) || sza(2)~=szb(2))
    disp('Nie odpowiednie rozmiary macierzy');
    C(1:sza(2),1:szb(1))=0;
    return
  end
  if(~IsPow2(sza(1)) || ~IsPow2(sza(2)) || ~IsPow2(szb(1)) || ~IsPow2(szb(2)))
    disp('Rozmiary nie s? pot?gami 2');
    C(1:sza(2),1:szb(1))=0;
    return
  end
  
  n = sza(1);
  nhalf = n/2;
  
  % podzial macierzy na bloki
  A11 = A(1:nhalf,1:nhalf);
  A21 = A(nhalf+1:n,1:nhalf);
  A12 = A(1:nhalf,nhalf+1:n);
  A22 = A(nhalf+1:n,nhalf+1:n);
  
  B11 = B(1:nhalf,1:nhalf);
  B21 = B(nhalf+1:n,1:nhalf);
  B12 = B(1:nhalf,nhalf+1:n);
  B22 = B(nhalf+1:n,nhalf+1:n);
  
  % wyliczenie odpowiednich wartosci P
  if(n==2)
    P1 = (A11+A22) * (B11+B22);
    P2 = (A21+A22) * (B11);
    P3 = (A11) * (B12-B22);
    P4 = (A22) * (B21-B11);
    P5 = (A11+A12) * (B22);
    P6 = (A21-A11) * (B11+B12);
    P7 = (A12-A22) * (B21+B22);
    counter_operation = counter_operation  + 7*8 + 10*4;
  else
    [P1, c_P1]  = MatMulStrassen(A11+A22,  B11+B22);
    [P2, c_P2] = MatMulStrassen(A21+A22,  B11);
    [P3, c_P3] = MatMulStrassen(A11,      B12-B22);
    [P4, c_P4] = MatMulStrassen(A22,      B21-B11);
    [P5, c_P5] = MatMulStrassen(A11+A12,  B22);
    [P6, c_P6] = MatMulStrassen(A21-A11,  B11+B12);
    [P7, c_P7] = MatMulStrassen(A12-A22,  B21+B22);
    counter_operation = c_P1 + c_P2 + c_P3 + c_P4 + c_P5 + c_P6 + c_P7 + 10*(n*n);
  end
  
  % wykorzystanie P do obliczenia blokow wynikowej macierzy
  C(1:nhalf,1:nhalf)      = P1 + P4 - P5 + P7;
  C(1:nhalf,nhalf+1:n)    = P3 + P5;
  C(nhalf+1:n,1:nhalf)    = P2 + P4;
  C(nhalf+1:n,nhalf+1:n)  = P1 - P2 + P3 + P6;
  
  return
end