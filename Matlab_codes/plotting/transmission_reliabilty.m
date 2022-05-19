%%% 1 %%%
pac_err_rate=readtable('packeterrorrate_host0.csv');
time=pac_err_rate{:,1};
rate=pac_err_rate{:,2};
for i = 1:length(rate)
    if rate(i)<0.01
        rate(i) = 0;
    end
end
figure();
plot(time,rate)
xlabel('Time'), ylabel('Packet error rate')
title('Time vs Packet error rate')
hold off

%%% 2 %%%%
packetreceived=readtable('udppacketreceived_host1.csv');
time=packetreceived{:,1};
received=packetreceived{:,2};
for i = 1:length(received)
    if received(i)<0.01
        received(i) = 0;
    end
end
figure();
plot(time,received,'bo')
xlabel('Time'), ylabel('packetsent')
title('Time vs packet sent')
hold on

packetsent=readtable('udppacketsent_host0.csv');
time=packetsent{:,1};
sent=packetsent{:,2};
for i = 1:length(sent)
    if sent(i)<0.01
        sent(i) = 0;
    end
end
plot(time,sent,'r.')
xlabel('Time'), ylabel('Packets')
title('Time vs packet sent/received')
legend('packet received','packet send')
hold off

%%% 3 %%%
packetreceivedworetry=readtable('packetreceivedwithoutretry_host1.csv');
time=packetreceivedworetry{:,1};
received_wo_retry=packetreceivedworetry{:,2};
for i = 1:length(received_wo_retry)
    if received_wo_retry(i)<0.01
        received_wo_retry(i) = 0;
    end
end
figure();
plot(time,received_wo_retry,'b-')
xlabel('Time'), ylabel('Packets')
title('sent-receive without retry')
hold on

packetsentworetry=readtable('packetsentwithoutretry_host0.csv');
time=packetsentworetry{:,1};
sent_wo_retry=packetsentworetry{:,2};
for i = 1:length(sent_wo_retry)
    if sent_wo_retry(i)<0.01
        sent_wo_retry(i) = 0;
    end
end
plot(time,sent_wo_retry,'r-')

legend('packet received wo retry','packet send wo retry')
hold off


