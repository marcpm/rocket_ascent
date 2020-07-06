function [CFv] = get_CFv(M_e, gamma)
%GET_CFV Summary of this function goes here
%   Detailed explanation goes here
    CFv = ((2/(gamma+1))^( (gamma+1) / (2*(gamma-1))) ...
        * (gamma*M_e + 1/M_e)/(sqrt(1+ (gamma-1)/2 * M_e^2 )));
end

