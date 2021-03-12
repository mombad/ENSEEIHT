clear all
close all
clc

% Initialisation
Nbits=10000; % Nombre de bits envoyes

Fe=10000;

alphaSRRCF=0.5; % roll-off factor
retardTs=6; % longueur du filtre en nombre de periode symbole
h=rcosdesign(alphaSRRCF,retardTs,Ns);
fp=2000;
fpN=fp/Fe;
Eb_N0_db= [0:6];



bits=randi([0 1],1,Nbits); % generation des bits

%% QPSK
Rs=1000;
Ns=Fe/Rs; % Nombre d'echantillons par symboles

M=4; % taille de la constellation
n=log2(M); % Nombre bits par symbole de la constellation (QPSK)
symbI=1-2*bits(1:2:Nbits); % generation des symboles de la voie I
symbQ=1-2*bits(2:2:Nbits); % generation des symboles de la voie Q

I=zeros(1,Nbits/n*Ns);
Q=zeros(1,Nbits/n*Ns);

peigne=zeros(1,Nbits/n*Ns);
peigne(1:Ns:Nbits/n*Ns)=symbI+1i*symbQ;




xe1=filter(h,1,peigne);


hr = h;
z1 = filter(hr,1,xe1);
z_ech1=z1(1:Ns:end);  

I=sign(real(z_ech1));
Q=sign(imag(z_ech1));
bits_est1(1:2:Nbits)=I;
bits_est1(2:2:Nbits)=Q;
bits_est1=(1-bits_est1)/2;
TEB_sans_bruit1=mean(bits_est1(2*retardTs+1:end)~=bits(1:end-2*retardTs))



%Calcul du TEB avec bruit
TEB1=zeros(6,1);
for k = 1:length(Eb_N0_db)    
 
 %Génération du bruit gaussien
    sigma2=mean(abs(xe1).^2)*Ns/(2*log2(M)*10^(Eb_N0_db(k)/10));
    bruit_r1=sqrt(sigma2)*randn(1,length(xe1)); 
    bruit_i1=sqrt(sigma2)*randn(1,length(xe1));

    x_r1 = xe1 + bruit_r1 + i*bruit_i1;
    
    z1 = filter(hr,1,x_r1);
    z_ech1=z1(1:Ns:end);  
    
    
    %Tracé Constellation
%     if k==3
%         hold on
%         plot(z_ech1,'x');
%     end
    
    
    I=sign(real(z_ech1));
    Q=sign(imag(z_ech1));
    bits_est1(1:2:Nbits)=I;
    bits_est1(2:2:Nbits)=Q;
    bits_est1=(1-bits_est1)/2;
    TEB1(k)=mean(bits_est1(2*retardTs+1:end)~=bits(1:end-2*retardTs));
end



%Constellation 1
figure
plot(z_ech1,'.','color',[0.6 , 0.6,0.6]);
hold on
plot(peigne(1:10:end),'x','MarkerSize',20,'color',[0, 0, 0]);
axis([-2 2 -2 2]);

%Tracé du TEB réel
figure
plot(Eb_N0_db,10*log10(TEB1));
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB chaine 1");


%Comparaison des TEB réel et théorique
figure 
TEB_th=1-normcdf(sqrt(2*10.^(Eb_N0_db/10)));
plot(Eb_N0_db,10*log10(TEB1));
hold on
plot(Eb_N0_db,10*log10(TEB_th),'r');
xlabel("SNR (dB)");
ylabel("TEB");
legend("TEB réel","TEB théorique");
title("Comparaison des TEB réel et théorique");



return

%% 8 PSK
symboles_8psk = pskmod(bits,8);

xe2=filter(h,1,symboles_8psk);


hr = h;
z2 = filter(hr,1,xe2);
z_ech2=z2(1:Ns:end);  

I=sign(real(z_ech2));
Q=sign(imag(z_ech2));
bits_est1(1:2:Nbits)=I;
bits_est1(2:2:Nbits)=Q;
bits_est1=(1-bits_est1)/2;
TEB_sans_bruit1=mean(bits_est1(2*retardTs+1:end)~=bits(1:end-2*retardTs))

return

%Calcul du TEB avec bruit
TEB1=zeros(6,1);
for k = 1:length(Eb_N0_db)    
 
 %Génération du bruit gaussien
    sigma2=mean(abs(xe1).^2)*Ns/(2*log2(M)*10^(Eb_N0_db(k)/10));
    bruit_r1=sqrt(sigma2)*randn(1,length(xe1)); 
    bruit_i1=sqrt(sigma2)*randn(1,length(xe1));

    x_r1 = xe1 + bruit_r1 + i*bruit_i1;
    
    z1 = filter(hr,1,x_r1);
    z_ech1=z1(1:Ns:end);  
    
    
    %Tracé Constellation
%     if k==3
%         hold on
%         plot(z_ech1,'x');
%     end
    
    
    I=sign(real(z_ech1));
    Q=sign(imag(z_ech1));
    bits_est1(1:2:Nbits)=I;
    bits_est1(2:2:Nbits)=Q;
    bits_est1=(1-bits_est1)/2;
    TEB1(k)=mean(bits_est1(2*retardTs+1:end)~=bits(1:end-2*retardTs));
end



%Constellation 1
figure
plot(z_ech1,'.','color',[0.6 , 0.6,0.6]);
hold on
plot(peigne(1:10:end),'x','MarkerSize',20,'color',[0, 0, 0]);
axis([-2 2 -2 2]);

%Tracé du TEB réel
figure
plot(Eb_N0_db,10*log10(TEB1));
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB chaine 1");


%Comparaison des TEB réel et théorique
figure 
TEB_th=1-normcdf(sqrt(2*10.^(Eb_N0_db/10)));
plot(Eb_N0_db,10*log10(TEB1));
hold on
plot(Eb_N0_db,10*log10(TEB_th),'r');
xlabel("SNR (dB)");
ylabel("TEB");
legend("TEB réel","TEB théorique");
title("Comparaison des TEB réel et théorique");



