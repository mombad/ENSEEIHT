%Durée symbole en nombre d’échantillons(Ts=NsTe)
Ns=4; 
t0=Ns;  
Eb_N0_db=[0:6];

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

%Calcul de la DSP du signal par périodogramme
DSP_x=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;
%Affichage de la DSP du signal généré 
figure
plot(linspace(-1,1,length(DSP_x)), fftshift(DSP_x));
xlabel("Fréquences normalisées");
title("DSP du signal généré");


%Calcul du signal en sortie du filtre de réception
hr=ones(1,Ns);
x_f = filter(hr,1,x); 
figure ;
plot(x_f/max(x_f));
axis([0 nb_bits-1 -5 5]);
xlabel("Temps");
ylabel("Amplitude");
title("Signal sans bruit en sortie du filtre de réception");


%Diagramme de l'oeil
figure;
for i=1:(nb_bits-1)/Ns     
     plot([0:Ns]/Ns,x_f(Ns*i:(Ns*(i+1))));
     xlabel("Temps normalisé à Ts");
     title("Diagramme de l'oeil");
     hold on
end
 
%Calcul du TEB sans bruit
z_ech=x_f(t0:Ns:end);    
symbole_est=sign(z_ech);
bits_est=(symbole_est+1)/2;
TEB_sans_bruit = mean(bits_est~=bits)
% On vérifie bien que TEB_sans_bruit = 0

%Calcul du TEB avec du bruit
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


