function H=Ray_model(L)
% Rayleigh channel model
% Input : L = Number of channel realizations
% Output: H = Channel vector

fs = 100000000;                % Sample rate (Hz)
pathDelays = [0 2.5e-3];  % Path delays (s)
pathPower = [0 -6];       % Path power (dB)
fD = 4.167e6;                   % Maximum Doppler shift (Hz)
numSamples = 1000;        % Number of samples
rchan = comm.RayleighChannel('SampleRate',fs, ...'PathDelays',pathDelays,'AveragePathGains',pathPower, ...
'MaximumDopplerShift',fD,'FadingTechnique','Sum of sinusoids');


H =  rchan(ones(L,1));



% N=L;
% f_m = 80.4; f_s=4000; N=1e6; t=[1:1000]; sigma = 1/sqrt(2);
% uncorr_RF=sigma*(randn(1,N)+i*randn(1,N));
% norm_f_m=f_m/f_s; % normalized Doppler frequency
% doppler_filter=fir1(2048,norm_f_m); % approximated doppler filter
% corr_RF=filter2(doppler_filter,uncorr_RF);
% rms_corr_RF=sqrt((corr_RF*corr_RF')/N); % rms value
% corr_RF=corr_RF/rms_corr_RF; % power normalized
% plot(t./f_s,20*log10(abs(corr_RF(t))))
% 
% H = corr_RF;
