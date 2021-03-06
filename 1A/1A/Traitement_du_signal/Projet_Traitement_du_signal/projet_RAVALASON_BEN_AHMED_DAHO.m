% Projet de Traitement du signal 2019-2020
% ENSEEIHT 1SN
% Auteurs : RAVALOSON Nomanina, BEN AHMED DAHO Mohamed

% Importation des données

load donnees1.mat;
load donnees2.mat;

% 3)2)1) Modulation bande base 
Fp2=46000;
Longueur_signal = length(bits_utilisateur1);
Fe=128000;
Te=1/Fe;
Duree_signal = Longueur_signal * Te;
Ns=0.04/Duree_signal;
Ts=Ns*Te;

m1=kron(2*bits_utilisateur1-1,ones(1,Ns));
m2=kron(2*bits_utilisateur2-1,ones(1,Ns));

%Tracés temporels des signaux m1 et m2

Temps=0:Ns*Longueur_signal-1;
Temps=Temps*Te;
figure;
subplot(2,1,1);
plot(Temps,m1);
title('Message m1');
xlabel('Temps (s)');
ylabel('Amplitude (V)');
subplot(2,1,2);
plot(Temps,m2);
title('Message m2');
xlabel('Temps (s)');
ylabel('Amplitude (V)');

% Tracés des DSP de m1 et m2

dsp_m1=(1/length(m1))*(fftshift(abs(fft(m1))).^2);
Freq=linspace(-Fe/2,Fe/2,length(dsp_m1));

figure;
subplot(2,1,1);

plot(Freq,dsp_m1);
title('DSP du message m1');
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');

dsp_m2=(1/length(m2))*(fftshift(abs(fft(m2))).^2);
Freq=linspace(-Fe/2,Fe/2,length(dsp_m2));
subplot(2,1,2);
plot(Freq,dsp_m2);
title('DSP du message m2');
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');


%3.2.2 Construction du signal MF-TDMA
%1.a  

%Initialisation du signal

slot = zeros(1,5120);
signal_MFTDMA1 = [slot,m1,slot,slot,slot];

signal_MFTDMA2 = [slot,slot,slot,slot,m2];

% Tracés des signaux 

figure
subplot(2,1,1);
plot([0:Te:(length(signal_MFTDMA1)-1)*Te],signal_MFTDMA1);
title("Tracé du signal 1 à envoyer");
xlabel("Temps (s)");
ylabel("Amplitude (V)");


subplot(2,1,2);
plot([0:Te:(length(signal_MFTDMA2)-1)*Te],signal_MFTDMA2);
title("Tracé du signal 2 à envoyer");
xlabel("Temps (s)");
ylabel("Amplitude (V)");



%1.b

% Modulation d'amplitude


tableau_de_cos = zeros(1,25600);
tableau_de_cos = cos(2*pi*Fp2*[0:Te:25599*Te]);

x1= signal_MFTDMA1*cos(0);
x2 = signal_MFTDMA2.*(tableau_de_cos);


%2.
% Somme des signaux et ajout du bruit
x = x1 + x2;
Ps = mean(abs(x).^2);
Pb = Ps*10e-2;          % On choisit le rapport SNR = 20 dB donc Ps = 100 Pb
sigma = sqrt(Pb);
bruit = sigma*rand(1,length(x));
xtot = x +  bruit;

% Tracé temporel du signal MF-TDMA
figure;
plot([0:Te:(length(x)-1)*Te],xtot);
title('Signal MF-TDMA');
xlabel('Temps (s)');
ylabel('Amplitude (V)');

% Tracé de la DSP du signal MF-TDMA
N = length(xtot);
DSP = periodogramme(xtot,N);
figure
plot(linspace(-Fe/2,Fe/2,length(DSP)),fftshift(DSP));
title('DSP du signal MF-TDMA');
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');



% 4)1)1)Synthèse du filtre passe bas
%Filtre passe bas à la fréquence de coupure Fp2/2

%4)1)1)1)

% Réponses impulsionnelle et fréquentielle du filtre passe bas
N=1000;
K=[-N/Fe:1/Fe:N/Fe];

%Réponse impulsionnelle du filtre passe bas : hk
hk=(Fp2/Fe)*sinc(K*Fp2);

TF_filtre=fft(hk);

Freq_filtre=linspace(-Fe/2,Fe/2,length(TF_filtre));

figure
subplot(2,1,1);
plot(K,hk);
xlabel('Temps (s)');
ylabel('Amplitude (V)');
title('Réponse impulsionnelle du filtre passe bas');
subplot(2,1,2);
plot(Freq_filtre,fftshift((abs(TF_filtre))));
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');
title('Réponse fréquentielle du filtre passe bas (normalisée en amplitude)');


% 4)1)1)2) Superposition de la réponse fréquentielle du filtre passe bas et de la DSP
% du signal

figure
plot(Freq_filtre,fftshift((abs(TF_filtre))));
hold on
plot(linspace(-Fe/2,Fe/2,length(DSP)),fftshift(DSP/max(DSP)));
title('Superposition de la réponse fréquentielle filtre passe bas et de la DSP du signal');
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');
legend('Filtre','DSP du signal');


%4)1)2) Filtre passe haut

%Création du dirac numérique
dirac_numerique= zeros(length(K),1);
dirac_numerique=dirac_numerique';
dirac_numerique(1001)=1;

