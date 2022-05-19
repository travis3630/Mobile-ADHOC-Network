clear;
B=[1e6,5e6,10e6,20e6,30e6];    % Bandwidth B in MHz
color=['r','b','m','g','black'];

snr_db=[1, 5, 10, 15, 20, 25, 30]; % in dB
snr=10.^(snr_db/10); % in linear scale

for i=1:1:5
 C=B(i)*log2(1+snr);        % Capacity calculation
 semilogy(snr_db,C,color(i));
 hold on;
end

title('Channel capacity formula');
xlabel('SNR (dB)');
ylabel('Capacity (bits/sec)');
legend('show');
legend('B=1 MHz', 'B=5 MHz', 'B=10 MHz', 'B= 20MHz','B= 30MHz');