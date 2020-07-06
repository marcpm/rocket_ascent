function [A_e_A_t] = get_Ae_At(Me, gamma)
%Calcula Ae/At a partir de Mach de salida y gamma.

    A_e_A_t = fzero(@(Ae_At) ((2/(gamma+1))^((gamma+1)/(2*(gamma-1))) * 1/Me ...
            * (1+ (gamma-1)/2 * Me^2)^((gamma+1)/(2*(gamma-1)))) - Ae_At, 1);

end

