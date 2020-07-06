function [M_e] = get_M_e_iter(A_e_A_t)
% Mach exit iterativamente
%   
% 


    M_e_prev = 2.0;
    for it = 1:100
        
        M_e= sqrt(  (( (M_e_prev*A_e_A_t*1.125^4.5)^(1/4.5)) -1  )/ (0.125) );
        
        if abs(M_e - M_e_prev) < 1e-8
            break
        end
        M_e_prev = M_e;
    end
end

