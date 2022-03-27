function time = TimeFigure()
  
  max_l = 6;
  max_k = 9;

  hf = figure ();
  max_time = 0;
  indexL = 1;
  LStep = 5;
  Ls = 2:LStep:max_k;
  OPS = zeros(1,1);
  AvaliableLs = [2,6];
  %for l =  2:LStep:max_l
  for li = 1:length(AvaliableLs)
      l = AvaliableLs(li);
      times = 1:max_k;
      index = 1;
    
    
      for n = 2:max_k
        MatSize = 2^n;
        matrixA = randi([1 100],MatSize,MatSize);
        matrixB = randi([1 100],MatSize,MatSize);
 
        tic ();
        endVal = 1;
        if n < 5
            endVal = 10;
        elseif n < 10
            endVal = 2;
        end
        for rep = 1:endVal
            [~, operation] = MatMulMix(matrixA,matrixB, l);
        end
        elapsed_time = toc ();
        elapsed_time = elapsed_time / endVal;
        %disp(elapsed_time)
        times(index) = elapsed_time;
        fprintf('L = %d, size = %d, time = %f\n',l,MatSize, elapsed_time);
        index = index + 1; 
        OPS(l, n) = operation;
      end
      
      %disp(times)
      max_time0 = max(times);
      Ls(indexL) = l;
      indexL = indexL + 1;
      if( max_time < max_time0) 
          max_time = max_time0;
      end 
      
      max_x = max_k + 1;
      x = 2:1:max_x;
      %disp(x)

      hold on;
      plot (x, times);
      set(gca, 'YScale', 'log') 
      axis ([2,max_k, 0, max_time]);
      xlabel ("k");
      ylabel ("times(s)");
      title ("Czas mnożenia macierzy");
      
      time = 1;
      %disp(l)
  end
  legendL = string(Ls);
  for i=1:length(legendL)
      legendL(i) = "L="+legendL(i);
  end

  legend(legendL,'Location','southwest')

  szOP = size(OPS);
  Ls = szOP(1);
  Ks = szOP(2);
hf = figure ();
x = 2:1:max_k;
for Li = 1 : Ls
      hold on;
      oppp = OPS(Li,2:Ks);
      if(oppp(2) > 0)
          plot (x, oppp);
          set(gca, 'YScale', 'log') 
          %axis ([2,max_k, 0, max_time]);
          xlabel ("k");
          ylabel ("Operacje");
      end
      title ("Liczba operacji zmiennoprzecinkowych");
end
legend(legendL,'Location','southwest')
