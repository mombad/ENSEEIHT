import java.awt.Color;
import java.lang.reflect.*;
import org.junit.*;
import static org.junit.Assert.*;
import java.util.*;

/**
  * L'objectif de cette classe de tester la classe cercle.
  *
  * @author	Mohamed BEN AHMED DAHO
  */

	public class CercleTest {
		
		// précision pour les comparaisons réelle
		public final static double EPSILON = 0.001;
		
		// Les points
		private Point a, b, o, c;

		// Les cercles
		private Cercle c1, c2, c3;
		
		@Before public void setUp() {
			// Création des points
			o = new Point(0, 0);
			a = new Point(1, 1);		
			b = new Point(-8, -7);
			c = new Point(-4, 4);
		}

		@Test public void testerE12() {
			Cercle c1 = new Cercle(o, a);
			Cercle c2 = new Cercle(o, b);
			Cercle c3 = new Cercle(b, c);
			assertEquals("Erreur Création cercle E12 x", c1.getCentre().getX(),
					0.5, EPSILON);
			assertEquals("Erreur Création cercle E12 y", c1.getCentre().getY(),
					0.5, EPSILON);
			assertEquals("Erreur Création cercle E12  rayon", c1.getRayon(),
					c1.getCentre().distance(a), EPSILON);
			
			assertEquals("Erreur Création cercle E12 x", c2.getCentre().getX(),
					-4, EPSILON);
			assertEquals("Erreur Création cercle E12 y", c2.getCentre().getY(),
					-3.5, EPSILON);
			assertEquals("Erreur Création cercle E12  rayon", c2.getRayon(),
					c2.getCentre().distance(b), EPSILON);
			
			assertEquals("Erreur Création cercle E12 x", c3.getCentre().getX(),
					-6, EPSILON);
			assertEquals("Erreur Création cercle E12 y", c3.getCentre().getY(),
					-1.5, EPSILON);
			assertEquals("Erreur Création cercle E12  rayon", c3.getRayon(),
					c3.getCentre().distance(c), EPSILON);
			
			assertEquals("Erreur Création cercle E12 Couleur", c1.getCouleur(),
					Color.blue);
			assertEquals("Erreur Création cercle E12 Couleur", c2.getCouleur(),
					Color.blue);
			assertEquals("Erreur Création cercle E12 Couleur", c3.getCouleur(),
					Color.blue);
			
		}


		@Test public void testerE13() {
			Cercle c1 = new Cercle(o, a, Color.green);
			Cercle c2 = new Cercle(o, b, Color.red);
			Cercle c3 = new Cercle(b, c, Color.yellow);

			assertEquals("Erreur Création cercle E13 x", c1.getCentre().getX(),
					0.5, EPSILON);
			assertEquals("Erreur Création cercle E13 y", c1.getCentre().getY(),
					0.5, EPSILON);
			assertEquals("Erreur Création cercle E13  rayon", c1.getRayon(),
					c1.getCentre().distance(a), EPSILON);
			
			assertEquals("Erreur Création cercle E13 x", c2.getCentre().getX(),
					-4, EPSILON);
			assertEquals("Erreur Création cercle E13 y", c2.getCentre().getY(),
					-3.5, EPSILON);
			assertEquals("Erreur Création cercle E13  rayon", c2.getRayon(),
					c2.getCentre().distance(b), EPSILON);
			
			assertEquals("Erreur Création cercle E13 x", c3.getCentre().getX(),
					-6, EPSILON);
			assertEquals("Erreur Création cercle E13 y", c3.getCentre().getY(),
					-1.5, EPSILON);
			assertEquals("Erreur Création cercle E13  rayon", c3.getRayon(),
					c3.getCentre().distance(c), EPSILON);
			
			assertEquals("Erreur Création cercle E13 x", c1.getCouleur(), Color.green);
			assertEquals("Erreur Création cercle E13 y", c2.getCouleur(), Color.red);
			assertEquals("Erreur Création cercle E13 y", c3.getCouleur(), Color.yellow);

		}

		@Test public void testerE14() {
			c1 = Cercle.creerCercle(o, a);
			c2 = Cercle.creerCercle(o, b);
			c3 = Cercle.creerCercle(b, c);

			assertEquals("Erreur Création cercle E14 x", c1.getCentre().getX(),
					0, EPSILON);
			assertEquals("Erreur Création cercle E14 y", c1.getCentre().getY(),
					0, EPSILON);

			assertEquals("Erreur Création cercle E14 x", c2.getCentre().getX(),
					0, EPSILON);
			assertEquals("Erreur Création cercle E14 y", c2.getCentre().getY(),
					0, EPSILON);

			assertEquals("Erreur Création cercle E14 x", c3.getCentre().getX(),
					-8, EPSILON);
			assertEquals("Erreur Création cercle E14 y", c3.getCentre().getY(),
					-7, EPSILON);

			assertEquals("Erreur Création cercle E14 x", c1.getCouleur(),
					Color.blue);
			assertEquals("Erreur Création cercle E14 y", c2.getCouleur(),
					Color.blue);

			assertEquals("Erreur Création cercle E14  rayon", c1.getRayon(),
					c1.getCentre().distance(a), EPSILON);
			assertEquals("Erreur Création cercle E14  rayon", c2.getRayon(),
					c2.getCentre().distance(b), EPSILON);
		}
	}