clear 

Dmin = 12.75/52.75;
Dmax = 12.75/32.75;
fs = 80000; % Hz
Vsmin = 20; % V
Vsmax = 40; % V
Bmax = 0.2; % T
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
input_peak_current = I_EDC + delta_I / 2;
input_min_current = I_EDC - delta_I / 2;
I_in_RMS = sqrt((input_peak_current^2 + input_min_current^2 + input_peak_current * input_min_current)*Dmax/3);
I_Lm_rms = 8.5;
I_LM_rms = I_EDC*sqrt(1+(1/12)*(delta_I/I_EDC)^2); 
I_in_avg = (input_peak_current + input_min_current) * Dmax / 2;
efficiency = 60/P_in;
resistivity_of_copper = 1.68e-5; 
surface_area_awg_26 = 0.140; % mm^2
I_out = 5;
Vout = 12;

fprintf ('peak_current = %f\n', input_peak_current) 
fprintf ('delta_I = %f\n', delta_I)
fprintf ('I_LM_rms = %f\n', I_LM_rms) 

Lm = ((Vsmax * Dmin)^2) / ((2 * P_in) * fs * ripple_factor);
fprintf('Lm = %f\n', Lm);
disp(Lm)

min_prim_winding_turns = Vsmax * Dmax / (Bmax * effective_area_core * fs);
fprintf('min_prim_winding_turns = %f\n', min_prim_winding_turns);

primary_turns = sqrt(Lm / A_L);
fprintf('primary_turns_exact= %f\n', primary_turns)
primary_turns = round(primary_turns);
fprintf('primary_turns_rounded= %f\n', primary_turns)
necessary_primary_turns = primary_turns; 
LM = necessary_primary_turns^2 * A_L;
disp(LM)
Lm_final = necessary_primary_turns^2 * A_L;
fprintf('Lm_final = %f\n', Lm_final);

Hmax = necessary_primary_turns * input_peak_current / effective_length_core;
Bmax_double_check = permeability_core * permeability_air * Hmax;
disp(Bmax_double_check)

fprintf('skin_depth = %f\n', skin_depth);

length_of_cable = 69*necessary_primary_turns; % mm

number_of_cables_needed = I_LM_rms / 0.361;
fprintf('number_of_cables_needed = %f\n', number_of_cables_needed)
number_of_cables_needed_final = 27;

R_awg_26 = resistivity_of_copper * length_of_cable / surface_area_awg_26 / number_of_cables_needed_final;
R_awg_26_DC = 133.8568*69*11/27/1000000;

fprintf('R_awg_26 = %f\n', R_awg_26);
fprintf('R_awg_26_DC = %f\n', R_awg_26_DC);


fill_factor = (necessary_primary_turns * 2 * (number_of_cables_needed_final * surface_area_awg_26)) / (window_area_core); 
fprintf ('fill_factor = %f\n', fill_factor);

P_cu_transformer = I_LM_rms^2 * R_awg_26_DC * 2;
fprintf ('P_cu_transformer = %f\n', P_cu_transformer);

P_core_transformer_75kHz = 0.250 * 11.5;
fprintf ('P_core_transformer_75kHz = %f\n', P_core_transformer_75kHz);
    
P_core_transformer_80kHz = 0.300 * 11.5;
fprintf ('P_core_transformer_80kHz = %f\n', P_core_transformer_80kHz);

P_core_transformer_100kHz = 0.375 * 11.5;
fprintf ('P_core_transformer_100kHz = %f\n', P_core_transformer_100kHz);

disp(I_in_avg)

I_sw_peak1 = (I_out / (1-Dmin)) + (((1-Dmin) * Vout) / (2 * fs * Lm_final));
I_sw_peak2 = (I_out / (1-Dmax)) + (((1-Dmax) * Vout) / (2 * fs * Lm_final));

fprintf ('Switch_current = %f\n', I_sw_peak1);
fprintf ('Switch_current = %f\n', I_sw_peak2);
