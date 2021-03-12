package allumettes;
import java.util.Random;

public class StrategieNaif implements Strategie  {

	@Override
	public int getPrise(Jeu jeu) throws CoupInvalideException {
		int n = jeu.getNombreAllumettes() + 1;
		Random r = new Random();
		while (n > jeu.getNombreAllumettes()) {
			n = r.nextInt(2) + 1;
		}
		return n;
	}
}
