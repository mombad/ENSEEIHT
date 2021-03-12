package allumettes;

public class Procuration implements Jeu {
	
	private Partie partie;
	
	public Procuration(int nombreInitialAllumettes) {
		this.partie = new Partie(nombreInitialAllumettes);
	}
	@Override
	public int getNombreAllumettes() {
		return this.partie.getNombreAllumettes();
	}

	@Override
	public void retirer(int nbPrises) throws CoupInvalideException, OperationInterditeException {
			throw new OperationInterditeException();
		
	}
	
	public void retirerPartie(int nbPrises) throws CoupInvalideException {
		this.partie.retirer(nbPrises);
	}

	

}


