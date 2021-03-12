%Durée symbole en nombre d’échantillons(Ts=NsTe)
Fe = 12000;
Rs = 3000;
Ns=Fe/Rs; 
t0=1;  
Eb_N0_db= [0:6];
alpha = 0.5;
span = 4;

% %Nombre de bits générés
nb_bits=10000; 

%Génération de l’information binaire
bits=randi([0,1],1,nb_bits);

%Mapping binaire à moyenne nulle:0->-1, 1->1
Symboles=2*bits-1;

%Génération de la suite de Diracs pondérés par les symboles (suréchantillonnage)
Suite_diracs=kron(Symboles, [1 zeros(1,Ns-1)]); 

%Génération de la réponse impulsionnelle du filtre de mise en forme(NRZ)
h=rcosdesign(alpha,span,Ns);
h = h/norm(h);

%Filtrage de mise en forme
x=filter(h,1,Suite_diracs);


%Calcul du signal en sortie du filtre de réception
hr = h;
x_f = filter(hr,1,x); 
figure
plot(x_f/max(x_f));
axis([0 nb_bits-1 -5 5]);
xlabel("Temps");
ylabel("Amplitude");
title("Signal sans bruit en sortie du filtre de réception");

%Diagramme de l'oeil sans passage dans le canal de transmission
figure;
y=reshape(x_f,Ns,nb_bits);
plot(y);
xlabel("Temps");
title("Diagramme de l'oeil sans passage dans le canal de transmission");

%Calcul du TEB sans bruit
z_ech=x_f(t0:Ns:end);    
symbole_est=sign(z_ech);
bits_est=(symbole_est+1)/2;
TEB_sans_bruit=mean(bits_est(1+Ns:end)~=bits(1:end-Ns)) 
% On vérifie bien que TEB_sans_bruit = 0

%Génération de la réponse impulsionnelle du filtre passe bas (canal)
f0 = 1500;
Fe = 12000;
L = 10;
    
N = Ns*L;
hk = fir1(N,2*f0/Fe);
hk = hk/norm(hk);


%Calcul du TEB avec bruit
TEB=zeros(6,1);
for i = 1:length(Eb_N0_db)    
    
    %Passage par le canal (filtre fréquence de coupure à 2*f0)   
    r = filter(hk,1,x);
    
    %Génération du bruit gaussien
    sigma2=mean(r.^2)*Ns/(2*10^(Eb_N0_db(i)/10));
    bruit=sqrt(sigma2)*randn(1,nb_bits*Ns);
    
    r = r + bruit;
    
    %Filtre de réception    
    r_filtre = filter(hr,1,r);
    
    %Echantillonnage
    z_ech=r_filtre(t0:Ns:end);    
    symbole_est=sign(z_ech);
    bits_est=(symbole_est+1)/2;
    
    %Calcul du TEB
    TEB(i)=mean(bits_est(1+Ns+L/2:end)~=bits(1:end-Ns-L/2));

end

%Tracé du TEB réel
figure
plot(Eb_N0_db,10*log10(TEB));
xlabel("SNR (dB)");
ylabel("TEB");
title("TEB réel");

%Comparaison des TEB réel et théorique de la chaine étudiée
figure 
TEB_th=1-normcdf(sqrt(2*10.^(Eb_N0_db/10)));
plot(Eb_N0_db,10*log10(TEB));
hold on
plot(Eb_N0_db,10*log10(TEB_th),'r');
xlabel("SNR (dB)");
ylabel("TEB");
legend("TEB réel","TEB théorique");
title("Comparaison des TEB réel et théorique de la troisième chaine");

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
title("Comparaison du TEB réel de la troisième chaine et du TEB théorique de la chaine de référence");


%Comparaison des DSP des chaines 1 et 3
%DSP de la chaine 1
x1 = filter(ones(1,Ns),1,Suite_diracs);
DSP_x1=(1/length(x1))*abs(fft(x1,2^nextpow2(length(x1)))).^2;
figure
subplot(1,2,1);
plot(linspace(-1,1,length(DSP_x1)), fftshift(DSP_x1));
xlabel("Fréquences normalisées");
title("DSP du signal de la chaine 1");

%Calcul de la DSP du signal 3
subplot(1,2,2);
DSP_x3=(1/length(x))*abs(fft(x,2^nextpow2(length(x)))).^2;
plot(linspace(-1,1,length(DSP_x3)), fftshift(DSP_x3));
xlabel("Fréquences normalisées");
title("DSP du signal de la chaine 3");

%Diagramme de l'oeil avec passage dans le canal de transmission
% BW = 1500 Hz
%Génération de la réponse impulsionnelle du filtre passe bas (canal)
f0 = 1500;
hk = fir1(N,2*f0/Fe);
hk = hk/norm(hk);

%Diagramme de l'oeil
x_canal_1 = filter(hk,1,x);
x_f_1 = filter(hr,1,x_canal_1);
figure;
y=reshape(x_f_1,Ns,nb_bits);
plot(y);
xlabel("Temps");
title("Diagramme de l'oeil (BW = 1500 Hz)");

% BW= 3000 Hz
%Génération de la réponse impulsionnelle du filtre passe bas (canal)
f0 = 3000;
hk = fir1(N,2*f0/Fe);
hk = hk/norm(hk);

%Diagramme de l'oeil
x_canal_1 = filter(hk,1,x);
x_f_1 = filter(hr,1,x_canal_1);
figure;
y=reshape(x_f_1,Ns,nb_bits);
plot(y);
xlabel("Temps");
title("Diagramme de l'oeil (BW = 3000 Hz)");


