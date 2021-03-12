inv() {
    if [ $# -eq 0 ]
    then echo "inv <chaîne non vide> qui inverse la chaîne de caractères fournie en paramètre et l'affiche. Si le paramètre est oublié, la commande affiche son mode d'emploi."
    else
	chaine=$1
	resultat=''		
	i=$(echo -n $chaine | wc -m)
        while [ $i != 0 ] 
	do
		lettre=$(echo $chaine | cut -c$i)
     		resultat="$resultat$lettre"
		i=$((i-1))
		
	done
	echo $resultat
    fi
}



