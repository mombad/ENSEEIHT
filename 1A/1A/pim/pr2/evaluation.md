% Évaluation
%

Remarque : Évaluation automatique dans evaluation-auto.txt

# Spécification du module ensemble (5 pt) : 3.5

Fichiers : ensembles_tableau.ads et ensembles_chainage.ads

(E5) Dans le tableau suivant, X ou un nombre de points de pénalité dans une
case indique que l'erreur apparaît pour ce SP.  Les numéros de sous-programme
correspondent à :

1. Savoir si un ensemble est vide ou pas
2. Obtenir la taille d´un ensemble (le nombre d´éléments qu´il contient).
3. Savoir si un élément est présent dans un ensemble.
4. Ajouter un élément dans un ensemble.
5. Supprimer un élément d´un ensemble.
6. Initialiser et Détruire
7. Appliquer_Sur_Tous n'est pas dans le tableau

+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
|                                 |      Ensembles_Tableau            ||     Ensembles_Chainage            |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
|                           | pts | SP1 | SP2 | SP3 | SP4 | SP5 | SP6 || SP1 | SP2 | SP3 | SP4 | SP5 | SP6 |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
| Signature incorrecte      |  1  |     |     |     |     |     |     ||     |     |     |     |     |     |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
| Objectifs imprécis        | .5  |     |     |     |     |     |     ||     |     |     |     |     |     |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
| Paramètres mal décrits    | .5  |     |     |     |     |     |     ||     |     |     |     |     |     |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
| Erreur sur précondition   | .5  |     |     |     |     |     |     ||     |     |     |     |     |     |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+
| Erreur sur postcondition  | .5  |     |  X  |     |  X  |  X  |     ||     |  X  |     |  X  |  X  |     |
+---------------------------+-----+-----+-----+-----+-----+-----+-----++-----+-----+-----+-----+-----+-----+

1 point de pénalité pour chacun des points suivants non respectés :

* Noms mal choisis pour les noms des SP (pas de verbe pour les fonctions, verbe pour les procédures, nom significatif)

# Implantation du module ensemble (7 pt) : 7

Fichiers : ensembles_tableau.adb et ensembles_chainage.adb

1 pt perdu pas erreur d'implantation d'un sous-programme (.5 pt si maladresse non listée dans la suite) :

+--------------+------------------------------+------------------------------+
| sous-prog.   |      Ensembles_Tableau       |      Ensembles_Chainage      |
+--------------+------------------------------+------------------------------+
| est vide     |                              |                              |
+--------------+------------------------------+------------------------------+
| taille       |                              |                              |
+--------------+------------------------------+------------------------------+
| est_present  |                              |                              | 
+--------------+------------------------------+------------------------------+
| ajouter      |                              |                              |
+--------------+------------------------------+------------------------------+
| supprimer    |                              |                              |
+--------------+------------------------------+------------------------------+
| initialiser  |                              |                              |
+--------------+------------------------------+------------------------------+
| detruire     |                              |                              |
+--------------+------------------------------+------------------------------+
| appliquer    |                              |                              |
+--------------+------------------------------+------------------------------+

# Les programmes (5 pt) : 3.5

Fichiers : scenario_tableau.adb, scenario_chainage.adb, nombre_moyen_tirages_tableau.adb, nombre_moyen_tirages_chainage.adb, test_ensembles_tableau.adb et test_ensembles_chainage.adb.

+---------------------------------+----------+--------+--------++----------+--------+--------+
|                                 |       Ensembles_Tableau    ||     Ensembles_Chainage     |
+-----------------------+---------+----------+--------+--------++----------+--------+--------+
|                       |   pts   | Scénario | Nombre |  Test  || Scénario | Nombre |  Test  |
+-----------------------+---------+----------+--------+--------++----------+--------+--------+
| Erreur de compilation |  2 * 1  |          |        |        ||          |        |        |
+-----------------------+---------+----------+--------+--------++----------+--------+--------+
| Erreur d'exécution    | 2 * .5  |          |        |        ||          |        |        |
+-----------------------+---------+----------+--------+--------++----------+--------+--------+
| Erreur valgrind       | 2 * .5  |          |        |        ||          |        |        |
+-----------------------+---------+----------+--------+--------++----------+--------+--------+

Les points suivants ajoutent jusqu'à 1 pt de pénalité :

* Pas de définition de sous-programmes dans Test_Ensemble
* Maladresses dans l'implantation du programme Nombre_Moyen_Tirages (.25 par item)
    - Le type du nombre de tirage devrait être entier
    - Pas de commentaires de raffinage

# LISEZ-MOI.txt (3 pt) : 2

Mauvaises réponses (ou pas de réponse) aux questions suivantes (.5 pt) :

* Question 1 (SP locaux)
* Question 6 (Efficacité)

# Note finale : 16
