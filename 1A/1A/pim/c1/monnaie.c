#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>

// Definition du type monnaie
// TODO 
struct Monnaie{
    float Valeur;
    char Devise;
};
typedef struct Monnaie Monnaie;
/**
 * \brief Initialiser une monnaie 
 * \param[ M:Monnaie* pointeur sur la monnaie à modifier
 *  \      V:float Valeur de la monnaie
 *  \      D:char Devise de la monnaie]
 * \pre 
 * // V=>0
 */ 
void initialiser(Monnaie* M, float V, char D) {
    
    assert(V>=0);
    (*M).Valeur=V;
    (*M).Devise=D;
}


/**
 * \brief Ajouter une monnaie m2 à une monnaie m1 
 * \param[M1:Monnaie* pointeur sur la monnaie 1
 * \      M2:Monnaie* pointeur sur la monnaie 2]
 * //
 */ 
bool ajouter(Monnaie* M1, Monnaie* M2) {
    
    if ((M1->Devise=M2->Devise)) {
    (*M2).Valeur+=(*M1).Valeur;
    return true;
    }else{
    return false;
    };
}


/**
 * \brief Tester Initialiser 
 * \param[]
 * // TODO
 */ 
void tester_initialiser() {
    // TODO

    Monnaie m;
    Monnaie* pm=&m;
    initialiser(pm,5,'e');
    assert(m.Valeur==5);
    assert(m.Devise=='e');
}

/**
 * \brief Tester Ajouter 
 * \param[]
 * // TODO
 */ 
void tester_ajouter() {
    // TODO
    Monnaie m;
    Monnaie* pm=&m;
    initialiser(pm,5,'e');

    Monnaie m1;
    Monnaie* pm1=&m1;
    initialiser(pm1,10,'$');

    Monnaie m2;
    Monnaie* pm2=&m2;
    initialiser(pm2,26,'e');
 
    bool V;
    V=ajouter(pm,pm2);
    assert(m2.Valeur==31);
    assert(V);

    bool F;
    F=ajouter(pm,pm1);
    assert(m1.Valeur==10);
    assert(!F);   
}



int main(void) {
    // Déclarer un tableau de 5 monnaies
    // TODO
    Monnaie porte_monnaie[5];
    
    //Initialiser les monnaies
    // TODO
    int v;          //valeur saisie par l'utilisateur
    char d;         //devise saisie par l'utilisateur
    for (int i=0;i<=4;i++){
        printf("%s","Veuillez entrez une valeur et une devise (valeur suivie de la devise) \n");
        scanf("%d",&v); 
        scanf("%c",&d);
        porte_monnaie[i].Valeur=v;
        porte_monnaie[i].Devise=d;
        printf("%s %d %c %s","La monnaie ", v,d," a été entrée \n");
        };


    // Afficher la somme de toutes les monnaies qui sont dans une devise entrée par l'utilisateur.
    // TODO
    char devise_voulue;
    printf("%s","Pour quelle devise voulez-vous connaitre le total ? \n");
    scanf("%s",&devise_voulue);
    int s=0;            //somme des monnaies de la devise voulue
    for (int j=0;j<=4;j++) {
        if (porte_monnaie[j].Devise==devise_voulue) {
            s+=porte_monnaie[j].Valeur;
        };
    };
    printf("%s %d %c %s","Vous avez",s,devise_voulue,"\n");
    return EXIT_SUCCESS;
}
