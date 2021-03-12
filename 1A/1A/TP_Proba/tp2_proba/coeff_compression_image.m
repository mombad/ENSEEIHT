function coeff_compression= coeff_compression_image(histogramme,dico)
Taille_non_encode=0;
Lh=length(histogramme);
for i=1:Lh
    Taille_non_encode=Taille_non_encode+histogramme(i);
end
Taille_non_encode=Taille_non_encode*8;

Taille_encode=0;
for i=1:Lh
    Taille_encode=Taille_encode + histogramme(i)*length(dico{i,2});
end
coeff_compression=Taille_non_encode/Taille_encode;

