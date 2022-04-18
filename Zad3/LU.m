function [L, U, operations] = LU(inputM)
    operations = 0;
    sza = size(inputM);
   
    n = sza(1);

    if(n == 1)
      if(inputM == 0)
          disp("ERROR C == 0");
      end
      L = [1];
      U = inputM;
      operations = 1;
      return;
    end
    nhalf = n/2;
    L = 5;
    % podzial macierzy na bloki
    A11 = inputM(1:nhalf,1:nhalf);
    A12 = inputM(1:nhalf,nhalf+1:n);
    A21 = inputM(nhalf+1:n,1:nhalf);
    A22 = inputM(nhalf+1:n,nhalf+1:n);
    

    % rekurencyjnie [L11, U11] = LU(A11)
    [L11, U11, LU_A11_Ops] = LU(A11);

    % Oblicz rekurencyjnie U11^-1
    [iU11, iU11_Ops] = MMInverse(U11); 

    % L21 = A21 * U11^-1 

    [L21, L21_Ops] =  MatMulMix(A21, iU11, L);

    % Oblicz rekurencyjnie L11^-1
    [iL11, iL11_Ops] = MMInverse(L11);


    % U12  = L11^-1 * A12
    [U12, U12_Ops] =  MatMulMix(iL11, A12, L);

    % L22 = S = A22 - A21 * U11^-1 * L11^-1 * A12 
    
    [A21iU11, A21iU11_Ops] =  MatMulMix(A21, iU11, L);
    [A21iU11iL11, A21iU11iL11_Ops] =  MatMulMix(A21iU11, iL11, L);
    [A21iU11iL11A12, A21iU11iL11A12_Ops] =  MatMulMix(A21iU11iL11, A12, L);
       
    L22 = A22 - A21iU11iL11A12;
    S = L22;

    % Oblicz rekurencyjne [Ls,Us] = LU(S)

    [Ls, Us, S_Ops] = LU(S);
    U22 = Us;
    L22 = Ls;

    
    L(1:nhalf,1:nhalf)      = L11;
    L(1:nhalf,nhalf+1:n)    = 0;
    L(nhalf+1:n,1:nhalf)    = L21;
    L(nhalf+1:n,nhalf+1:n)  = L22;
    
    U(1:nhalf,1:nhalf)      = U11;
    U(1:nhalf,nhalf+1:n)    = U12;
    U(nhalf+1:n,1:nhalf)    = 0;
    U(nhalf+1:n,nhalf+1:n)  = U22;

    operations = operations + LU_A11_Ops + iU11_Ops + L21_Ops + iL11_Ops + U12_Ops + A21iU11_Ops + A21iU11iL11_Ops + ...
                 + A21iU11iL11A12_Ops + S_Ops;
end

