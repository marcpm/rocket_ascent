clear;
% % clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% PROYECTO %%%%%%%%%%%%%%%%%%%% 
data.m_0 = 540e3 ;
data.S_ref = 25;

data.MW = 16e-3;
data.gamma = 1.25;
data.p_c = 100 * 101325;
data.T_c = 3500;
data.m_dot = 2000;
data.burn_time = 120;   %214.5;
data.g_0 = 9.80665;
data.Drag = true;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% ejemplo SLIDES VERTICAL ASCENT ROCKET%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data.m_0 = 3780 + 8720 + 1000 ;
% data.m_0 = 3780 + 8720  ;
% data.S_ref = pi*(1.65/2)^2;
% 
% data.MW = 16e-3;
% data.gamma = 1.24;
% data.p_c = 6 * 101325;
% data.T_c = 2500;
% data.m_dot = 134.2;
% data.burn_time = 65;
% data.g_0 = 9.80665;
% data.Drag = true;
% 
% Aratio = 6.0;
% A_e_A_t = Aratio;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fprintf('\nRunning Analysis..... \n');
fprintf('Integrating for %ds burn time ..... \n\n', data.burn_time);
tspan = [0.0, data.burn_time];
initial_conds = [0.0, 0.0];
A_e_A_ts = [20, 40 ,60, 80];


% opts = odeset('RelTol',1e-8,'AbsTol',1e-9, 'Refine',10);
% [t,x] = ode45(@(t,x) lift_odes(t,x,data, 60), tspan, initial_conds, opts);
% figure; ax1 = axes;
% figure; ax2 = axes;
% 
% plot(ax1, t, x(:,1))
% xlabel(ax1,'Temps [s]')
% ylabel(ax1,'Velocitat [m/s]')
% 
% plot(ax2, t, x(:,2))
% xlabel(ax2, 'Temps [s]')
% ylabel(ax2, 'Altitud [m]')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% LOOP apartado 1-2-3)%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
figure; ax1 = axes;
figure; ax2 = axes;
figure; ax3 = axes;
figure; ax4 = axes;
hold (ax1, 'on')
hold (ax2, 'on')
hold (ax3, 'on')
hold (ax4, 'on')

hs = zeros(99,1);
vs = zeros(99,1);
ts = zeros(99,1);
i = 1;
for A_e_A_t = 2:100
%     options = odeset('RelTol',5.421011e-10,'AbsTol',5.421011e-10, 'Refine',10);
    opts = odeset('RelTol',1e-8,'AbsTol',1e-8);
    [t,x] = ode45(@(t,x) lift_odes(t,x,data, A_e_A_t), tspan, initial_conds);

    vs(i) = x(end,1);
    hs(i) = x(end,2);
    
    i = i + 1;
 
%     scatter(ax3, A_e_A_t, x(end,2)/1e3,[], [0, 0.4470, 0.7410], 'filled')
%     scatter(ax4, A_e_A_t, x(end,1), [], [0.4660, 0.6740, 0.1880], 'filled')

    if A_e_A_t == 20 || A_e_A_t == 40 || A_e_A_t == 60 || A_e_A_t == 80
        fprintf('Ae/At: %d  \n', A_e_A_t);
        fprintf('  Velocidad final: %.2f m/s\n  Altitud final: %.2f km  \n', x(end,1), x(end,2)/1e3);
        plot(ax1, t, x(:,1), 'LineWidth', 1)
        plot(ax2, t, x(:,2)/1e3, 'LineWidth', 1)
    end

end
plot(ax3, 2:100, hs/1e3)
plot(ax4, 2:100, vs)

