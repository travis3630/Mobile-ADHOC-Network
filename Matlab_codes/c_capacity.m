clear all;
% Affects the accuracy and duration of the simulation
symbol_count = 1e6;

% SNR range
SNR_dB = -10:2:30;

% Modulation scheme

% modem_name = 'BPSK'
% modulation = [+1, -1];

%modem_name = '4PSK'
%modulation = [+1, +i, -1, -i];

% modem_name = '8PSK'
% modulation = [+1, sqrt(1/2)*(+1+i), +i, sqrt(1/2)*(-1+i), -1, sqrt(1/2)*(-1-i), -i, sqrt(1/2)*(+1-i)];

modem_name = '16QAM'
modulation = sqrt(1/10)*[-3+3*i, -1+3*i, +1+3*i, +3+3*i, -3+1*i, -1+1*i, +1+1*i, +3+1*i, -3-1*i, -1-1*i, +1-1*i, +3-1*i, -3-3*i, -1-3*i, +1-3*i, +3-3*i];

% modem_name = '64QAM'
% x = (0:64-1)';
% modulation = sqrt(1/10)*qammod(x,64)

% Channel types:

% 1) AWGN channel
%channel_name = 'AWGN'
%channel = ones(1,symbol_count);

% 2) Uncorrelated Rayleigh fading channel
channel_name = 'uncorrelated Rayleigh fading channel'
channel = sqrt(1/2)*(randn(1,symbol_count)+i*randn(1,symbol_count));

% 3) Rician Fading channel
% K=2; % Rician fading factor
% channel_name = ['Rician fading channel, K=', num2str(K)]
% sigma = 1/sqrt(2); A = sqrt(K * 2*sigma^2);
% factor = sqrt(A^2+2*sigma^2); 
% A = A/factor; sigma = sigma/factor;
% channel = A+ sigma*(randn(1,symbol_count)+1i*randn(1,symbol_count));





%%%% Compute DCMC channel capacity
DCMC=[];
a=1;

fprintf("SNR\t\t Capacity \n");
for snr=SNR_dB

% Generate some random symbols
symbols = ceil(length(modulation)*rand(1,symbol_count));

% Generate the transmitted signal
tx = modulation(symbols);

% Generate some noise
N0 = 1/(10^(snr/10));
noise = sqrt(N0/2)*(randn(1,symbol_count)+i*randn(1,symbol_count));


% Generate the received signal
rx = tx.*channel+noise;

% Calculate the symbol probabilities
probabilities0 = max(exp(-(abs( ones(length(modulation),1)*rx - modulation.'*channel).^2)/N0),  realmin);

% Normalise the symbol probabilities
probabilities = probabilities0 ./ (ones(length(modulation),1)*sum(probabilities0));

% Calculate the capacity: DCMC
channel_capacity = log2(length(modulation))+mean( sum(probabilities.*log2(probabilities)) );

% Display the capacity
%disp(['The channel capacity is ', num2str(channel_capacity), ' bits per channel use']);

DCMC(a)=channel_capacity;
fprintf("%f\t %f\n",snr, DCMC(a));


a=a+1;
end

figure

% % AWGN channel CCMC capacity 
% snr_dB = SNR_dB;
% snr = 10.^(snr_dB/10);
% C = log2(1+snr);
% %semilogy(-10:1:20,C);
% plot(-10:1:20,C);
% grid on
% xlabel('SNR (dB)');
% ylabel('Channel Capacity (bit/s/Hz)');
% title('The channel capacity of different modulation scheme over AWGN channel');
% axis([-10 20 0 7])
% hold on


%%%% Compute CCMC channel capacity 
snr_dB = SNR_dB;
snr = 10.^(snr_dB/10);
%CCMC = exp(1./snr).*expint(1./snr)/log(2); % this is for Ray channel only


X = (abs(channel)).^2;
for k=1:length(snr)
    C2(k,:) = log2(1+snr(k).*X);
    CCMC(k) = mean(C2(k,:));
end

bandwidth = [5e6,10e6,15e6,20e6,30e6];
channel_cap_rate = zeros(length(bandwidth),length(SNR_dB),'double');
for i=1:length(bandwidth)
    channel_cap_rate(i,1:end) = bandwidth(i)*DCMC;
end

% plot(SNR_dB,CCMC,'o-','MarkerSize',10);
% grid on
% xlabel('SNR (dB)');
% ylabel('Channel Capacity (bit/s/Hz)');
% title(['Channel capacity of ',channel_name]);
% axis([SNR_dB(1) SNR_dB(end) 0 7])
% hold on

% file_title=sprintf('channel_capacity_%s', modem_name);
% save(file_title, 'SNR_dB', 'CCMC', 'DCMC');

% for i=length(bandwidth)
%     plot(SNR_dB,channel_cap_rate(i,1:end),'x-','MarkerSize',10);
% end
plot(SNR_dB,channel_cap_rate(1,1:end),'x-','MarkerSize',10);
hold on
plot(SNR_dB,channel_cap_rate(2,1:end),'x-','MarkerSize',10);
plot(SNR_dB,channel_cap_rate(3,1:end),'x-','MarkerSize',10);
plot(SNR_dB,channel_cap_rate(4,1:end),'x-','MarkerSize',10);
plot(SNR_dB,channel_cap_rate(5,1:end),'x-','MarkerSize',10);
grid on
%semilogy(-10:1:20,ber);
% plot(SNR_dB,DCMC,'x-','MarkerSize',10);
xlabel('SNR (dB)');
ylabel('Channel Capacity in data rate/ bits per sec');
title(['The channel capacity of 16-QAM modulation scheme']);
%axis([SNR_dB(1) SNR_dB(end) 0 7])
hold off

legend( '5MHz', '10MHz','15MHz','20MHz','30MHz','Location','northwest');

FontSize=14;
set(gcf,'position',[x0,y0,width,height]); set(gca, 'fontsize', FontSize);



