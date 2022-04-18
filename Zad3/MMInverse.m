function [C, operations] = MMInverse(inputM)
    operations = 0;
    sza = size(inputM);
    
    n = sza(1);
    if(n == 1)
      if(inputM == 0)
          disp("ERROR C == 0");
      end
      C = 1/inputM;
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
    
    [iA11, iA11_Ops] = MMInverse(A11);

    % S22 = A22 - A21 * iA11 * A12;
    [A21iA11, A21iA11_Ops] = MatMulMix(A21, iA11, L);
    [A21iA11A12, A21iA11A12_Ops] = MatMulMix(A21iA11, A12, L);
    S22_Ops = nhalf * nhalf;
    S22 = A22 - A21iA11A12;

    [iS22, iS22_Ops] = MMInverse(S22);

    % B11 = iA11 + iA11 * A12 * iS22 * A21 * iA11;
    [iA11A12, iA11A12_Ops] = MatMulMix(iA11, A12, L);
    [iA11A12iS22, iA11A12iS22_Ops] = MatMulMix(iA11A12, iS22, L);
    [iA11A12iS22A21, iA11A12iS22A21_Ops] = MatMulMix(iA11A12iS22, A21, L);
    [iA11A12iS22A21iA11, iA11A12iS22A21iA11_Ops] = MatMulMix(iA11A12iS22A21, iA11, L);
    B11_Ops = nhalf * nhalf;
    B11 = iA11 + iA11A12iS22A21iA11;

    % B12 = - (iA11 * A12 * iS22);
    %[iA11A12, iA11A12_Ops] = MatMulMix(iA11, A12, L); % policzone w B11
    % [iA11A12iS22, iA11A12iS22_Ops] = MatMulMix(iA11A12, iS22, L); % policzone w B11
    B12_Ops = nhalf * nhalf;
    B12 = - iA11A12iS22;

    % B21 = - (iS22 * A21 * iA11);
    [iS22A21, iS22A21_Ops] = MatMulMix(iS22, A21, L);
    [iS22A21iA11, iS22A21iA11_Ops] = MatMulMix(iS22A21, iA11, L);
    B21_Ops = nhalf * nhalf;
    B21 = - iS22A21iA11;

    B22 = iS22;
    
    C(1:nhalf,1:nhalf)      = B11;
    C(1:nhalf,nhalf+1:n)    = B12;
    C(nhalf+1:n,1:nhalf)    = B21;
    C(nhalf+1:n,nhalf+1:n)  = B22;
    operations = operations + iA11_Ops + A21iA11_Ops + A21iA11A12_Ops + S22_Ops + iS22_Ops + iA11A12_Ops + iA11A12iS22_Ops + iA11A12iS22A21_Ops + iA11A12iS22A21iA11_Ops + ...
        B11_Ops + B12_Ops + iS22A21_Ops + iS22A21iA11_Ops + B21_Ops;
end

