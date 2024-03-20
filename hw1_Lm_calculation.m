clear all

Dmin = 3/13;
Dmax = 3/8;
R = 2.4;
fs = 50e3; 
Vsmin = 20;
Vsmax = 40;
Bmax = 0.3;
effective_area_core = 420e-6; % 0P45530EC %
window_area_core = 188.7; % 0P45530EC %
A_L = 8173e-9; % 0P45530EC %
P_in = 70; % 0P45530EC %
R_core = 56.2e-3 / (4 * pi * 10^-7 * 2500 * 420e-6);
R_gap = 2e-4 / (4 * pi * 10^-7 * 420e-6);
I_EDC = P_in / (Vsmin * Dmax); 
skin_depth = 75 / sqrt(fs);
ripple_factor = 0.5;
efficiency = 60/P_in;
resistivity_of_copper = 1.68e-5; 
length_of_cable = 580;
surface_area_awg_18 = 0.823;
surface_area_awg_20 = 0.519;

Lm2 = ((Vsmin * Dmax)^2) / ((2 * P_in) * fs * ripple_factor);
fprintf('Lm2 = %f\n', Lm2);
disp(Lm2)

min_prim_winding_turns = Vsmax * Dmax / (Bmax * effective_area_core * fs);
fprintf('min_prim_winding_turns = %f\n', min_prim_winding_turns);

fprintf('skin_depth = %f\n', skin_depth);

turns_square_by_reluctance = Lm2 * (R_gap + R_core);
reluctance_turns = sqrt(turns_square_by_reluctance);
fprintf('reluctance_turns = %f\n', reluctance_turns);
primary_turns2 = 3;

R_awg_18 = resistivity_of_copper*length_of_cable/surface_area_awg_18;
R_awg_20 = resistivity_of_copper*length_of_cable/surface_area_awg_20;

fprintf('R_awg_18 = %f\n', R_awg_18);
fprintf('R_awg_20 = %f\n', R_awg_20);

fill_factor = (primary_turns2 * (surface_area_awg_18 + surface_area_awg_20)) / (window_area_core); 
fprintf ('fill_factor = %f\n', fill_factor);
