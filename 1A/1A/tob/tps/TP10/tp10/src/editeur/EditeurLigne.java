package editeur;

import editeur.commande.*;
import menu.CommandeMenu;
import menu.Menu;

/** Un éditeur pour une ligne de texte.  Les commandes de
 * l'éditeur sont accessibles par un menu.
 *
 * @author	Xavier Crégut
 * @version	1.6
 */
public class EditeurLigne {

	/** La ligne de notre éditeur */
	private Ligne ligne;

	/** Le menu principal de l'éditeur */
	private Menu menuPrincipal;
	private Menu sousMenu1;
	private Menu sousMenu2;
		// Remarque : Tous les éditeurs ont le même menu mais on
		// ne peut pas en faire un attribut de classe car chaque
		// commande doit manipuler la ligne propre à un éditeur !

	/** Initialiser l'éditeur à partir de la lign à éditer. */
	public EditeurLigne(Ligne l) {
		ligne = l;

		// Créer le menu principal
		menuPrincipal = new Menu("Menu principal");
		sousMenu1 = new Menu("Sous Menu 1 : Curseur");
		sousMenu2 = new Menu("Sous Menu 2 : Texte");
		
		sousMenu2.ajouter("Ajouter un texte en fin de ligne",
					new CommandeAjouterFin(ligne));
		sousMenu1.ajouter("Avancer le curseur d'un caractère",
					new CommandeCurseurAvancer(ligne));
		sousMenu1.ajouter("Reculer le curseur d'un caractère",
					new CommandeCurseurReculer(ligne));
		sousMenu1.ajouter("Placer le curseur au début de la ligne", new CommandeCurseurDebut(ligne));
		sousMenu2.ajouter("Supprimer le caractère sous le curseur", new CommandeSupprimerCurseur(ligne));
		
		menuPrincipal.ajouter("Accéder au sous menu pour manipuler le curseur", new CommandeMenu(sousMenu1,new CommandeInitialiser(ligne)));
		menuPrincipal.ajouter("Accéder au sous menu pour manipuler le curseur", new CommandeMenu(sousMenu2));

	}

	public void editer() {
		do {
			// Afficher la ligne
			System.out.println();
			ligne.afficher();
			System.out.println();

			// Afficher le menu
			menuPrincipal.afficher();

			// Sélectionner une entrée dans le menu
			menuPrincipal.selectionner();

			// Valider l'entrée sélectionnée
			menuPrincipal.valider();

		} while (! menuPrincipal.estQuitte());
	}

}
