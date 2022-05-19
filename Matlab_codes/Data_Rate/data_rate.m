% Beamforming scenario

function [SNR_dB datarate]= data_rate(Transmitpower,Frequency,Bandwidth, Distance_ref, Distance, ...
    pathloss_exp, Shadowing_dB, Number_of_Tx, Number_of_Rx, element_gain_Tx, element_gain_Rx)

Pt=Transmitpower;

Temp=300;  % kelvin
BoltzmanConstant=1.388e-23;
ThermalNoise=10*log10(BoltzmanConstant*Temp*Bandwidth*1000); %dBm;
NoiseFigure =7;
Noise=NoiseFigure+ThermalNoise; 
%atm_attenuation=[0.001 0.001 0.001 0.01 0.01 0.1 10 15 10 0.01 0.1 0.01 0.01] *distance/1000;
%atm_attenuation=10*distance/1000;

%s_sigma = sqrt( 10^(Shadowing_dB/10) );
%shadowing = s_sigma*randn(size(Distance));
shadowing = Shadowing_dB;  % mean value in dB

% Tx antenna gain = element_gain(non-dB) x number of transmitter
% Rx antenna gain = element_gain(non-dB) x number of receiver


% pathloss
PL = 20*log10(Frequency)+ 20*log10(4*pi*Distance_ref/3e8) +10*pathloss_exp*log10(Distance/Distance_ref) + shadowing;

ReceivedPower= Pt - PL + element_gain_Tx + element_gain_Rx + 10*log10(Number_of_Tx*Number_of_Rx);

SNR_dB=ReceivedPower-Noise;


fprintf("\nTransmit Power = %.4f dBm; Noise Power = %.4f dBm; Path Loss = %.4f dB\n", Pt, Noise, PL);
fprintf("Received Power = %f dBm; Gtx = %.4f dBi, Grx = %.4f dBi\n", ...
    ReceivedPower, 10*log10(Number_of_Tx)+element_gain_Tx, 10*log10(Number_of_Rx)+element_gain_Rx);
fprintf("Received SNR = %f dB\n", SNR_dB);

datarate=Bandwidth*log2(1+10^(SNR_dB/10));
end

