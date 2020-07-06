function [mfp] = M2mfp(M)
%MFPLOOKUP calculo MFP a partir de TABLAS. (NO USADO en el main.m definitivo)
    table = csvread('mfp_table.csv');
    Ms = table(:,1);
    MFPs = table(:, 2);
    
    mfp = interp1(Ms, MFPs, M) ;
end

