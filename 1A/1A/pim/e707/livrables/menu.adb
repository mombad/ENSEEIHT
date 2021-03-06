with arbre_genealogique;
use arbre_genealogique;
with registre;
use registre;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with lien;
use lien;
with foret;
use foret;

procedure menu is
    A:T_Arbre_Gen;
    R:T_Registre;
    ajout,rep_exception,rep_exception1,rep_registre : Character;
    rep_foret,reponse : Integer;
    Cle,Cle_parent,Cle_m,Cle_n : Integer;
    Info :T_Info;
    Gen : Integer;
    Arbre_Selectionne_nb : Integer;
    Nouvelle_Racine : Integer;
    Nouvel_Arbre : T_Arbre_Gen;
    F: T_Foret;
    Cle_reg1, Cle_reg2 : Integer;

    procedure detect_exception_ancetre (A: in T_Arbre_Gen; Cle: in Integer) is
    begin
      Put(Obtenir_nb_ancetres(A,Cle));
      New_Line;
      Put("-Opération réussie");
      New_Line;
    exception
        when Est_Absent_Cle => Put("attention! Cle absente");
            New_Line;
         Put("-echec de l'operation");
         New_Line;
    end detect_exception_ancetre;


    procedure detect_exception_2(A : in out T_Arbre_Gen; Cle: in Integer; Gen : in Integer) is
    begin
        -- Put("Liste des ancetres : ");

      New_Line;
      Put("Cles : ") ;
        New_Line;
        afficher_Liste(Obtenir_nb_ancetres_Gen(A,Cle,Gen));
        New_Line;
      Put("opération réussie");
      New_Line;


    exception
        when Est_Absent_Cle => Put("recherche impossible :la Cle est absente");
            New_Line;
            Put("Echec de l'operation");
            New_Line;
    end detect_exception_2;


    procedure detect_exception_3(A: in out T_Arbre_Gen; Cle: in Integer) is
    begin
        Afficher_Arbre_Gen(A,Cle);
        Put("Operation reussie");
    exception
        when Est_Absent_Cle => Put("Affichage impossible : la cle est absente");
            New_Line;
            Put("echec de l'operation");
            New_Line;
    end detect_exception_3;

    procedure detect_exception_ajouter(A: in out T_Arbre_Gen;R: in out T_Registre;  Cle_Parent : in Integer; Cle_enfant : in Integer) is
        A1 : T_Arbre_Gen;
    begin
        Get(ajout);
        if ajout = 'p' then
            Ajouter_Arbre_Gen(A,R,Cle_parent,Cle_enfant,True);
        else
            Ajouter_Arbre_Gen(A,R,Cle_parent,Cle_enfant,False);
        end if;

    exception
        when Est_Present_Cle => Put("erreur: cette clé est déja utilisée");
            New_Line;
            Put("echec de l'operation");
            New_Line;
        when Est_absent_Cle => Put("erreur: Cle enfant absente");
            New_Line;
            Put("generer cle enfant?");
            New_Line;
            Put("o/n: ");
            Get(rep_exception);
            if rep_exception = 'o' then
                if ajout = 'g' then
                    Ajouter_Arbre_Gen(A,R,Cle_enfant,obtenir_element(Aucun_Parent(A)),True);
                    Ajouter_Arbre_Gen(A,R,Cle_parent,Cle_enfant,True);

                else
                    Ajouter_Arbre_Gen(A,R,Cle_enfant,obtenir_element(Aucun_Parent(A)),False);
                end if;

            else
                Put(" vous avez abandonne l'operation ajouter");
            end if;

        when others => put("le noeud est déjà occupé ");
            New_Line;
            Put("remplacer l'ancien noeud par le nouveau (o/n)?");
            New_Line;
            Get(rep_exception1);
            if rep_exception1 = 'o' then
                if ajout = 'g' then
                    chercher_Noeud(A,A1,Cle_enfant);
                    supprimer_R_individu(R,obtenir_cle(gauche(A1)));
                    Ajouter_R_individu(R,Cle_parent);
                    egal(A1,gauche(A1));
                    egal_Cle(A1,Cle_parent);
                else
                    chercher_Noeud(A,A1,Cle_enfant);
                    supprimer_R_individu(R,obtenir_cle(droite(A1)));
                    Ajouter_R_individu(R,Cle_parent);
                    egal(A1,droite(A1));
                    egal_Cle(A1,Cle_parent);
                end if;
                New_Line;
                Put("operation reussie");
                New_Line;
            else
                null;
            end if;

    end detect_exception_ajouter;




    procedure detect_exception_ajouter_bis(A: in out T_Arbre_Gen;R: in out T_Registre;  Cle_Parent : in Integer; Cle_enfant : in Integer) is
    begin
        detect_exception_ajouter(A,R,Cle_Parent,Cle_enfant);
    exception
        when Est_absent_Cle => Put("erreur : cette clé est absente de l'arbre");
            New_Line;
            Put("echec de l'operation");
            New_Line;

    end detect_exception_ajouter_bis;


    procedure detect_exception_4(A: in out T_Arbre_Gen; R: in out T_Registre; Cle : in Integer) is
    begin
        Supprimer_Noeud_Gen(A,Cle,R);
        Put("operation reussie");
    exception
        when est_absent_cle => Put("erreur: la cle entrée n'existe pas");
            New_Line;
            Put("echec de l'operation");
            New_Line;
    end detect_exception_4;



    procedure detect_exception_8(A : in T_Arbre_Gen;Cle:in Integer; Gen: in Integer) is
    begin
        Put(" Liste des ancetres de l'individu choisi sur ");
        Put(gen);
        Put(" generation : ");
        Afficher_Liste(Ancetres_Gen(A,Cle,Gen));
        New_Line;
        Put("operation reussie");

    exception

        when Est_Absent_Cle => Put("attention! Cle absente");
            New_Line;
            Put("-echec de l'operation");
            New_Line;
    end detect_exception_8;




    procedure detect_exception_9(A: in T_Arbre_Gen;R: in T_Registre; n: in Integer; m: in Integer) is
    begin
        Put(" Liste des cles des ancetres homonymes de n et m :  ");
        afficher_Liste(Homonyme(A,R,n,m));
    exception
        when Est_Absent_Cle => Put("erreur: une des cles entrées n'existe pas");
            New_Line;
            Put("echec de l'operation");
            New_Line;
    end detect_exception_9;











