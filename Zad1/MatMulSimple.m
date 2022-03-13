function [C,counter_operation] = MatMulSimple(A,B)
  counter_operation = 0;
  sza = size(A);
  szb = size(B);
  if(sza(2)~=szb(1))
    disp('Nie odpowiednie rozmiary macierzy');
    return
  end
  C(1:sza(2),1:szb(1))=0;
  for i=1:sza(2)
    for j=1:szb(1)
      for k=1:sza(1) %lub szb(2)
        C(i,j) = C(i,j) + A(i,k)*B(k,j);
        counter_operation = counter_operation + 1;
      end
    end    
  end
end