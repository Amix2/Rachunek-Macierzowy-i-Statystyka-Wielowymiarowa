function [Determinent] = LUdeterminent(inputM)

    [~, U, ~ ] = LU(inputM);

    Determinent = 1;
    szu = size(U);

    for i=1:szu(1)
        Determinent = Determinent * inputM(i,i);
    end

end

