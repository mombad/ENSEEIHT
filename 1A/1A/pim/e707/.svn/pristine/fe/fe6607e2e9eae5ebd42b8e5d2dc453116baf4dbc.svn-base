with Arbre_Binaire;

procedure Test_Arbre_Binaire is
    Package Arbre_Binaire_Entier is new Arbre_Binaire (T_Cle => Integer);
    use Arbre_Binaire_Entier;

    A : T_Arbre_Binaire;
begin
    Initialiser_Arbre(A,1);
    Ajouter(A,2,1,True);
    Ajouter(A,3,1,False);
    Ajouter(A,4,2,True);
    Ajouter(A,5,3,True);
    Supprimer_Noeud(A,2);

    Detruire_arbre(A);



end Test_Arbre_Binaire;
