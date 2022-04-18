function time = ShowFigure()

  times = csvread("times.csv")
  OPS = csvread("ops.csv")

  max_time = max(times);
  max_k = length(times)

  x = 1:1:max_k;

  hf = figure ();
  hold on;
  plot (x, times);
  set(gca, 'YScale', 'log') 
  axis ([1,max_k, 0, max_time]);
  xlabel ("k");
  ylabel ("Czas (s)");
  title ("Czas wyznaczania LU macierzy");


  hf = figure ();
  hold on;
  po = 3;
  idealYs = (2 .^x ) .^ po .* (OPS(1) / (2^po));
  plot (x, OPS);
  plot (x, idealYs);
  set(gca, 'YScale', 'log') 
  axis ([1,max_k, 0, max(OPS)]);
  xlabel ("k");
  ylabel ("Operacje");
  legend("LU faktoryzacja", "O(n³)")

  title ("Liczba operacji zmiennoprzecinkowych");

