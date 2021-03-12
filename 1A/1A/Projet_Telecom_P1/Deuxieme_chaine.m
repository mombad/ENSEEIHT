%Durée symbole en nombre d’échantillons(Ts=NsTe)
Ns=4; 
t0=Ns;  
Eb_N0_db= [0:6];

% %Nombre de bits générés
nb_bits=10000; 

%Génération de l’information binaire
bits=randi([0,1],1,nb_bits);

%Mapping binaire à moyenne nulle:0->-1, 1->1
Symboles=2*bits-1;

%Génération de la suite de Diracs pondérés par les symboles (suréchantillonnage)
Suite_diracs=kron(Symboles, [1 zeros(1,Ns-1)]); 

%Génération de la réponse impulsionnelle du filtre de mise en forme(NRZ)
h=ones(1,Ns);
%Filtrage de mise en forme
x=filter(h,1,Suite_diracs);

%Calcul du signal en sortie du filtre de réception
hr=[ones(1,Ns/2) zeros(1,Ns/2)];
x_f = filter(hr,1,x);
figure ;
plot(x_f/max(x_f));
xlabel("Temps");
ylabel("Amplitude");
title("Signal sans bruit en sortie du filtre de réception");



%Diagramme de l'oeil
figure;
y=reshape(x_f,Ns,nb_bits);
plot(y);
xlabel("Temps");
title("Diagramme de l'oeil");

%Calcul du TEB sans bruit
z_ech=x_f(t0:Ns:end);    
symbole_est=sign(z_ech);
bits_est=(symbole_est+1)/2;
TEB_sans_bruit = mean(bits_est~=bits)  
% On vérifie bien que TEB_sans_bruit = 0


%Calcul du TEB avec bruit
TEB=zeros(6,1);
for i = 1:length(Eb_N0_db)
    
    %Génération du bruit gaussien
    sigma2=mean(x.^2)*Ns/(2*10^(Eb_N0_db(i)/10));
    bruit=sqrt(sigma2)*randn(1,nb_bits*Ns);
    
    %Signal reçu
    r = x + bruit;
    
    %Filtre de réception
    r_filtre = filter(hr,1,r);

    %Echantillonnage
    z_ech=r_filtre(t0:Ns:end);    
    symbole_est=sign(z_ech);
    bits_est=(symbole_est+1)/2;
    
    %Calcul du TEB
    TEB(i)=mean(bits_est~=bits);

end

%Tracé du TEB réel
figure
plot(Eb_N0_db,10*log10(TEB));
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB réel");

%Comparaison des TEB réel et théorique pour la chaine étudiée
figure 
TEB_th=1-normcdf(sqrt(10.^(Eb_N0_db/10)));
plot(Eb_N0_db,10*log10(TEB));
hold on
plot(Eb_N0_db,10*log10(TEB_th),'r');
xlabel("SNR (dB)");
ylabel("TEB");
legend("TEB réel","TEB théorique");
title("Comparaison des TEB réel et théorique de la deuxième chaine");

%Comparaison du TEB réel de la chaine étudiée et du TEB théorique de la
%chaine de référence
figure 
TEB_th1=1-normcdf(sqrt(2*10.^(Eb_N0_db/10)));
plot(Eb_N0_db,10*log10(TEB));
hold on
plot(Eb_N0_db,10*log10(TEB_th1),'r');
xlabel("SNR (dB)");
ylabel("TEB");
legend("TEB réel","TEB théorique");
title("Comparaison du TEB réel de la deuxième chaine et du TEB théorique de la chaine de référence");

%Comparaison des DSP des chaines 1 et 2
%DSP de la chaine 1
DSP_x1=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;
figure
subplot(1,2,1);
plot(linspace(-1,1,length(DSP_x1)), fftshift(DSP_x1));
xlabel("Fréquences normalisées");
title("DSP du signal de la chaine 1");

%Calcul de la DSP du signal 2
subplot(1,2,2);
DSP_x2=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;
plot(linspace(-1,1,length(DSP_x1)), fftshift(DSP_x1));
xlabel("Fréquences normalisées");
title("DSP du signal de la chaine 2");

