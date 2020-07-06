function [M_e] = get_M_e(A_e_A_t, gamma)
% Ae/At = f(Me) minimazacion de funcion. Encuentra valor donde Me hace que
% la función sea cero. 
%   
%     M_e = fzero(@(Me) ((2/(gamma+1))^((gamma+1)/(2*(gamma-1))) * 1/Me ...
%             * (1+ (gamma-1)/2 * Me^2)^((gamma+1)/(2*(gamma-1)))) - A_e_A_t, 2.0);

    MFP_Me = get_MFP(1,gamma)/A_e_A_t;
     Me = sym('Me');
    
    eq = sqrt(gamma)*Me/((1+(gamma-1)/2*Me^2)^((gamma+1)/(2*(gamma-1)))) == MFP_Me;
    
    M_e_solve = vpasolve(eq,Me,[1 10]);
    
    M_e = double(M_e_solve);
        
        
end

