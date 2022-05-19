clc;close all;clear all;
scale=1e-9 % just for adjustment.
%Ts=50*scale; % sampling time
Ts=10*scale; % sampling time
% Sampling time

%t_rms=100*scale;  %rms delay spread of the paths
t_rms=25*scale;  %rms delay spread of the paths
% RMS delay spread
num_ch=8; % Number of channels
time=1:num_ch; % Number of time slots, or snap shots.
N=128;% FFT size

PDP=IEEE802_11_model(t_rms,Ts);  % Power delay profile dictates the power in each path
for k=1:length(PDP)
h(:,k) = Ray_model(num_ch)*sqrt(PDP(k));  % Using Ray Model  from the book Cho, et al. MIMO-OFDM Wireless Communications with Matlab
avg_pow_h(k)= mean(h(:,k).*conj(h(:,k)));  % simulation average power of the channel.
end 
%H=fft(h(1,:),N);  

for i=1:num_ch 
H_frequency_domain(i,:)=fft(h(i,:),N) ;  % Taking FFT of the channel analyze it in Frequency domain for every snap shot.
end

figure()   
stem([0:length(PDP)-1],PDP,'ro'), hold on,
stem([0:length(PDP)-1],avg_pow_h,'ko');
xlabel('channel tap index, p'), ylabel('Average Channel Power[linear]');
%title('IEEE 802.11 Model, \sigma_\tau=25ns, T_S=50ns');
title('IEEE 802.11 Model, \sigma_\tau=100ns, T_S=50ns');
legend('Ideal','Simulation'); axis([-1 7 0 1]);
%figure()
% plot([-N/2+1:N/2]/N/Ts/1e6,10*log10(H.*conj(H)),'k-');
% xlabel('Frequency[MHz]'), ylabel('Channel power[dB]')
% title('Frequency response, \sigma_\tau=25ns, T_S=50ns')

a=10*log10(abs(H_frequency_domain).^2);

%[Tresponse,Fresponse]=abs(H_frequency_domain).^2
Time=repmat(time,[N,1]).';
figure()
surf(a,Time);
xlabel('Frequency')
ylabel('Time')
zlabel('Channel Gain [dB]')