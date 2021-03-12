package allumettes;

public class TricheurException extends RuntimeException {
	
	public TricheurException(Joueur j) {
		super("Partie Abandonnée car " + j + " a triché.");
	}
}
