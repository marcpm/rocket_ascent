function [M] = mfp2M(mfp)
%MACHLOOKUP  calculo de Mach a partir de TABLAS. (NO USADO en main.m definitivo)

    table = csvread('mfp_table.csv');
    Ms = table(:,1);
    MFPs = table(:, 2);
    
    M = interp1(MFPs,Ms, mfp) ;
end

