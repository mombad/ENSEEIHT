% TP 2 Traitement du signal
% BEN AHMED DAHO Mohamed 
% Groupe N

%III)Implantation du modulateur
% 1)a)Création d'un message binaire
Fe=1000;
f0=200;
Nb=100;
bits=randi([0,1],1,Nb);
Ns=20;
Ts=Ns/Fe;

% 1)b)Création du message à transmettre à partir du message binaire
m=kron(2*bits - 1 , ones(1,Ns));
temps=[0:length(m)-1]/Fe;

% 1)c)Tracé du message à transmettre
figure
plot(temps,m);
title('Message à tranmettre');
xlabel('Temps (s)');
ylabel('Amplitude (V)');

% 1)d)Transformée de Fourier du message à transmettre
TF=(fft(m));
Freq=linspace(-Fe/2,Fe/2,length(TF));
figure
plot(Freq,fftshift(abs(TF)));
title('Transformée de Fourier du message à transmettre');
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');

% 2)a)Modulation d'amplitude du signal à transmettre
porteuse=cos(2*pi*f0*temps);
m_module=m.*porteuse;
TF_module=(fft(m_module));
Freq=linspace(-Fe/2,Fe/2,length(TF_module));

% 2)b)Tracé de la transformée de Fourier du signal modulé
figure
plot(Freq,fftshift(abs(TF_module)));
title('Transformée de Fourier du signal modulé');
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');


% IV)Implantation udu retour à la basse fréquence
% 1)Multiplication par la porteuse
m_demodule=m_module.*porteuse;

% 2)Transformée de Fourier du signal multiplié par la porteuse
TF_demodule=(fft(m_demodule));
Freq=linspace(-Fe/2,Fe/2,length(TF_demodule));
figure
plot(Freq,fftshift(abs(TF_demodule)));
title('Transformée de Fourier du signal multiplié par la porteuse');
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');

% 3)a)Création du filtre passe bas. Pour la fréquence de coupure, on choisit 2*f0
N=40;
K=[-N/Fe:1/Fe:N/Fe];
hk=2*f0*sinc(K*f0*2);
figure
plot(K,hk);
title('Réponse impulsionnelle du filtre passe bas calculée sur un morceau');
xlabel('Temps (s)');
ylabel('Amplitude (V)');

 % 3)b)Calcul de la réponse fréquentielle du filtre
TF_filtre=fft(hk);
Freq=linspace(-Fe/2,Fe/2,length(TF_filtre));
figure
plot(Freq,fftshift((abs(TF_filtre))));
title('Réponse en fréquence du filtre passe bas ');
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');

% 3)c) Ordres différents pour le filtre
%Réponses impulsionnelles
N=21;
K_21=[-N/Fe:1/Fe:N/Fe];
hk_21=2*f0*sinc(2*K_21*f0);
figure
plot(K_21,hk_21,'d');

hold on
 
N=61;
K_61=[-N/Fe:1/Fe:N/Fe];
hk_61=2*f0*sinc(2*K_61*f0);
plot(K_61,hk_61);
title('Réponses impulsionnelles du filtre pour des ordres différents');
legend('N=21','N=61');
xlabel('Temps (s)');
ylabel('Amplitude (V)');
%Réponses fréquentielles
N=21;
K=[-N/Fe:1/Fe:N/Fe];
hk=2*f0*sinc(2*K*f0);
TF_filtre=fft(hk);
Freq=linspace(-Fe/2,Fe/2,length(TF_filtre));
figure
plot(Freq,fftshift((abs(TF_filtre))));

hold on
N=61;
K=[-N/Fe:1/Fe:N/Fe];
hk=f0*sinc(2*K*f0);
TF_filtre=fft(hk);
Freq=linspace(-Fe/2,Fe/2,length(TF_filtre));
plot(Freq,fftshift((abs(TF_filtre))));
title('Réponses fréquentielles du filtre pour des ordres différents');
legend("N=21","N=61");
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');

% 3)d)Ordres diférents pour les fenêtres de troncature
%Réponses impulsionnelles


f_rect=hk.*rectwin(length(hk))';
f_blackman=hk.*blackman(length(hk))';
figure
plot(K,f_rect);
hold on
plot(K,f_blackman);
title('Réponses impulsionnelles du filtre pour différentes fenêtres');
legend("Rectangulaire","Blackman");
xlabel('Temps (s)');
ylabel('Amplitude (V)');
% Réponses fréquentielles
fft_rect=fft(f_rect);
fft_blackman=fft(f_blackman);
figure
plot(Freq,fftshift(abs(fft_rect)));
hold on
plot(Freq,fftshift(abs(fft_blackman)));
title('Réponses fréquentielles du filtre pour différentes fenêtres');
legend("Rectangulaire","Blackman");
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');

% 3)e) On conserve l'ordre 61 et la fenêtre de Blackman
figure
plot(Freq,fftshift(abs(fft_blackman)));
hold on
Freq=linspace(-Fe/2,Fe/2,length(TF_demodule));
plot(Freq,fftshift(abs(TF_demodule)));

title("Comparaison du spectre du signal à filtrer et de la réponse fréquentielle du filtre");
legend("Filtre","Signal à filtrer");
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');

% 3)f)Filtrage du signal
signal_final=conv(m_demodule,f_blackman,'same');

% 3)g)Comparaison entre le signal émis et le signal en sortie du filtre
figure
plot(temps,m);
hold on
plot(temps,signal_final/max(signal_final));
title("Comparaison entre le signal émis et le signal en sortie du filtre");
legend("Signal émis","Signal en sortie du filtre (normalisé)");
xlabel('Temps (s)');
ylabel('Amplitude (V)');
