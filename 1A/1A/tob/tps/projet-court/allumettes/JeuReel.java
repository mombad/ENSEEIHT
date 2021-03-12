package allumettes;

public class JeuReel implements Jeu {

	private int nombreAllumettes;

	public JeuReel(int nombreInitialAllumettes) {
		this.nombreAllumettes = nombreInitialAllumettes;
	}

	@Override
	public int getNombreAllumettes() {
		return nombreAllumettes;
	}

	@Override
	public void retirer(int nbPrises) throws CoupInvalideException {
		if (nombreAllumettes - nbPrises < 0) {
			throw new CoupInvalideException(nbPrises, "> "
		+ nombreAllumettes);
		}
		if (nbPrises > Jeu.PRISE_MAX) {
			throw new CoupInvalideException(nbPrises, "> " + Jeu.PRISE_MAX);
		}
		if (nbPrises <= 0) {
			throw new CoupInvalideException(nbPrises, "< 1");
		}
		nombreAllumettes = nombreAllumettes - nbPrises;
	}

}