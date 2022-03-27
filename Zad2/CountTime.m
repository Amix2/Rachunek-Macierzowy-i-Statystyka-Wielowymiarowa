function time = CountTime()
  
  max_k = 9;

  hf = figure ();
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
          endVal = 10;
      elseif n < 10
          endVal = 2;
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
  end

  csvwrite("ops.csv", OPS)
  csvwrite("times.csv", times)

