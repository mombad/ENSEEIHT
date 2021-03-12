function coeff_compression=coeff_compression_texte(texte,texte_encode)
Taille_non_encode=length(texte)*8;
Taille_encode=length(texte_encode);
coeff_compression=Taille_non_encode/Taille_encode;