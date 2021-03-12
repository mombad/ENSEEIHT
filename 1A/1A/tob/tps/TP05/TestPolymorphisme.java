/** Tester le polymorphisme (principe de substitution) et la liaison
 * dynamique.
 * @author	Xavier Crégut
 * @version	1.5
 */
public class TestPolymorphisme {

	/** Méthode principale */
	public static void main(String[] args) {
		// Créer et afficher un point p1
		Point p1 = new Point(3, 4);	// Est-ce autorisé ? Pourquoi ?         Oui, on utilise le constructeur de la classe point
		p1.translater(10,10);		// Quel est le translater exécuté ?     C'est le translater de la classe point
		System.out.print("p1 = "); p1.afficher (); System.out.println ();
										// Qu'est ce qui est affiché ?          "p1 = (13,14)"

		// Créer et afficher un point nommé pn1
		PointNomme pn1 = new PointNomme (30, 40, "PN1");
										// Est-ce autorisé ? Pourquoi ?         Oui, on utilise le constructeur de la classe point nomme
		pn1.translater (10,10);		// Quel est le translater exécuté ?         C'est le translater de la classe point
		System.out.print ("pn1 = "); pn1.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?          "pn1 = pn1 = (40,50)"

		// Définir une poignée sur un point
		Point q;

		// Attacher un point à q et l'afficher
		q = p1;				// Est-ce autorisé ? Pourquoi ?                     Oui, on attache l'objet p1 à la poignée q
		System.out.println ("> q = p1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?              "q = (13,14)"

		// Attacher un point nommé à q et l'afficher
		q = pn1;			// Est-ce autorisé ? Pourquoi ?                     Oui, car q est une poignée sur un point et une point nommé est un sous type de point donc la poignée q peut être attachée à un point nommé 
		System.out.println ("> q = pn1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?              "q = pn1 = (40,50)   "

		// Définir une poignée sur un point nommé
		PointNomme qn;

		// Attacher un point à q et l'afficher
		qn = p1;			// Est-ce autorisé ? Pourquoi ?                         Non, car qn est une poignée sur un point nomme donc on ne peut pas l'attacher à un point  
		System.out.println ("> qn = p1;");
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?              Erreur

		// Attacher un point nommé à qn et l'afficher
		qn = pn1;			// Est-ce autorisé ? Pourquoi ?                         Oui, car qn est une poignée sur un point nomme et on l'attaché à un point nommé
		System.out.println ("> qn = pn1;");
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?              "qn = pn1 = (40,50)"

		double d1 = p1.distance (pn1);	// Est-ce autorisé ? Pourquoi ?             Oui 
		System.out.println ("distance = " + d1);

		double d2 = pn1.distance (p1);	// Est-ce autorisé ? Pourquoi ?             Oui
		System.out.println ("distance = " + d2);

		double d3 = pn1.distance (pn1);	// Est-ce autorisé ? Pourquoi ?             Oui
		System.out.println ("distance = " + d3);

		System.out.println ("> qn = q;");
		qn = q;				// Est-ce autorisé ? Pourquoi ?                         Non car ce ne sont pas des poignées du même type
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Qu'est ce qui est affiché ?              Erreur

		System.out.println ("> qn = (PointNomme) q;");
		qn = (PointNomme) q;		// Est-ce autorisé ? Pourquoi ?                 
		System.out.print ("qn = "); qn.afficher(); System.out.println ();

		System.out.println ("> qn = (PointNomme) p1;");
		qn = (PointNomme) p1;		// Est-ce autorisé ? Pourquoi ?
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
	}

}
