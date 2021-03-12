%Durée symbole en nombre d’échantillons(Ts=NsTe)
Ns=4; 
t0=Ns;  
Eb_N0_db=[0:6];
M=4;
%Nombre de bits générés
nb_bits=10000; 

%Génération du mapping
bits=randi([0,1],1,nb_bits);

%Mapping 4-aire naturel
Symboles=(2*bi2de(reshape(bits,2,length(bits)/2).')-3).';
Symboles_ref = 2*bits-1;

%Génération de la suite de Diracs pondérés par les symboles (suréchantillonnage)
Suite_diracs=kron(Symboles, [1 zeros(1,Ns-1)]); 
Suite_diracs_ref = kron(Symboles_ref, [1 zeros(1,Ns-1)]);

%Génération de la réponse impulsionnelle du filtre de mise en forme(NRZ)
h=ones(1,Ns);

%Filtrage de mise en forme
x=filter(h,1,Suite_diracs);
x_ref = filter(h,1,Suite_diracs_ref);

%Calcul de la DSP du signal par périodogramme
DSP_x=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;
%Affichage de la DSP du signal généré 
figure
plot(linspace(-1,1,length(DSP_x)), fftshift(DSP_x));
xlabel("Fréquences normalisées");
title("DSP du signal généré");


figure;
plot(linspace(-1,1,length(DSP_x)), fftshift(DSP_x));
hold on
DSP_x_ref=(1/length(x_ref))*abs(fft(x_ref,2^nextpow2(length(x_ref)))).^2;
plot(linspace(-1,1,length(DSP_x_ref)), fftshift(DSP_x_ref));
legend('Mapping 4-aire','Mapping Binaire');
title("Comparaison des DSP pour des mappings différents");
xlabel("Fréquences normalisées");




%Calcul du signal en sortie du filtre de réception
hr =ones(1,Ns);
x_f = filter(hr,1,x); 
figure
plot(x_f/max(x_f));
axis([0 nb_bits-1 -5 5]);
xlabel("Temps (s)");
ylabel("Amplitude");
title("Signal sans bruit en sortie du filtre de réception");

%Diagramme de l'oeil
figure;
y=reshape(x_f,Ns,nb_bits/2);
plot(y);
title("Diagramme de l'oeil");


 %Echantillonnage
 z_ech=x_f(t0:Ns:end)/Ns;
 A=z_ech <-2 ;
 A=A*(-2);
 B=z_ech<0;
 B=B*(-1);
 C=z_ech>0;
 D=z_ech>2;
 D=D*2;
 symbole_est=A+B+C+D;
 bits_est=reshape(de2bi((symbole_est+3)/2).',1,length(bits));
    
 %Calcul du TEB
 TEB_sans_bruit=mean(bits_est~=bits)
%On retrouve bien TEB_sans_bruit = 0

%Calcul du TEB et du TES
TES=zeros(6,1);
TEB=zeros(6,1);
for i = 1:length(Eb_N0_db)
    
    %Génération du bruit gaussien
    sigma2=mean(x.^2)*(Ns/2)/(2*10^(Eb_N0_db(i)/10));
    bruit=sqrt(sigma2)*randn(1,nb_bits/2*Ns);
    %Signal reçu
    r = x + bruit;
    
    %Filtre de réception
    hr=ones(1,Ns);
    r_filtre = filter(hr,1,r);

    %Echantillonnage
    z_ech=r_filtre(t0:Ns:end)/Ns;
    A=z_ech <-2 ;
    A=A*(-2);
    B=z_ech<0;
    B=B*(-1);
    C=z_ech>0;
    D=z_ech>2;
    D=D*2;
    symbole_est=A+B+C+D;
    
    %Calcul du TES
    TES(i)=mean(symbole_est~=Symboles);
    
    bits_est=reshape(de2bi((symbole_est+3)/2).',1,length(bits));
    
    %Calcul du TEB
    TEB(i)=mean(bits_est~=bits);

end

%Tracé du TES réel
figure
plot(Eb_N0_db,10*log10(TES));
xlabel("SNR (dB)");
ylabel("TES");
title("TES réel");

%Comparaison des TES réel et théorique
figure 
TES_th=2*((M-1)/M)*(1-normcdf(sqrt((6*log2(M)/(M^2-1))*10.^(Eb_N0_db/10))));
plot(Eb_N0_db,10*log10(TES));
hold on
plot(Eb_N0_db,10*log10(TES_th),'r');
xlabel("SNR (dB)");
ylabel("TES");
legend("TES réel","TES théorique");
title("Comparaison des TES réel et théorique");

%Tracé du TEB réel
figure
plot(Eb_N0_db,10*log10(TEB));
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB réel");

%Comparaison des TEB réel et théorique
figure
TEB_th = TES_th/log2(M);
plot(Eb_N0_db,10*log10(TEB));
hold on
plot(Eb_N0_db,10*log10(TEB_th),'r');
xlabel("SNR (dB)");
ylabel("TEB");
legend("TEB réel","TEB théorique");
title("Comparaison des TEB réel et théorique");




