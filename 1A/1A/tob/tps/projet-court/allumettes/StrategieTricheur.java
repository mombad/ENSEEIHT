package allumettes;

public class StrategieTricheur implements Strategie {

	@Override
	public int getPrise(Jeu jeu) throws CoupInvalideException  {
		while (jeu.getNombreAllumettes() > 2) {
			jeu.retirer(1);
		}
		return 1;
	}
}
