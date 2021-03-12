package editeur.commande;

import editeur.Ligne;

/** Placer le curseur au début.	
 */
public class CommandeCurseurDebut
	extends CommandeLigne
{

	/** Initialiser la ligne sur laquelle travaille
	 * cette commande.
	 * @param l la ligne
	 */
	//@ requires l != null;	// la ligne doit être définie
	public CommandeCurseurDebut(Ligne l) {
		super(l);
	}

	public void executer() {
		ligne.placerDebut();
	}

	public boolean estExecutable() {
		return ligne.getLongueur() > 0 ;
	}

}