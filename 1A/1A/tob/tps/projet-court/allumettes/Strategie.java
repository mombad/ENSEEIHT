package allumettes;

interface Strategie {

	int getPrise(Jeu jeu) throws OperationInterditeException,
		CoupInvalideException;
}
