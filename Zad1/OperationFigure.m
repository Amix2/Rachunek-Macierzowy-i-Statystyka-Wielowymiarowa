function time = OperationFigure()
  
  max_k = 8;
  max_l = 8;


  hf = figure ();
  max_time = 0;

  for l =  2:max_l
    
      times = 1:max_k;
      index = 1;
    
      for n = 2:max_k
        size = 2^n;
        matrixA = randi([1 100],size,size);
        matrixB = randi([1 100],size,size);
        disp(size)
    
        [~, operation] = MatMulMix(matrixA,matrixB, l);
        times(index) = operation;
        index = index + 1; 
      end
      
      disp(times)
      max_time0 = max(times);
      if( max_time < max_time0) 
          max_time = max_time0;
      end 
      
      max_x = max_k + 1
      x = 1:1:max_k;
      disp(x)
        
      hold on;
      plot (x, times);
      set(gca, 'YScale', 'log') 
      axis ([2, max_k, 0, max_time]);
      xlabel ("k");
      ylabel ("Liczba operacji zmniennoprzecinkowych");
      title (strcat("l = ", num2str(l)));
      
      time = 1;
      disp(l)
  end

  legend({'l=2','l=3', 'l=4', 'l=5', 'l=6', 'l=7', 'l=8'},'Location','southwest')
