package allumettes;

public class StrategieExpert implements Strategie {

	@Override
	public int getPrise(Jeu jeu)  throws CoupInvalideException {
		int n = jeu.getNombreAllumettes();
		if (n > Jeu.PRISE_MAX + 1) {
			while (n > Jeu.PRISE_MAX + 1) {
				n = n - Jeu.PRISE_MAX - 1;
			}
			if (n > 1) {
				return n - 1;
			} else {
				return 1;
			}
		} else {
			if (jeu.getNombreAllumettes() > 1) {
				return jeu.getNombreAllumettes() - 1;
			} else {
				return 1;
			}
		}
	}
}
