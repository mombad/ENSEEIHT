
T = 0.04;
Te = 7.8125e-6;
fp2 = 46000;
slot = zeros(1,5120);
Ns = 10;
m1=kron(2*bits_utilisateur1-1,ones(1,Ns));
m2=kron(2*bits_utilisateur2-1,ones(1,Ns));
%3.2.2
%1.a
signal_MFTDMA1 = [slot,m1,slot,slot,slot];
signal_MFTDMA2 = [slot,slot,slot,slot,m2];
tableau_de_cos = zeros(1,25600);
tableau_de_cos(20481:25600) = cos(2*pi*fp2*[0:Te:5119*Te]);
%1.b
x1= signal_MFTDMA1*cos(0);
x2 = signal_MFTDMA2.*(tableau_de_cos);
%2.
x = x1 + x2;
Ps = mean(abs(x).^2);
Pb = Ps*10e-2;
sigma = sqrt(Pb);
bruit = sigma*rand(1,length(x));
xtot = x +  bruit;
figure;
plot([0:Te:(length(x)-1)*Te],xtot);
N = length(xtot);
DSP = periodogramme(xtot,N);
plot(linspace(0,1/Te,length(DSP)),DSP);

%4.
%Filtre
N = 1000;
T2 = 1/fp2;
Fe = 1/Te;
k=[-N*Te:Te:N*Te];
h_k = (fp2/Fe)*sinc(k*fp2);
Filter = %3.2.2
%1.a
signal_MFTDMA1 = [slot,m1,slot,slot,slot];
signal_MFTDMA2 = [slot,slot,slot,slot,m2];
tableau_de_cos = zeros(1,25600);
tableau_de_cos(20481:25600) = cos(2*pi*fp2*[0:Te:5119*Te]);
%1.b
x1= signal_MFTDMA1*cos(0);
x2 = signal_MFTDMA2.*(tableau_de_cos);
%2.
x = x1 + x2;
Ps = mean(abs(x).^2);
Pb = Ps*10e-2;
sigma = sqrt(Pb);
bruit = sigma*rand(1,length(x));
xtot = x +  bruit;
figure;
plot([0:Te:(length(x)-1)*Te],xtot);
N = length(xtot);
DSP = periodogramme(xtot,N);
plot(linspace(0,1/Te,length(DSP)),DSP);
fft(h_k);
figure;
plot(linspace(-Fe/2,Fe/2,length(h_k)),fftshift(abs(Filter)));