title(ax1, 'Velocidad-tiempo Con Drag', 'FontSize', 15)
title(ax2, 'Altitud-tiempo Con Drag', 'FontSize', 15)
xlabel(ax1,'Tiempo [s]')
ylabel(ax1,'Velocidad [m/s]')
xlabel(ax2, 'Tiempo [s]')
ylabel(ax2, 'Altitud [km]')
title(ax3, 'Altitud Máxima - Area ratios (t_{burn}=120s)', 'FontSize', 15)
xlabel(ax3,'$\frac{A_e}{A_t}$', 'Interpreter', 'latex', 'FontSize', 15)
ylabel(ax3, 'Altitud Máxima [km]')
title(ax4, 'Velocidad final - Area ratios (t_{burn}=120s)', 'FontSize', 15)
xlabel(ax4,'$\frac{A_e}{A_t}$', 'Interpreter', 'latex', 'FontSize', 15)
ylabel(ax4, 'Velocidad final [m/s]')
hold (ax1, 'off')
hold (ax2, 'off')
hold (ax3, 'off')

legend(ax1,'$\frac{A_e}{A_t}=20 $', '$\frac{A_e}{A_t}=40 $', '$\frac{A_e}{A_t}=60 $', ...
             '$\frac{A_e}{A_t}=80 $', 'Interpreter', 'latex','FontSize', 15)
        
legend(ax2,'$\frac{A_e}{A_t}=20 $', '$\frac{A_e}{A_t}=40 $', '$\frac{A_e}{A_t}=60 $', ...
            '$\frac{A_e}{A_t}=80 $', 'Interpreter', 'latex', 'FontSize', 15)


function [dx_dt] =  lift_odes (t, x, data, A_e_A_t)
    V = x(1);
	h = x(2);
    
    % alias data
    m_0 = data.m_0 ;
    S_ref = data.S_ref;

    MW = data.MW ;
    gamma = data.gamma ;
    p_c = data.p_c ;
    T_c = data.T_c ;
    m_dot = data.m_dot;
%     burn_time = data.burn_time;
    g_0 = data.g_0;
    R = 8.314/MW;
       
    mfp_1 = get_MFP(1.0, gamma);
%     mfp_1 = 1 * p_
    [T_a, a_0, p_a, rho] = atmosisa(h);

	M = V / sqrt(gamma * R * T_a);
%     M = V / a_0;
	c_star = sqrt(R*T_c) / mfp_1;
    
    A_t = m_dot * c_star / p_c;

%       M_e = mfp2M(mfp_1/A_e_A_t);
    M_e = get_M_e_iter(A_e_A_t);
%     M_e = get_M_e(A_e_A_t, gamma);
%     disp(M_e)
    p_e = p_c / ((1+(gamma-1)/2 *M_e^2)^(gamma/(gamma-1)));
    
    if p_e < (0.4* p_a)
        %%% desprendida
%          disp('Desprendida')
        p_e = 0.4 * p_a;

        M_e = sqrt((2/(gamma-1)) * ( ((p_c/p_e)^((gamma-1)/gamma)) - 1 ) );
%         disp(h)
%         disp(M_e)
%         A_e_A_t = get_Ae_At(M_e, gamma);
        A_e_A_t = get_MFP(1,gamma)/get_MFP(M_e, gamma);
        CFv = get_CFv(M_e, gamma);
        CF = CFv - p_a/p_c * A_e_A_t;
%                       fprintf('Separated flow @ t: %.2f \n', t);
    else 
    %%%% normal

        CFv = get_CFv(M_e, gamma);
        CF = CFv - p_a/p_c * A_e_A_t;
    end
    
	F = CF * p_c * A_t;
    
    if M_e > 5.0
%         fprintf('M_e: %.3f @ h: %.3f meters\n', M_e, h);
    end
    if M > 5.0
%         fprintf('Mach: %.3f @ h: %.3f meters\n', M, h);
    end
    
    if data.Drag == true
        CD  = get_CD(M);
        D = 0.5 * rho * V^2 * S_ref * CD;
    else 
        D = 0;
    end
    
    mass = m_0 - m_dot*t;
    g = g_0 * (6.3781e6/(6.3781e6+h))^2;


	dv_dt = (F-D)/mass - g ;
    dh_dt = V ;


    dx_dt = [dv_dt; dh_dt];
    
end
