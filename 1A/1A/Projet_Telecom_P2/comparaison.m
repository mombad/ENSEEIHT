
Rb = 6000;
Nbits=100000; % Nombre de bits envoyes
bits=randi([0 1],1,Nbits); % generation des bits



[TEB8PSK, xe8PSK] = modulation(bits(1:90000),Rb,8,"8PSK");
[TEBQPSK ,xeQPSK]= modulation(bits,Rb,4,"QPSK");
[TEB16QAM ,xe16QAM]= modulation(bits,Rb,16,"16QAM");
[TEB4ASK ,xe4ASK] = modulation(bits,Rb,4,"4ASK");

%Comparaison des TEB
figure
plot(10*log10(TEB8PSK))
hold on
plot(10*log10(TEBQPSK))
hold on
plot(10*log10(TEB16QAM))
hold on
plot(10*log10(TEB4ASK))
title("Comparaison des TEBs pour différentes modulations");
legend('8-PSK', 'QPSK','16QAM', '4ASK');

%Comparaison des DSP
DSP8PSK = (1/length(xe8PSK))*abs(fft(xe8PSK,2^nextpow2(length(xe8PSK)))).^2;
DSPQPSK = (1/length(xeQPSK))*abs(fft(xeQPSK,2^nextpow2(length(xeQPSK)))).^2;
DSP16QAM = (1/length(xe16QAM))*abs(fft(xe16QAM,2^nextpow2(length(xe16QAM)))).^2;
DSP4ASK = (1/length(xe4ASK))*abs(fft(xe4ASK,2^nextpow2(length(xe4ASK)))).^2;

figure
plot(linspace(-1,1,length(DSP8PSK)), fftshift(DSP8PSK));
hold on
plot(linspace(-1,1,length(DSPQPSK)), fftshift(DSPQPSK));
hold on
plot(linspace(-1,1,length(DSP16QAM)), fftshift(DSP16QAM));
hold on
plot(linspace(-1,1,length(DSP4ASK)), fftshift(DSP4ASK));
title("Comparaison des DSPs pour différentes modulations");
legend('8-PSK', 'QPSK','16QAM', '4ASK');
%Classement par efficacité spectrale décroissante :
% 16QAM, 8PSK, QPSK , 4ASK
