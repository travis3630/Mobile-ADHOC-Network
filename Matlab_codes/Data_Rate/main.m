%clc;
clear all;
Pt=20;              % dBm: Transmit power
Frequency=28e9;     % Hz: Carrier Frequency
Bandwidth=0.1e9;    % Hz
Distance_ref = 100; % meters: reference distance
Distance =1000;     % meters
pathloss_exp=2;     % pathloss exponent
Shadowing = 10;     % dB: shadowing
Number_of_Tx = 4;   % Number of transmit antenna
Number_of_Rx = 4;   % Number of receive antenna
element_gain_Tx=10; % dBi: single antenna element gain at transmitter
element_gain_Rx=10; % dBi: single antenna element gain at receiver

% 1) Calculate the SNR and the data rate [Gbps] possible for a given distance and transmit power
[SNR datarate]= data_rate(Pt,Frequency,Bandwidth, Distance_ref, Distance, pathloss_exp, Shadowing, ...
    Number_of_Tx, Number_of_Rx, element_gain_Tx, element_gain_Rx);

fprintf("SNR [dB] = %.4f\n", SNR);
fprintf("Rate [bit per second] (Bandwidth=%.4e Hz) = %.4e\n", Bandwidth, datarate );
fprintf("Rate [bit per second per Hz] = %.4e\n", datarate/Bandwidth );



% 2) Calculate the number of Tx times number of Rx, for achieveing a required rate of x bps/Hz 
%requiredrate = 9.13e7; % bps/Hz 
requiredrate = datarate; % bps/Hz 

[Antenna_elements_required]= antennalements(Pt,Frequency,Bandwidth, Distance_ref, Distance,...
    requiredrate, element_gain_Tx, pathloss_exp, Shadowing);

% Number_of_transmit_antenna times Number_of_transmit_antenna = Nt x Nr 
fprintf("Nt x Nr (Rate = %.4e bps/Hz = %.4ebps) = %.2f\n", ...
    requiredrate, requiredrate/Bandwidth, Antenna_elements_required);



