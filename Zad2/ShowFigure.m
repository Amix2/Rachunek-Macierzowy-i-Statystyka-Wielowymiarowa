function time = ShowFigure()

  times = csvread("times.csv")
  OPS = csvread("ops.csv")

  max_time = max(times);
  max_k = length(times)

  disp(times)
  disp(max_k)

  x = 1:1:max_k;

  hf = figure ();
  hold on;
  plot (x, times);
  set(gca, 'YScale', 'log') 
  axis ([1,max_k, 0, max_time]);
  xlabel ("k");
  ylabel ("times(s)");
  title ("Czas odwracania macierzy");


  hf = figure ();
  hold on;
      
  plot (x, OPS);
  set(gca, 'YScale', 'log') 
  axis ([1,max_k, 0, max(OPS)]);
  xlabel ("k");
  ylabel ("Operacje");

  title ("Liczba operacji zmiennoprzecinkowych");

