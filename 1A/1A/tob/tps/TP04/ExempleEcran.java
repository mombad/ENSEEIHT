import java.awt.Color;
import afficheur.Ecran;
public class ExempleEcran {	
	public static void main(String[] args) {
		Ecran e1 = new Ecran("ExempleEcran",400,250,15);
		e1.dessinerAxes();
		e1.dessinerPoint(1,2,Color.green);
		e1.dessinerLigne(6, 2, 11, 9, Color.red);
		e1.dessinerCercle(4, 4, 2.5, Color.yellow);
		e1.dessinerTexte(1, -2, "Premier dessin", Color.blue);
	}
}
