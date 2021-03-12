% QPSK 1en bande transposee

clear all
close all
clc

% Initialisation
Nbits=10000; % Nombre de bits envoyes
M=4; % taille de la constellation
n=log2(M); % Nombre bits par symbole de la constellation (QPSK)
Fe=10000;
Rs=1000;
Ns=Fe/Rs; % Nombre d'echantillons par symboles
nfft=2^nextpow2(Nbits/n*Ns); % nombre de points de la fft
alphaSRRCF=0.35; % roll-off factor
retardTs=6; % longueur du filtre en nombre de periode symbole
h=rcosdesign(alphaSRRCF,retardTs,Ns);
fp=2000;
fpN=fp/Fe;
Eb_N0_db= [0:6];


% Emission
bits=randi([0 1],1,Nbits); % generation des bits
symbI=1-2*bits(1:2:Nbits); % generation des symboles de la voie I
symbQ=1-2*bits(2:2:Nbits); % generation des symboles de la voie Q

I=zeros(1,Nbits/n*Ns);
Q=zeros(1,Nbits/n*Ns);

peigne=zeros(1,Nbits/n*Ns);
peigne(1:Ns:Nbits/n*Ns)=symbI+1i*symbQ;

xe=filter(h,1,peigne);
% 
% figure
% subplot(1,2,1);
% plot(symbI);
% title("Signal sur la voie en phase");
% subplot(1,2,2);
% plot(symbQ);
% title("Signal sur la voie en quadrature");
% 
% figure
% plot(x);
% title("Signal transmis");
% 
% figure
% periodogram(xe,hamming(length(xe)),nfft)
% 
% figure
% periodogram(x,hamming(length(x)),nfft)
% 


hr = h;
z = filter(hr,1,xe);
z_ech=z(1:Ns:end);  

I=sign(real(z_ech));
Q=sign(imag(z_ech));
bits_est(1:2:Nbits)=I;
bits_est(2:2:Nbits)=Q;
bits_est=(1-bits_est)/2;
TEB_sans_bruit=mean(bits_est(2*retardTs+1:end)~=bits(1:end-2*retardTs))


%Calcul du TEB avec bruit
TEB=zeros(6,1);
for k = 1:length(Eb_N0_db)    
 
 %Génération du bruit gaussien
    sigma2=mean(abs(xe).^2)*Ns/(2*log2(M)*10^(Eb_N0_db(k)/10));
    bruit_r=sqrt(sigma2)*randn(1,length(xe)); 
    bruit_i=sqrt(sigma2)*randn(1,length(xe));

    x_r = xe + bruit_r + i*bruit_i;
    
    z = filter(hr,1,x_r);
    z_ech=z(1:Ns:end);  
    
    I=sign(real(z_ech));
    Q=sign(imag(z_ech));
    bits_est(1:2:Nbits)=I;
    bits_est(2:2:Nbits)=Q;
    bits_est=(1-bits_est)/2;
    TEB(k)=mean(bits_est(2*retardTs+1:end)~=bits(1:end-2*retardTs));

end


%Tracé du TEB réel
figure
plot(Eb_N0_db,10*log10(TEB));
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB réel");


%Comparaison des TEB réel et théorique
figure 
TEB_th=1-normcdf(sqrt(2*10.^(Eb_N0_db/10)));
plot(Eb_N0_db,10*log10(TEB));
hold on
plot(Eb_N0_db,10*log10(TEB_th),'r');
xlabel("SNR (dB)");
ylabel("TEB");
legend("TEB réel","TEB théorique");
title("Comparaison des TEB réel et théorique");

%Constellation 1
figure;
plot(peigne(1:10:end),'x');
axis([-2 2 -2 2]);

%Constellation 2
figure;
plot(z_ech,'x');


%Tracé du TEB réel
figure
plot(Eb_N0_db,10*log10(TEB));
xlabel("SNR (dB)");
ylabel("TEB");
title("Comapraison TEB chaines 1 et 2");
hold on
x=real(exp(1i*2*pi*fpN*[1:Nbits/n*Ns]).*xe);


%Calcul du TEB avec bruit
TEB=zeros(6,1);
for k = 1:length(Eb_N0_db)    
 
 %Génération du bruit gaussien
    sigma2=mean(abs(x).^2)*Ns/(2*log2(M)*10^(Eb_N0_db(k)/10));
    bruit=sqrt(sigma2)*randn(1,length(x));    

    x_r = x + bruit;
    xcos = x_r .* cos(2*pi*fpN*[1:Nbits/n*Ns]);
    xsin = x_r .* sin(2*pi*fpN*[1:Nbits/n*Ns]);
    z = filter(hr,1,xcos -i*xsin);
    z_ech=z(1:Ns:end);  
    
    I=sign(real(z_ech));
    Q=sign(imag(z_ech));
    bits_est(1:2:Nbits)=I;
    bits_est(2:2:Nbits)=Q;
    bits_est=(1-bits_est)/2;
    TEB(k)=mean(bits_est(2*retardTs+1:end)~=bits(1:end-2*retardTs));

end

plot(Eb_N0_db,10*log10(TEB));
legend("TEB de la chaine passe bas équivalente","TEB de la chaine sur fréquence porteuse");

