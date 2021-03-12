/*********************************************************************
 *  Auteur  : BEN AHMED DAHO Mohamed
 *  Version : 
 *  Objectif : Conversion pouces/centimètres
 ********************************************************************/

#include <stdio.h>
#include <stdlib.h>

int main(void)
{
    float UN_POUCE = 2.54;
    char unite;
    float valeur;
    float lg_cm;
    float lg_p;
    int rep=0;
    
    while (rep!=1){
    /* Saisir la longueur */
    printf("Entrer une longueur (valeur + unité) : ");
    scanf("%f" , &valeur);
    scanf("%c" , &unite);
    /* Calculer la longueur en pouces et en centimètres */
    switch (unite){
        case'p':
        case'P':
            lg_p=valeur;
            lg_cm=lg_p*UN_POUCE;
            break;
        case'c':
        case'C':
            lg_cm=valeur;
            lg_p=lg_cm/ UN_POUCE;
            break;
        case'm':
        case'M':
            lg_cm=valeur*100.0;
            lg_p=lg_cm/UN_POUCE;
            break;
        default:
            lg_p=0;
            lg_cm=0;          
    }
    printf("%1.5f %s %1.5f %s",lg_p,"p = ", lg_cm, " cm");
    printf("    Souhaitez vous recommencer ? Si non entrez '1'. ");
    scanf("%i", &rep);
    }
    /* Afficher la longueur en pouces et en centimètres */
       

    return EXIT_SUCCESS;
}
