package editeur.commande;

import editeur.Ligne;

/** Supprimer le caractère sous le curseur.	
 */
public class CommandeSupprimerCurseur
	extends CommandeLigne
{

	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeSupprimerCurseur(Ligne l) {
		super(l);
	}

	public void executer() {
		ligne.supprimer();
	}

	public boolean estExecutable() {
		return 0 < ligne.getLongueur();
	}

}