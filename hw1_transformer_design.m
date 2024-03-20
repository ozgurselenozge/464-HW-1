clear all

Dmin = 3/13;
Dmax = 3/8;
R = 2.4;
fs = 100e3; 
Vsmin = 20;
Vsmax = 40;
Bmax = 0.3;
effective_area_core = 84e-6; % 00K3515E090 %
window_area_core = 151; % 00K3515E090 %
A_L = 140e-9; % 00K3515E090 %
P_in = 70; % 00K3515E090 %
I_EDC = P_in / (Vsmin * Dmax); 
ripple_factor = 0.4;
efficiency = 60/P_in;
resistivity_of_copper = 1.68e-5; 
length_of_cable = 580;
surface_area_awg_18 = 0.823;
surface_area_awg_20 = 0.519;

fprintf('I_EDC = %f\n', I_EDC);

Lm1 = (1-Dmin)^2 * R / (2*fs); 
fprintf('Lm1 = %f\n', Lm1);
disp(Lm1)

Lm2 = ((Vsmin * Dmax)^2) / ((2 * P_in) * fs * ripple_factor);
fprintf('Lm2 = %f\n', Lm2);
disp(Lm2)

min_prim_winding_turns = Vsmax * Dmax / (Bmax * effective_area_core * fs);
fprintf('min_prim_winding_turns = %f\n', min_prim_winding_turns);

Turns_square_Lm1 = Lm1/A_L;
primary_turns1 = sqrt(Turns_square_Lm1);
fprintf('primary_turns1 = %f\n', primary_turns1);

Turns_square_Lm2 = Lm2/A_L;
primary_turns2 = sqrt(Turns_square_Lm2);
fprintf('primary_turns2 = %f\n', primary_turns2);

R_awg_18 = resistivity_of_copper*length_of_cable/surface_area_awg_18;
R_awg_20 = resistivity_of_copper*length_of_cable/surface_area_awg_20;

fprintf('R_awg_18 = %f\n', R_awg_18);
fprintf('R_awg_20 = %f\n', R_awg_20);

fill_factor = primary_turns2 * (surface_area_awg_18 + primary_turns2 * surface_area_awg_20) / (2*window_area_core); 
fprintf ('fill_factor = %f\n', fill_factor);
