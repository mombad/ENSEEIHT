package allumettes;

public class OperationInterditeException extends RuntimeException {

	public OperationInterditeException() {
		super("Partie abandonnée car ");
	}
}
