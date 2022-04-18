function time = TimeFigure()
  
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

  disp(times)

  csvwrite("ops.csv", OPS)
  csvwrite("times.csv", times)


  max_time = max(times);
      
  max_x = max_k + 1;
  x = 2:1:max_x;

%   hold on;
%   plot (x, times);
%   set(gca, 'YScale', 'log') 
%   axis ([2,max_k, 0, max_time]);
%   xlabel ("k");
%   ylabel ("times(s)");
%   title ("Czas mnożenia macierzy");


  disp(OPS)
  hf = figure ();
  hold on;
      
  plot (x, OPS);
  set(gca, 'YScale', 'log') 
  axis ([1,max_k, 0, max(OPS)]);
  xlabel ("k");
  ylabel ("Operacje");

  title ("Liczba operacji zmiennoprzecinkowych");
