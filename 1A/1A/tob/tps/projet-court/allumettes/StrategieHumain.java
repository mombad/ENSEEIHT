package allumettes;

import java.util.InputMismatchException;
import java.util.Scanner;

public class StrategieHumain implements Strategie {
	private Scanner scanner = new Scanner(System.in);

	@Override
	public int getPrise(Jeu jeu)  throws CoupInvalideException {
		int n = 0;
		boolean fini = false;
		while (!fini) {
			try {
				System.out.print("Combien prenez-vous d'allumettes ? ");
				n = scanner.nextInt();
				fini = true;
				} catch (InputMismatchException e) {
					scanner.nextLine();
					System.out.println("Vous devez "
							+ "donner un entier.");
					}
			}
		return n;
		}
	}