/**
 * CreneauInvalideException indique qu'une date n'est pas valide.
 */
public class CreneauInvalideException extends RuntimeException {
	private String chaine;
	
	public CreneauInvalideException(String chaine) {
		super(chaine);
	}
	
}
