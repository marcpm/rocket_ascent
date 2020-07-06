function [CD] = get_CD(M)
%GET_CD Summary of this function goes here
%   Detailed explanation goes here
	if M <= 0.6
		CD = 0.15;			
    elseif  0.6 < M & M <= 1.1
		CD =  -4.32*M^3 + 11.016*M^2 - 8.5536*M + 2.24952;
        
    elseif 1.1 < M  & M<= 1.3
        CD = -M^2 +2.2*M - 0.79;
    elseif 1.3 < M %& M<= 5.0
		CD = 0.16769 + 0.17636/ (sqrt(M^2-1));
    end
end

