% Beamforming scenario

function [AEs]= antennaelements(Transmitpower,Frequency,Bandwidth, Distance_ref, Distance, ...
    required_rate, element_gain, pathloss_exp, Shadowing_dB )

Pt=Transmitpower;

distance=Distance;
frequency= Frequency;

%s_sigma = sqrt( 10^(Shadowing_dB/10) );
%shadowing = s_sigma*randn(size(Distance));
shadowing = Shadowing_dB;  % mean value in dB

Temp=300;  % kelvin
BoltzmanConstant=1.388e-23;
ThermalNoise=10*log10(BoltzmanConstant*Temp*Bandwidth*1000); %dBm;
NoiseFigure =7;
Noise=NoiseFigure+ThermalNoise;

Pr_mmwave=0;

% pathloss
PL = 20*log10(Frequency)+ 20*log10(4*pi*Distance_ref/3e8) +10*pathloss_exp*log10(Distance/Distance_ref) + shadowing;

ReceivedPower= Pt - PL; 

% required_rate
% Bandwidth
% ThermalNoise
% required_rate/Bandwidth

Pr_mmwave=ReceivedPower;
RequiredPower=10*log10(2^(required_rate/Bandwidth) -1)+ Noise;

SNR_dB=ReceivedPower-Noise;

fprintf("\nTransmit Power = %.4f dBm; Noise Power = %.4f dBm; Path Loss = %.4f dB\n", Pt, Noise, PL);
fprintf("Received Power = %f dBm; RequiredPower = %f dBm\n", Pr_mmwave, RequiredPower);
fprintf("Received SNR = %f dB; Required Received SNR = %f dB\n", SNR_dB, RequiredPower-Noise);

if ReceivedPower<RequiredPower    
    Total_min_gain_antennas=RequiredPower - Pr_mmwave;
    AEs=10^((Total_min_gain_antennas-2*element_gain)/10);    
    AEs = AEs;
else
    AEs=1; % at least one antenna
end

end




%figure()
%
% plot(frequency,No_of_antenna_elements_db_linear_scale  ,'linewidth', 2);
% xlabel('Frequency (GHz)','fontsize',12);
% ylabel('Minimum number of antenna_elements','fontsize',12);
% grid minor

%
%figure()
%plot(frequency,(L_fol)  ,'linewidth', 2);
%xlabel('Frequency (GHz)','fontsize',12);
%ylabel('Foliage Pentration Loss (dB)','fontsize',12);
%grid minor
