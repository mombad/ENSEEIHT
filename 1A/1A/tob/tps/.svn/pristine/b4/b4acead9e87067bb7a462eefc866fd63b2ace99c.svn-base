package allumettes;
import org.junit.*;
import static org.junit.Assert.*;

public class StrategieRapideTest {

// La stratégie rapide doit toujours choisir de prendre
// le plus grand nombre d'allumettes disponibles.
	
	static final int NB_ALLUMETTES = 13;

	private Joueur rapide;

	@Before public void  setUp() {
		rapide = new Joueur("Rapido", new StrategieRapide());
	}

	@Test
	public void testPRISEMAX() throws OperationInterditeException, CoupInvalideException {
		JeuReel jeu = new JeuReel(NB_ALLUMETTES);
		assertEquals(rapide.getPrise(jeu), Jeu.PRISE_MAX);
	}

	@Test
	public void testPRISE2() throws OperationInterditeException, CoupInvalideException {
		JeuReel jeu = new JeuReel(2);
		assertEquals(rapide.getPrise(jeu), 2);
	}

	@Test
	public void testPRISE1() throws OperationInterditeException, CoupInvalideException {
		JeuReel jeu = new JeuReel(1);
		assertEquals(rapide.getPrise(jeu), 1);
	}
	

}