begin
    New_Line;
    New_Line;

    Put("**********************************BIENVENUE DANS LE PROGRAMME DE GESTION D'ARBRE GENEALOGIQUE************************************");
    New_Line;
    New_Line;
    New_Line;
    Put("Création du premier_arbre");
    New_Line;
    Put("Entrer le premier individu");
    New_Line;
    Put("Cle associee : ");
    Get(Cle);
    New_Line;
    Initialiser_Arbre_Gen(A,Cle);
    Initialiser_R(R);
    Ajouter_R_individu(R,Cle);
    Initialiser_Foret(F);
    Ajouter_Foret(F,A);
    Skip_Line;
    New_Line;
    New_Line;
    reponse:= 12;
    rep_foret:=12;

    while rep_foret/=0 loop
        New_Line;
        New_Line;
        Put("********************************");
        Put("Menu Principal");
        Put("********************************");
        New_Line;
        New_Line;
        Put("Que voulez-vous faire");
        New_Line;
        New_Line;
        Put("1-Créer un nouvel arbre et l'ajouter à la forêt");
        New_Line;
        Put("2-Modifier un arbre existant");
        New_Line;
        Put("3-Afficher la liste des arbres présents dans la forêt");
        New_Line;
        Put("4-Acceder au registre");
        New_Line;
        Put("0-Quitter le programme");
        New_Line;
        Get(rep_foret);

        if rep_foret=2 then
            Arbre_Selectionne_nb:=0;
            Put("Quel arbre voulez-vous sélectionner ?");
            New_Line;
            Afficher_Foret(F);
            New_Line;
            while not Est_Present_Foret(F,Arbre_Selectionne_nb) loop
                Put("Veuillez entrez la clé correspondant à l'arbre choisi");
                New_Line;
                Get(Arbre_Selectionne_nb);
                if not Est_Present_Foret(F,Arbre_Selectionne_nb) then
                    Put("L'arbre voulu n'est pas présent dans la foret");
                    New_Line;
                else
                    null;
                end if;
            end loop;
            egal(A,Obtenir_Arbre(F,Arbre_Selectionne_nb));
            reponse:=12;
            while reponse/= 0 loop
                New_Line;
                New_Line;
                Put("********************Arbre courant");
                Put(" ********************");
                New_Line;
                Put("                 ");
                Put(Arbre_selectionne_nb);
                Put("                                       ");
                New_Line;
                Put("******************************************************");
                New_Line;
                New_Line;
                Put("1-Ajouter un individu");
                New_Line;
                Put("2-Obtenir le nombre d'ancetres connus d'un individu");
                New_Line;
                Put("3-Obtenir l'ensembles des ancetres situees a une certaine generation d'un individu");
                New_Line;
                Put("4-Afficher l'arbre d'un individu");
                New_Line;
                Put("5-Supprimer un individu et ses ancetres");
                New_Line;
                Put("6-Obtenir l'ensemble des individus qui n'ont qu'un parent connu");
                New_Line;
                Put("7-Obtenir l'ensemble des individus dont les deux parents sont connus");
                New_Line;
                Put("8-Obtenir l'ensemble des individus dont les 2 parents sont inconnus");
                New_Line;
                Put("9-Identifier les ancetres d'un individu sur n generations");
                New_Line;
                Put("10-Verifier que 2 individus un ou plusieurs ancetres homonymes");
                New_Line;
                Put("0-Pour revenir au menu principal");
                New_Line;
                Get(reponse);
                if reponse = 1 then
                    Put("-Vous avez choisi l'option : ajouter un individu ");
                    New_Line;
                    Put(" Veuillez entrer la Cle et l'information associees a  l'individu ainsi que la cle associee au parent.");
                    New_Line;
                    Put("Cle de l'enfant : ");
                    Get(Cle);
                    Put("Cle du parent : ");
                    Get(Cle_parent);
                    Put("Veuillez entrer 'm' pour ajouter une mere, 'p' pour ajouter un pere ");
                    detect_exception_ajouter(A,R,Cle_parent,Cle);
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("***********************************************************************************************************************");
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("-Veuillez choisir une autre action a effectuer");
                    New_Line;

                elsif reponse = 2 then
                    Put("-Vous avez choisi l'option : obtenir le nombre d'ancetres connus d'un individu ");
                    New_Line;
                    Put("veuillez entrer la Cle associee a  l'individu");
                    New_Line;
                    Put("Cle : ");
                    Get(Cle);
                    New_Line;
                    Put("le nombre d'ancetre correspondant a  cet individu y compris lui est : ");

                    detect_exception_ancetre(A,Cle);
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("***********************************************************************************************************************");
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("-Veuillez choisir une autre action a  effectuer : ");

                elsif reponse = 3 then
                    Put("-Vous avez choisi l'option : obtenir l'ensembles des ancetres situes a  une certaine generation d'un individu ");
                    New_Line;
                    Put(" Veuillez entrer la Clé associée à l'individu ainsi que la generation a  laquelle se situe les ancetres.");
                    New_Line;
                    Put("Cle : ");
                    Get(Cle);
                    New_Line;

                    Put("Generation : ");
                    Get(gen);
                    detect_exception_2(A,Cle,gen);
                    New_Line;
                    New_Line;
                    New_Line;

                    Put("***********************************************************************************************************************");
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("-Veuillez choisir une autre action a  effectuer");
                    New_Line;

                elsif reponse = 4 then
                    Put("-Vous avez choisi l'option : afficher l'arbre d'un individu ");
                    New_Line;
                    Put("veuillez entrer la Cle associee a  l'individu");
                    New_Line;
                    Put("Cle : ");
                    get(CLe);
                    New_Line;
                    detect_exception_3(A,Cle);
                    New_Line;
                    New_Line;
                    New_Line;

                    Put("***********************************************************************************************************************");
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("-Veuillez choisir une autre action a  effectuer");
                    New_Line;

                elsif reponse = 5 then
                    Put("-Vous avez choisi l'option : supprimer un individu et ses ancetres ");
                    New_Line;
                    Put("veuillez entrer la Clé associée à  l'individu");
                    New_Line;
                    Put("Cle : ");
                    Get(Cle);
                    detect_exception_4(A,R,Cle);
                    New_Line;
                    New_Line;
                    New_Line;

                    Put("***********************************************************************************************************************");
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("-Veuillez choisir une autre action a  effectuer");
                    New_Line;

                elsif reponse = 6 then
                    Put("-Vous avez choisi l'option : obtenir la liste des individus ayant un seul parent connu ");
                    New_Line;
                    Put(" Liste des Clés des individus ayant un seul parent : ");
                    Afficher_Liste(Un_Parent(A));
                    New_Line;
                    Put("operation reussie");
                    New_Line;
                    New_Line;
                    New_Line;

                    Put("***********************************************************************************************************************");
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("-Veuillez choisir une autre action a  effectuer");
                    New_Line;

                elsif reponse = 7 then
                    Put("-Vous avez choisi l'option : obtenir la liste des individus ayant deux parents connus ");
                    New_Line;
                    Put(" Liste des Clés des individus ayant un seul parent : ");
                    Afficher_Liste(deux_Parents(A));
                    New_Line;
                    Put("operation reussie");
                    New_Line;
                    New_Line;
                    New_Line;

                    Put("***********************************************************************************************************************");
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("-Veuillez choisir une autre action a  effectuer");
                    New_Line;

                elsif reponse = 8 then
                    Put("-Vous avez choisi l'option : obtenir la liste des individus dont les deux parents sont inconnus ");
                    New_Line;
                    Put(" Liste des Clés des individus dont les deux parents sont inconnus : ");
                    Afficher_Liste(Aucun_Parent(A));
                    New_Line;
                    Put("operation reussie");
                    New_Line;
                    New_Line;
                    New_Line;

                    Put("***********************************************************************************************************************");
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("-Veuillez choisir une autre action a  effectuer");
                    New_Line;

                 elsif reponse = 9 then
                     Put("-Vous avez choisi l'option : identifier la liste des ancetres d'un individu sur n generation ");
                    New_Line;
                    Put(" entrer la cle associee à l'individu et le nombre de generation n ");
                    New_Line;
                    Put( " Cle : ");
                    get(Cle);
                    New_Line;
                    Put(" n : ");
                    get(gen);
                    detect_exception_8(A,Cle,Gen);
                    Put("***********************************************************************************************************************");
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("-Veuillez choisir une autre action a  effectuer");
                    New_Line;

                 elsif reponse = 10 then
                     Put("--Vous avez choisi l'option : verifier que deux individus n et m ont un ou plusieurs ancetres homonymes ");
                    New_Line;
                    Put(" entrer les cles associees aux individus n et m");
                    New_Line;
                    Put( " Cle de n : ");
                    get(Cle_n);
                    Put( "Cle de m : ");
                    New_Line;
                    get(Cle_m);
                    detect_exception_9(A,R,Cle_n,Cle_m);
                    New_Line;
                    Put("***********************************************************************************************************************");
                    New_Line;
                    New_Line;
                    New_Line;
                    Put("Veuillez choisir une autre action a effectuer");
                 New_Line;
                 elsif reponse=0 then
                     New_Line;

                 else
                     Put("veuillez entrer un nombre entre 1 et 10");
                end if;
            end loop;



        elsif rep_foret=1 then
            New_Line;
            Put("Veuillez entrer la clé du nouvel arbre : ");
            Get(Nouvelle_Racine);
            New_Line;
            while Est_Present_R(R,Nouvelle_Racine) loop
                Put("Cette clé est déja présente dans le registre, veuillez entrer une nouvelle clé : ");
                Get(Nouvelle_Racine);
                New_Line;
            end loop;
            Put("La clé entrée est valide");
            Ajouter_R_individu(R,Nouvelle_Racine);
            Initialiser_Arbre_Gen(Nouvel_Arbre,Nouvelle_Racine);
            Ajouter_Foret(F,Nouvel_Arbre);
            New_Line;
            Put("L'arbre a bien été ajouté");
            New_Line;
            New_Line;

        elsif rep_foret=3 then
            New_Line;
            Put("Liste des arbres présents dans la forêt : ");
            Afficher_Foret(F);
            New_Line;

        elsif rep_foret = 4 then
            rep_registre:='z';

            while rep_registre/='q' loop
                New_Line;
                New_Line;
                Put("**********Registre**********");
                New_Line;
                New_Line;
                Put("Que voulez-vous faire?");
                New_line;
                New_Line;
                Put("(d) Définir une relation entre deux individus ou afficher les personnes liés à un individu");
                New_Line;
                Put("(s) Supprimer une information");
                New_Line;
                Put("(a) Ajouter une information");
                New_Line;
                Put("(l) Lire le registre");
                New_Line;
                Put("(q) Retourner au menu principal ");
                New_Line;
                Put("Votre choix : ");
                get(rep_registre);
                New_Line;
                if rep_registre = 's' then
                    Put("Clé associée à l'info à supprimer : ");
                    Get(Cle);
                    Skip_Line;
                    Supprimer_R_information(R,Cle);

                elsif rep_registre ='a' then
                    Put("Clé associée à l'info à ajouter : ");
                    Get(Cle);
                    Skip_Line;
                    ajouter_R_info(R,Cle);

                elsif rep_registre='d' then

                    New_Line;
                    Put("Que voulez-vous faire ?");
                    New_Line;
                    Put("Voulez-vous définir une relation de conjugalité ou bien de fraternité (c/f) ");
                    New_Line;
                    Put("Afficher les personnes liées à un individu (a)");
                    New_Line;
                    Put("Votre Choix : ");
                    Get(rep_registre);

                    if rep_registre='c' then
                        Put("Vous avez choisi de définir un lien de conjugalité");
                        New_Line;
                        Put("Entrez les clés des deux personnes à lier : ");
                        New_Line;
                        Put("Clé 1 : ");
                        Get(Cle_reg1);
                        New_Line;
                        Put("Clé 2 : ");
                        Get(Cle_reg2);
                        conjoint(Cle_reg1,Cle_reg2,R);

                    elsif rep_registre='f' then
                        Put("Vous avez choisi de définir un lien de fraternité");
                        New_Line;
                        Put("Entrez les clés des deux personnes à lier : ");
                        New_Line;
                        Put("Clé 1 : ");
                        Get(Cle_reg1);
                        New_Line;
                        Put("Clé 2 : ");
                        Get(Cle_reg2);
                        frere(Cle_reg1,Cle_reg2,R);

                    elsif rep_registre='a' then
                        Put("Vous avez choisi d'afficher tous les liens d'un individu renseignés dans le registre");
                        New_Line;
                        Put("Pour quel individu souhaitez-vous connaître les liens : ");
                        Get(Cle_reg1);
                        New_Line;
                        Put("Liste des frères et soeurs : ");
                        Afficher_Liste_R(obtenir_frere(R,Cle_reg1));
                        New_Line;
                        Put("Liste des conjoints : ");
                        Afficher_Liste_R(obtenir_conjoint(r,Cle_reg1));
                        New_Line;
                        Put("Liste des beaux frères et belles soeurs : ");
                        Afficher_Liste_R(obtenir_beau_frere(R,Cle_reg1));
                        New_Line;
                    else
                        Put("La lettre tappée ne correspond à aucun choix");
                        New_Line;
                    end if;

                elsif rep_registre='q' then
                    Put("Retour au menu principal");
                    New_Line;
                else
                    Put("Affichage du registre");
                    New_Line;
                    afficher_R(R);
                end if;
            end loop;





        elsif rep_foret=0 then
            New_Line;
            New_Line;
            Put("Au revoir");

        else
            New_Line;
            Put("Veuillez entrer un nombre entre 0 et 4");
            New_Line;
        end if;

    end loop;

    Detruire_R(R);
    Vider_Foret(F);


end menu;
