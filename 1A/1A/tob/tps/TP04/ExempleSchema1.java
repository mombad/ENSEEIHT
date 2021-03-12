import afficheur.Ecran;
import afficheur.AfficheurSVG;

/** Construire le schéma proposé dans le sujet de TP avec des points,
  * et des segments.
  *
  * @author	Xavier Crégut
  * @version	$Revision: 1.7 $
  */
public class ExempleSchema1 {

	/** Construire le schéma et le manipuler.
	  * Le schéma est affiché.
	  * @param args les arguments de la ligne de commande
	  */
	public static void main(String[] args)
	{
		// Créer les trois segments
		Point p1 = new Point(3, 2);
		Point p2 = new Point(6, 9);
		Point p3 = new Point(11, 4);
		Segment s12 = new Segment(p1, p2);
		Segment s23 = new Segment(p2, p3);
		Segment s31 = new Segment(p3, p1);

		// Créer le barycentre
		double sx = p1.getX() + p2.getX() + p3.getX();
		double sy = p1.getY() + p2.getY() + p3.getY();
		Point barycentre = new Point(sx / 3, sy / 3);

		// Afficher le schéma
		System.out.println("Le schéma est composé de : ");
		s12.afficher();		System.out.println();
		s23.afficher();		System.out.println();
		s31.afficher();		System.out.println();
		barycentre.afficher();	System.out.println();
		
		Ecran e1 = new Ecran("ExempleEcran",600,400,20);
		s12.dessiner(e1);
		s23.dessiner(e1);
		s31.dessiner(e1);
		barycentre.dessiner(e1);;
		e1.dessinerAxes();
		
		s12.translater(4, -3);
		s23.translater(4, -3);
		s31.translater(4,-3);
		barycentre.translater(4, -3);
		
		
		Ecran e2 = new Ecran("ExempleEcran translaté",600,400,20);
		s12.dessiner(e2);
		s23.dessiner(e2);
		s31.dessiner(e2);
		barycentre.dessiner(e2);;
		e2.dessinerAxes();
		
		AfficheurSVG a1 = new AfficheurSVG("ExempleAfficheurSVG translaté","description de l'afficheur",600,400);
		s12.dessiner(a1);
		s23.dessiner(a1);
		s31.dessiner(a1);
		barycentre.dessiner(a1);
		//a1.ecrire("schema.svg");
		
		AfficheurTexte t1 = new AfficheurTexte();
		s12.dessiner(t1);
		s23.dessiner(t1);
		s31.dessiner(t1);
		barycentre.dessiner(t1);
	}

}
