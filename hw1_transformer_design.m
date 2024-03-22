clear 

Dmin = 12.75/52.75;
Dmax = 12.75/32.75;
fs = 100e3; % Hz
Vsmin = 20; % V
Vsmax = 40; % V
Bmax = 0.1761; % T
permeability_core = 115;
permeability_air = 4 * pi * 10^-7;
effective_area_core = 125e-6; % B66363G0500X187 % m^2
window_area_core = 178; % B66363G0500X187 % mm^2
A_L = 196e-9; % B66363G0500X187 % nH/T^2
effective_length_core = 92.2e-3; % m
P_in = 72; % W
I_EDC = P_in / (Vsmin * Dmax); 
skin_depth = 75 / sqrt(fs); % mm
ripple_factor = 0.35;
delta_I = 2 * I_EDC * ripple_factor;
peak_current = I_EDC + delta_I / 2;
min_current = I_EDC - delta_I / 2;
I_in_RMS = sqrt((peak_current^2 + min_current^2 + peak_current * min_current)*Dmax/3);
I_in_avg = (peak_current + min_current) * Dmax / 2;
efficiency = 60/P_in;
resistivity_of_copper = 1.68e-5; 
surface_area_awg_26 = 0.140; % mm

fprintf ('peak_current = %f\n', peak_current) 
fprintf ('delta_I = %f\n', delta_I)

Lm = ((Vsmin * Dmax)^2) / ((2 * P_in) * fs * ripple_factor);
fprintf('Lm = %f\n', Lm);
disp(Lm)

min_prim_winding_turns = Vsmax * Dmax / (Bmax * effective_area_core * fs);
fprintf('min_prim_winding_turns = %f\n', min_prim_winding_turns);

primary_turns = sqrt(Lm / A_L);
primary_turns = round(primary_turns);
fprintf('primary_turns= %f\n', primary_turns)
necessary_primary_turns = primary_turns + 1; 
LM = necessary_primary_turns^2 * A_L;
disp(LM)
Lm_final = necessary_primary_turns^2 * A_L;
fprintf('Lm_final = %f\n', Lm_final);

Hmax = necessary_primary_turns * peak_current / effective_length_core;
Bmax_double_check = permeability_core * permeability_air * Hmax;
disp(Bmax_double_check)

fprintf('skin_depth = %f\n', skin_depth);

length_of_cable = 69*necessary_primary_turns; % mm

number_of_cables_needed = I_in_RMS / 0.361;
fprintf('number_of_cables_needed = %f\n', number_of_cables_needed)
number_of_cables_needed_final = 22;

R_awg_26 = resistivity_of_copper * length_of_cable / surface_area_awg_26 / number_of_cables_needed_final;
fprintf('R_awg_26 = %f\n', R_awg_26);

fill_factor = (necessary_primary_turns * 2 * (number_of_cables_needed_final * surface_area_awg_26)) / (window_area_core); 
fprintf ('fill_factor = %f\n', fill_factor);

P_cu_transformer = I_in_RMS^2 * R_awg_26 * 2;
fprintf ('P_cu_transformer = %f\n', P_cu_transformer);

disp(I_in_avg)
