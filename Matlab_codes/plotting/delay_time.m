%%%% delay %%%%
time_delay=readtable('end2endhost1.csv');
time=time_delay{:,1};
delay=time_delay{:,2};
figure();
stem(time,delay,'r-')
xlabel('Time/s'), ylabel('delay time/s')
title('delay time as time propagates')
hold on
time_delay_25mw=readtable('end2end25mw.csv');
time2=time_delay_25mw{:,1};
delay2=time_delay_25mw{:,2};
stem(time2,delay2,'b-')
legend('transceiver=15mw','transceiver=20mw')
hold off
