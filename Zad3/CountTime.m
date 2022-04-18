function time = CountTime()
  
  max_k = 9;

  max_time = 0;
  OPS = 1:max_k;
  times = 1:max_k;
  index = 1;

  for n = 1:max_k
    
      MatSize = 2^n;
      matrix = randi([1 100],MatSize,MatSize);
 
      tic ();
      endVal = 1;
      if n < 5
          endVal = 100;
      elseif n < 8
          endVal = 50;
      elseif n < 10
          endVal = 20;
      end
      for rep = 1:endVal
          [~, operation] = MMInverse(matrix);
      end
      
      elapsed_time = toc ();
      elapsed_time = elapsed_time / endVal;
      
      times(index) = elapsed_time;
      fprintf('size = %d, time = %f\n',MatSize, elapsed_time);
      index = index + 1; 
      
      OPS(n) = operation;

      csvwrite("ops.csv", OPS)
      csvwrite("times.csv", times)
  end



