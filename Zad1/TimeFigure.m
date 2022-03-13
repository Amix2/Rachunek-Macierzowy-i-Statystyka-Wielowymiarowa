function time = TimeFigure()
  
  max_l = 8;
  max_k = 8;

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
    tic ();
    MatMulMix(matrixA,matrixB, l)
    elapsed_time = toc ();
    disp(elapsed_time)
    times(index) = elapsed_time;
    index = index + 1; 
  end
  
  disp(times)
  max_time0 = max(times);
  if( max_time < max_time0) 
      max_time = max_time0;
  end 
  
  max_x = max_k + 1
  x = 2:1:max_x;
  disp(x)
    
  hold on;
  plot (x, times);
  set(gca, 'YScale', 'log') 
  axis ([2,max_k, 0, max_time]);
  xlabel ("k");
  ylabel ("times(s)");
  title (strcat("l = ", num2str(l)));
  
  time = 1;
  disp(l)
  end

  legend({'l=2','l=3', 'l=4', 'l=5', 'l=6', 'l=7', 'l=8'},'Location','southwest')
