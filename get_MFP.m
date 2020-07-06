function [MFP] = get_MFP(M,gamma)
%Calculo massflow parameter

% 
 MFP = sqrt(gamma)* M / ( 1 + (gamma-1)/2 *M^2  )^( (gamma+1)/(2*(gamma-1))  );

end

