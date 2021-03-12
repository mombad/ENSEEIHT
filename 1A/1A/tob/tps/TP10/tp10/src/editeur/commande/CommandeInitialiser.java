package editeur.commande;

import editeur.Ligne;

/** Reculer le curseur d'une position.
 * @author	Xavier Crégut
 * @version	1.4
 */
public class CommandeInitialiser
	extends CommandeLigne
{

	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeInitialiser(Ligne l) {
		super(l);
	}

	public void executer() {
		// Afficher la ligne
		System.out.println();	
		ligne.afficher();
		System.out.println();

	}

	public boolean estExecutable() {
		return ligne.getCurseur() > 1;
	}

}
