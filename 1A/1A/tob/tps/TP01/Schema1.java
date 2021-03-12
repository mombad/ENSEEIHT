/** Programme de test de la classe Segment.
  * @author  Mohamed BEN AHMED DAHO
  * @version 1.0 
  */

public class Schema1 {

        public static void main(String[] args) {
    
            System.out.print("Création du point p1 :");
            Point p1 = new Point(0, 0);

            System.out.print("Création du point p2 :");
		    Point p2 = new Point(3, 4);

            System.out.print("Création du point p3 :");           
            Point p3 = new Point(2, 2);


            System.out.print("Création du segment s12 :");
		    Segment s12 = new Segment(p1, p2); 
            s12.afficher();


            System.out.print("Création du segment s23 :");
            Segment s23 = new Segment(p2, p3);
            s23.afficher();

            System.out.print("Création du point s31 :");
            Segment s31 = new Segment(p3, p1);
            s31.afficher();

            System.out.print("Création du point b :");
            Point b = new Point( (p1.getX() + p2.getX() + p3.getX() )/3 , (p1.getY() + p2.getY() + p3.getY() )/3 );

          
        

        }

}
