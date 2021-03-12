package allumettes;

public class Joueur {

	private String nom;
	private Strategie strategie;

	protected Joueur(String nom, Strategie strategie) {
		this.nom = nom;
		this.strategie = strategie;
	}

	public String getNom() {
		return this.nom;
	}

	public Strategie getStrategie() {
		return this.strategie;
	}

	public int getPrise(Jeu jeu) throws OperationInterditeException,
		CoupInvalideException {

		return this.strategie.getPrise(jeu);
	}

	public String toString() {
		return this.nom;
	}
}
