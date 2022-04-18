max_k = 20;

for n = 1:max_k
    MatSize = 2^n;
    M = rand(MatSize,MatSize);
    
    tic ();
    [L,U,Ops] = LU(M);   % warmup
    elapsed_time = toc ();

    endVal = 2 / elapsed_time + 1;  % make test last at least 2 sec

    disp(n);
    tic ();

    for rep = 1:endVal
        [L,U,Ops] = LU(M);
    end
    
    elapsed_time = toc ();
    elapsed_time = elapsed_time / endVal;

    disp(elapsed_time);

    times(n) = elapsed_time;
    ops(n) = Ops;
    dets(n, :) = [det(M), det(U),det(L)];

    csvwrite("ops.csv", ops)
    csvwrite("dets.csv", dets)
    csvwrite("times.csv", times)
end

ShowFigure();