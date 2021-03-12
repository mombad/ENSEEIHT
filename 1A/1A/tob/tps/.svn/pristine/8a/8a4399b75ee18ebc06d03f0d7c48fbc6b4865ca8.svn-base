package allumettes;

public class StrategieRapide implements Strategie {

	@Override
	public int getPrise(Jeu jeu) throws CoupInvalideException {
		if (jeu.getNombreAllumettes() > Jeu.PRISE_MAX) {
			return Jeu.PRISE_MAX;
			} else {
			return jeu.getNombreAllumettes();
			}
		}
}
