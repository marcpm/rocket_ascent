from math import sqrt
from scipy.integrate import solve_ivp
from utils import lookup_M, lookup_mf

mass = 540e3 
MW = 16e-3
gamma = 1.25
p_c = 100 * 101325
T_c = 3500
massflow = 2000
burn_time = 120


A_e_A_t = [20, 40 ,60, 80]
R = 8.314 / MW
mfp_1 = 0.6581

def lift_odes (t, x, t_0):
	V = x[0]
	h = x[1]

    p_a = atmos(h)

	M = V / sqrt(gamma * R * T)
	c_star = sqrt(R*T_c) / mfp_1

    M_e = lookup_M(mfp_1/A_e_A_t)
    
	c_fv = get_cfv(M_e)
	c_f = c_fv - p_a/p_c * A_e_A_t
	F = c_f * p_c * A_t
	c_D  = get_cd(M)
	D = 0.5 * rho * V**2 * S_ref * c_D
	dv_dt = V
	dh_dt = (F-D)/m(t) - g 
	
	return dv_dt, dh_dt



def get_cfv(M_e):
	return ((2/(gamma-1))**( (gamma+1) / (2*(gamma-1))) 
			* (gamma*M_e + 1/M_e)/(sqrt(1+ (gamma-1)/2 * M_e**2 )))

def get_cd(M):
	if M <= 0.6:
		return 0.15				
	elif  0.6 < M <= 1.1:	
		return -4.21*M**3 + 11.016*M**2 - 8.5536*M + 2.24952
	elif 1.3 < M <= 5.0:
		return 0.16769 + 0.17636/ (sqrt(M**2-1))

