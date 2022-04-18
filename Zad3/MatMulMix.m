function [C, counter_operation] = MatMulMix(A,B, L)
  sza = size(A);
  szb = size(B);

  counter_operation = 0;

  n = sza(1);
  nhalf = n/2;
  
  %tradycyjne mnożenie macierzy dla odpowiednio małych macierzy
  if(n <= 2^L)
    [C, counter_operation] = MatMulSimple(A,B);		%tradycyjne mnożenie macierzy O(n3)
    return;
  end
  
  % wyliczenie odpowiednich wartosci P
  if(n==2)
    P1 = (A(1:nhalf,1:nhalf) + A(nhalf+1:n,nhalf+1:n))      * (B(1:nhalf,1:nhalf) + B(nhalf+1:n,nhalf+1:n));
    P2 = (A(nhalf+1:n,1:nhalf) + A(nhalf+1:n,nhalf+1:n))    * (B(1:nhalf,1:nhalf));
    P3 = (A(1:nhalf,1:nhalf))                               * (B(1:nhalf,nhalf+1:n) - B(nhalf+1:n,nhalf+1:n));
    P4 = (A(nhalf+1:n,nhalf+1:n))                           * (B(nhalf+1:n,1:nhalf) - B(1:nhalf,1:nhalf));
    P5 = (A(1:nhalf,1:nhalf) + A(1:nhalf,nhalf+1:n))        * (B(nhalf+1:n,nhalf+1:n));
    P6 = (A(nhalf+1:n,1:nhalf) - A(1:nhalf,1:nhalf))        * (B(1:nhalf,1:nhalf) + B(1:nhalf,nhalf+1:n));
    P7 = (A(1:nhalf,nhalf+1:n) - A(nhalf+1:n,nhalf+1:n))    * (B(nhalf+1:n,1:nhalf) + B(nhalf+1:n,nhalf+1:n));
    counter_operation = counter_operation + 10*(n*n) + 7*8;
    % + + 7*8  
  else
    [P1, c_P1] = MatMulMix(A(1:nhalf,1:nhalf) + A(nhalf+1:n,nhalf+1:n),       B(1:nhalf,1:nhalf) + B(nhalf+1:n,nhalf+1:n),      L);
    [P2, c_P2] = MatMulMix(A(nhalf+1:n,1:nhalf) + A(nhalf+1:n,nhalf+1:n),     B(1:nhalf,1:nhalf),                             L);
    [P3, c_P3] = MatMulMix(A(1:nhalf,1:nhalf),                                B(1:nhalf,nhalf+1:n) - B(nhalf+1:n,nhalf+1:n),    L);
    [P4, c_P4] = MatMulMix(A(nhalf+1:n,nhalf+1:n),                            B(nhalf+1:n,1:nhalf) - B(1:nhalf,1:nhalf),        L);
    [P5, c_P5] = MatMulMix(A(1:nhalf,1:nhalf) + A(1:nhalf,nhalf+1:n),         B(nhalf+1:n,nhalf+1:n),                         L);
    [P6, c_P6] = MatMulMix(A(nhalf+1:n,1:nhalf) - A(1:nhalf,1:nhalf),         B(1:nhalf,1:nhalf) + B(1:nhalf,nhalf+1:n),        L);
    [P7, c_P7] = MatMulMix(A(1:nhalf,nhalf+1:n) - A(nhalf+1:n,nhalf+1:n),     B(nhalf+1:n,1:nhalf) + B(nhalf+1:n,nhalf+1:n),    L);
    counter_operation = c_P1 + c_P2 + c_P3 + c_P4 + c_P5 + c_P6 + c_P7 + 10*(n*n);
  end
  
  % wykorzystanie P do obliczenia blokow wynikowej macierzy
  C(1:nhalf,1:nhalf)      = P1 + P4 - P5 + P7;
  C(1:nhalf,nhalf+1:n)    = P3 + P5;
  C(nhalf+1:n,1:nhalf)    = P2 + P4;
  C(nhalf+1:n,nhalf+1:n)  = P1 - P2 + P3 + P6;
  
  return
end
