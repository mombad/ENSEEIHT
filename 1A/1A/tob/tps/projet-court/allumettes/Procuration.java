package allumettes;

public class Procuration implements Jeu {

	private Jeu partie;

	public Procuration(Jeu jeu) {
		this.partie = jeu;
	}
	@Override
	public int getNombreAllumettes() {
		return this.partie.getNombreAllumettes();
	}

	@Override
	public void retirer(int nbPrises) throws CoupInvalideException,
	OperationInterditeException {
			throw new OperationInterditeException();
	}
}