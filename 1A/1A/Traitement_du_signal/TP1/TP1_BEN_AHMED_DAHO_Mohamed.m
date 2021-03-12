% TP 1 Traitement du signal
% BEN AHMED DAHO Mohamed 
% Groupe N


% 2)1)Génération d'un signal cosinus à 1100Hz échantillonné à 10000Hz
N=90;
temps1=[1:N];
Te1=1/10000;
temps1=temps1*Te1;
f0=1100;
signal1=cos(2*pi*f0*temps1);

% 2)2)Tracé du signal 1
figure;
plot(temps1,signal1);
title('signal cosinus à 1100 Hz échantillonné à Fe=10000Hz') ;
xlabel('Temps (s)');
ylabel('Amplitude (V)');


% 2)3)Génération d'un signal cosinus à 1100Hz échantillonné à 1000Hz
N=90;
temps2=[1:N];
Te2=1/1000;
temps2=temps2*Te2;
f0=1100;
signal2=cos(2*pi*f0*temps2);

% 2)4)Tracé du signal 2
figure;
plot(temps2,signal2);
title('signal cosinus à 1100 Hz échantillonné à Fe=1000Hz'); 
xlabel('Temps (s)');
ylabel('Amplitude (V)');

 

%3)2)a) Tracé du spectre du signal 1
Xd1=fft(signal1);
Fe1=10000;
Freq1= (-Fe1/2):(Fe1/N):(Fe1/2-Fe1/N);
figure;
semilogy(Freq1,fftshift(abs(Xd1)));
title('spectre du signal cosinus à 1100 Hz échantillonné à Fe=10000Hz') ;
xlabel('Fréquences (Hz)');
ylabel('Amplitude (V)');


%3)2)b) Tracé du spectre du signal 2
Xd2=fft(signal1);
Fe2=1000;
Freq2=-Fe2/2:Fe2/N:Fe2/2-Fe2/N;
figure;
semilogy(Freq2,fftshift(abs(Xd2)));
title('spectre du signal cosinus à 1100 Hz échantillonné à Fe=1000Hz') ;
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');



% 3)4)Transformée de Fourier avec Zero Padding
N_prime=2^nextpow2(N);
zp1=[signal1 zeros(N_prime-N,1)']; 
fft_zp1=fft(zp1);

Freq1_zp= (-Fe1/2):(Fe1/N_prime):(Fe1/2-Fe1/N_prime);

figure;
semilogy(Freq1_zp,fftshift(abs(fft_zp1)));
title("spectre du signal cosinus à 1100 Hz échantillonné à Fe=10000Hz avec Zero Padding(N'=128)") ;
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');


% 3)5)Influence de la valeur de N'


N_prime=N;
zp1=[signal1 zeros(N_prime-N,1)']; 
fft_zp1=fft(zp1);
Freq1_zp= (-Fe1/2):(Fe1/N_prime):(Fe1/2-Fe1/N_prime);
figure;
semilogy(Freq1_zp,fftshift(abs(fft_zp1))); 
hold on   
N_prime=2^nextpow2(N_prime);

for i=1:2    
    zp1=[signal1 zeros(N_prime-N,1)']; 
    fft_zp1=fft(zp1);
    Freq1_zp= (-Fe1/2):(Fe1/N_prime):(Fe1/2-Fe1/N_prime);
    semilogy(Freq1_zp,fftshift(abs(fft_zp1))); 
    N_prime=N_prime*2;
end


legend("N' = N = 90","N' = 128","N' = 256");
title("Spectre du signal cosinus à 1100 Hz échantillonné à 10000Hz pour plusieurs valeurs de N'");
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');


% 4)1)Réalisation du signal aléatoire
phi=rand*2*pi;
x=cos([Te1:Te1:N*Te1]*2*pi*f0 + phi);

% 4)2)Calcul de la DSP avec un périodogramme
dsp_x=(abs(fft(x)).^2)/length(x);
figure;
plot(Freq1,fftshift(dsp_x));
title("DSP du signal cosinus à 1100 Hz");
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');

% 4)3)DSP avec les fenêtres de Hamming et de Blackman

figure;
% Hamming
dsp_x_hamming=(abs(fft(x.*hamming(N)')));
plot(Freq1,fftshift(dsp_x_hamming));

hold on
% Blackman
dsp_x_blackman=(abs(fft(x.*blackman(N)')));
plot(Freq1,fftshift(dsp_x_blackman));
legend('Hamming','Blackman');
title("DSP du signal cosinus à 1100 Hz pour plusieurs fenêtres");
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');

% 4)4)DSP avec Welch

DSPx=pwelch(x,"","","",'twosided');
figure;
plot([-Fe1/2 + Fe1/length(DSPx):Fe1/length(DSPx):Fe1/2],fftshift(DSPx));
title('DSp estimée avec Welch');
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');

% 4)5)Comparaison des méthodes de calcul de la DSP

figure;
plot(Freq1,fftshift(dsp_x));
hold on
plot(Freq1,fftshift(dsp_x_hamming));
plot(Freq1,fftshift(dsp_x_blackman));
plot([-Fe1/2 + Fe1/length(DSPx):Fe1/length(DSPx):Fe1/2],fftshift(DSPx));
title('Comparaison de plusieurs méthodes de calcul de DSP');
legend("DSP éstimée par périodogramme","Hamming","Blackman","Welch");
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');



