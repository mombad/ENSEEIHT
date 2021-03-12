load SG1.mat;
load ImSG1;

%MCO

A=[-Data(:) ones(length(Data(:)),1)];
B=[log(DataMod(:))];
gamma=pinv(A)*B;

New_Data=-log(DataMod)/gamma(1) + gamma(2)/gamma(1);
figure;
subplot(2,2,1);

imagesc(Data);
title("Image originale");
colormap gray;

subplot(2,2,2);
imagesc(New_Data);
title("Image retrouvée");

subplot(2,2,3);
imagesc(DataMod);
title("Image brouillée");

% Erreur
e=sqrt(mean(mean((Data-New_Data).^2)))


%MCT
C=[A B];
[U,sigma,V]=svd(C);
p=size(A,2);
sigma(p+1,p+1);
gamma_mct=V(1:end-1,end)/-(V(end,end));