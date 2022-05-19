%%%% data rate %%%%
datarate=readtable('datarate_host0.csv');
throughput=readtable('throughput_host1.csv');
time_d=datarate{:,1};
d_rate=datarate{:,2}; %bits per second
bandwidth = 20e6 %in Hz
norm_d_rate= d_rate./(20e6)
t_put = throughput{:,2};
% put = zeros(size(time));
% for i=1:length(time)
%     for j=1:length(t_put)
%         if round(time(i),1) == throughput{j,1}
%             put(i) = throughput{j,2};
%         end
%     end
% end
figure();
plot(time_d,norm_d_rate)
xlabel('Time/s'), ylabel('data rate/bits per sec per Hz')
title('Time vs normalized data rate')
% yyaxis right;
% plot(time,put)
hold off

%%%% packet error vs throughput %%%%
% pac_err_rate=readtable('packeterrorrate_host0.csv');
% time_err=pac_err_rate{:,1};
% errorrate=pac_err_rate{:,2};
% put = zeros(size(time_err));
% for i = 1:length(errorrate)
%     if errorrate(i)<0.01
%         errorrate(i) = 0;
%     end
% end
% for i=1:length(time_err)
%     for j=1:length(t_put)
%         if round(time_err(i),1) == throughput{j,1}
%             put(i) = throughput{j,2}
%         end
%     end
% end
% figure();
% yyaxis left;
% plot(time_err,errorrate)
% xlabel('Time/s'), ylabel('errorrate/ratio')
% title('Time vs error rate &throughput')
% yyaxis right;
%  ylabel('throughput /pkts')
% plot(time_err,put)
% legend('error rate','throughput')
% hold off