function [C, counter_operation] = MatMulMix(A,B, L)
  sza = size(A);
  szb = size(B);
  if(sza(1)~=szb(1) || sza(2)~=szb(2))
    disp('Nie odpowiednie rozmiary macierzy');
    C(1:sza(2),1:szb(1))=0;
    return
  end
  if ~IsPow2(sza(1)) || ~IsPow2(sza(2)) || ~IsPow2(szb(1)) || ~IsPow2(szb(2)) 
    disp('Rozmiary nie sa potegami 2');
    C(1:sza(2),1:szb(1))=0;
    return
  end
  
  n = sza(1);
  
  % tradycyjne mnozenie macierzy dla odpowiednio ma?ych macierzy
  if(n <= 2^L)
    [C, counter_operation] = MatMulSimple(A,B);
    return;
  else 
    [C, counter_operation] = MatMulStrassen(A, B);
    return 
  end
  
end