%Réponse impulsionnelle du filtre passe bas : hk_haut
hk_haut=dirac_numerique-hk;
TF_filtre_haut=fft(hk_haut);

%Tracés des réponses impulsionnelle et fréquentielle du filtre passe haut
figure
subplot(2,1,1);
plot(K,hk_haut);
xlabel('Temps (s)');
ylabel('Amplitude (V)');
title('Réponse impulsionnelle du filtre passe-haut');
subplot(2,1,2);
plot(Freq_filtre,fftshift(abs(TF_filtre_haut)));
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');
title('Réponse fréquentielle du filtre passe-haut (normalisée en amplitude)');

%Superposition de la réponse fréquentielle du filtre passe haut et de la DSP
% du signal

figure
plot(Freq_filtre,fftshift((abs(TF_filtre_haut))));
hold on
plot(linspace(-Fe/2,Fe/2,length(DSP)),fftshift(DSP/max(DSP)));
title('Superposition de la réponse fréquentielle filtre passe haut et de la DSP du signal');
xlabel('Fréquence (Hz)');
ylabel('Amplitude (V)');
legend('Filtre passe haut','DSP du signal');

% 4)1)3) Filtrage

x1_filtre = conv(xtot,hk,'same');
x2_filtre = conv(xtot,hk_haut,'same');

figure
subplot(2,1,1);
plot([0:Te:(length(x)-1)*Te],x1_filtre);
title('Signal x1 retrouvé');
xlabel('Temps (s)');
ylabel('Amplitude (V)');

subplot(2,1,2);
plot([0:Te:(length(x)-1)*Te],x2_filtre);
title('Signal x2 retrouvé');
xlabel('Temps (s)');
ylabel('Amplitude (V)');


% 4)2) Retour à basse fréquence
% Il n'y a que le signal x2 à modifier

x2_filtre=x2_filtre.*tableau_de_cos;
conv(x2_filtre,hk,'same');


% 4)3) Détection du slot utile

%Création du tableau contenant les slots à tester

%Pour x1

SLOT1_x1=x1_filtre(1:5120);
SLOT2_x1=x1_filtre(5121:10240);
SLOT3_x1=x1_filtre(10241:15360);
SLOT4_x1=x1_filtre(15361:20480);
SLOT5_x1=x1_filtre(20481:25600);

SLOTS_x1=[SLOT1_x1' SLOT2_x1' SLOT3_x1' SLOT4_x1' SLOT5_x1'];

%Pour x2

SLOT1_x2=x2_filtre(1:5120);
SLOT2_x2=x2_filtre(5121:10240);
SLOT3_x2=x2_filtre(10241:15360);
SLOT4_x2=x2_filtre(15361:20480);
SLOT5_x2=x2_filtre(20481:25600);

SLOTS_x2=[SLOT1_x2' SLOT2_x2' SLOT3_x2' SLOT4_x2' SLOT5_x2'];



%Calcul des énergies de chaque slot pour x1 

energie_x1_1=sum(abs(SLOT1_x1).^2*Te);
energie_x1_2=sum(abs(SLOT2_x1).^2*Te);
energie_x1_3=sum(abs(SLOT3_x1).^2*Te);
energie_x1_4=sum(abs(SLOT4_x1).^2*Te);
energie_x1_5=sum(abs(SLOT5_x1.^2*Te));

Energie_TAB_x1=[energie_x1_1 energie_x1_2 energie_x1_3 energie_x1_4 energie_x1_5];

%Détection du slot utile pour x1

[max_energie_x1,indice_x1]=max(Energie_TAB_x1);
SLOT_utile_x1=SLOTS_x1(:,indice_x1);
  


%Calcul des énergies de chaque slot pour x2

energie_x2_1=sum(abs(SLOT1_x2).^2*Te);
energie_x2_2=sum(abs(SLOT2_x2).^2*Te);
energie_x2_3=sum(abs(SLOT3_x2).^2*Te);
energie_x2_4=sum(abs(SLOT4_x2).^2*Te);
energie_x2_5=sum(abs(SLOT5_x2.^2*Te));

Energie_TAB_x2=[energie_x2_1 energie_x2_2 energie_x2_3 energie_x2_4 energie_x2_5];



%Détection du slot utile pour x2

[max_energie_x2,indice_x2]=max(Energie_TAB_x2);
SLOT_utile_x2=SLOTS_x2(:,indice_x2);    
    


% 4)4) Démodulation bande de base

SignalFiltre_x1=conv(SLOT_utile_x1',ones(1,Ns),'same');
SignalEchantillonne_x1=SignalFiltre_x1(1:Ns:end);
BitsRecuperes=(sign(SignalEchantillonne_x1)+1)/2;
bin2str(BitsRecuperes)

SignalFiltre_x2=conv(SLOT_utile_x2',ones(1,Ns),'same');
SignalEchantillonne_x2=SignalFiltre_x2(1:Ns:end);
BitsRecuperes_x2=(sign(SignalEchantillonne_x2)+1)/2;
bin2str(BitsRecuperes_x2)


% Le prof mystère est Martial Coulon
% -> Homme à lunettes et équations qui donnent mal à la tête
% -> Loi de Coulomb
% -> Cou long comme la girafe ...  




