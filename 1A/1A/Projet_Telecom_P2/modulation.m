function[TEB ,xe]= modulation(bits,Rb,M,nom)
TEB = 0;
% Initialisation
Fe = 24000;
Rs = Rb/log2(M);
Ns = Fe/Rs;
Ns = M;
n=log2(M); % Nombre bits par symbole de la constellation

alphaSRRCF=0.5; % roll-off factor
retardTs=6; % longueur du filtre en nombre de periode symbole
h=rcosdesign(alphaSRRCF,retardTs,Ns);

Eb_N0_db= [0:6];

Nbits = length(bits);

if nom=="QPSK"
    symbI=1-2*bits(1:2:Nbits); % generation des symboles de la voie I
    symbQ=1-2*bits(2:2:Nbits); % generation des symboles de la voie Q
    I=zeros(1,Nbits/n*Ns);
    Q=zeros(1,Nbits/n*Ns);
    symboles=zeros(1,Nbits/n*Ns);
    symboles(1:Ns:Nbits/n*Ns)=symbI+1i*symbQ;
    symboles_mod = symboles;
    
elseif nom =="8PSK"   
    bits_r = reshape(bits,n,Nbits/n).';
    symboles_dec = bi2de(bits_r).';    
    symboles_mod = pskmod(symboles_dec,M,0,'gray');
    symboles = kron(symboles_mod,[1 zeros(1,Ns-1)]);
    
elseif nom =="16QAM"
    bits_r = reshape(bits,n,Nbits/n).';
    symboles_dec = bi2de(bits_r).';    
    symboles_mod = qammod(symboles_dec,M,'gray');
    symboles = kron(symboles_mod,[1 zeros(1,Ns-1)]);
    
elseif nom=="4ASK"
    bits_r = reshape(bits,n,Nbits/n).';
    symboles_dec = bi2de(bits_r).';
    symboles_mod = pammod(symboles_dec,M);
    symboles = kron(symboles_mod,[1 zeros(1,Ns-1)]);
    

end

xe=filter(h,1,symboles);
hr = h;

%Sans bruit
z = filter(hr,1,xe);
z_ech=z(1:Ns:end);  
if nom=="QPSK"
    I=sign(real(z_ech));
    Q=sign(imag(z_ech));
    bits_est(1:2:Nbits)=I;
    bits_est(2:2:Nbits)=Q;
    bits_est=(1-bits_est)/2;
    
elseif nom =="8PSK"
    demod = pskdemod(z_ech,M,0,'gray');
    demod_bi = de2bi(demod.');
    bits_est = reshape(demod_bi.',size(demod_bi,1)*size(demod_bi,2),1);
    bits=transpose(bits);
elseif nom =="16QAM"
    demod = qamdemod(z_ech,M,'gray');
    demod_bi = de2bi(demod.');
    bits_est = reshape(demod_bi.',size(demod_bi,1)*size(demod_bi,2),1);
    bits=transpose(bits);
elseif nom =="4ASK"
 demod = pamdemod(z_ech,M);
 demod_bi = de2bi(demod);
 bits_est = reshape(demod_bi.',size(demod_bi,1)*size(demod_bi,2),1)';
     
end

TEB_sans_bruit=mean(bits_est(log2(M)*retardTs+1:end)~=bits(1:end-log2(M)*retardTs))


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
    
  
    if nom=="QPSK"
        I=sign(real(z_ech));
        Q=sign(imag(z_ech));
        bits_est(1:2:Nbits)=I;        
        bits_est(2:2:Nbits)=Q;
        bits_est=(1-bits_est)/2;
    
    elseif nom =="8PSK"
         demod = pskdemod(z_ech,M,0,'gray');
         demod_bi = de2bi(demod.');
         bits_est = reshape(demod_bi.',size(demod_bi,1)*size(demod_bi,2),1);
    
    elseif nom =="16QAM"
        demod = qamdemod(z_ech,M);
        demod_bi = de2bi(demod.');
        bits_est = reshape(demod_bi.',size(demod_bi,1)*size(demod_bi,2),1);
    elseif nom =="4ASK"
        demod = pamdemod(z_ech,M);
 
        demod_bi = de2bi(demod);
 
        bits_est = reshape(demod_bi.',size(demod_bi,1)*size(demod_bi,2),1)';

    end
    TEB(k)=mean(bits_est(log2(M)*retardTs+1:end)~=bits(1:end-log2(M)*retardTs));
end



%Constellation 
figure
plot(z_ech,'.','color',[0.6 , 0.6,0.6]);
title(strcat("Constellation chaine ",nom));

hold on
if nom=="4ASK"
    scatterplot(symboles_mod);
else
    plot(symboles_mod(1:10:end),'x','MarkerSize',20,'color',[0, 0, 0]);
end
axis([-2 2 -2 2]);

title(strcat("Constellation chaine ",nom));

%Tracé du TEB réel
figure
plot(Eb_N0_db,10*log10(TEB));
xlabel("SNR (dB)");
ylabel("TEB");
title(strcat("TEB chaine ",nom));


%Comparaison des TEB réel et théorique
figure
if nom == "QPSK"
    TEB_th=2*qfunc(sin(pi/M)*sqrt(2*log2(M)*(10.^(Eb_N0_db/10))))/log2(M);
elseif nom=="8PSK"
    TEB_th=2*qfunc(sin(pi/M)*sqrt(2*log2(M)*(10.^(Eb_N0_db/10))))/log2(M);
elseif nom=="16QAM"
    TEB_th=4*(1-1/sqrt(M))*qfunc(sqrt(3*log2(M)*(1/(M-1))*(10.^(Eb_N0_db/10))))/log2(M);
    
elseif nom=="4ASK"
    TEB_th=2*((M-1)/M)*(1-normcdf(sqrt((6*log2(M)/(M^2-1))*10.^(Eb_N0_db/10))))/log2(M);

end
plot(Eb_N0_db,10*log10(TEB));
hold on
plot(Eb_N0_db,10*log10(TEB_th),'r');
xlabel("SNR (dB)");
ylabel("TEB");
legend("TEB réel","TEB théorique");
title(strcat("Comparaison des TEB réel et théorique chaine ",nom));
