import java.awt.Color;

/**
* Cercle modélise un cercle géométrique dans un plan équipé d'un repère cartésien.
* Un Cercle peut être affiché, translaté,
* modifié (rayon, couleur, diamètre).
* On peut construire de différentes manières.
*
* @author Mohamed BEN AHMED DAHO <mohamed.benahmeddaho@etu.enseeiht.fr>
*/
public class Cercle implements Mesurable2D {
	/**
	 * Centre du cercle.
	 */
    private Point centre;
    /**
     * Rayon du cercle.
     */
    private double rayon;
    /**
     *Couleur du cercle.
     */
    private Color couleur;
    /**
     * Constante égale à pi.
     */
    public static final double PI = Math.PI;

// Construire un cercle

    /** Construire un cercle à partir de son centre et de son rayon.
     * @param vc centre du cercle <br>
     * =====> Pre : vc != null
     * @param vr rayon <br>
     * =====> Pre : vr >0
     */
    public Cercle(Point vc, double vr) {
    	assert (vc != null && vr > 0);
        this.centre = new Point(vc.getX(), vc.getY());
        this.rayon = vr;
        this.couleur = Color.blue;
    }


    /** Construire un cercle à partir de deux points diamétralement opposés.
     * @param pointA premier point <br>
     * =====> Pre : pointA!=null
     * @param pointB deuxième point <br>
     * =====> Pre : pointB!=null et pointB!=pointA
     */
    public Cercle(Point pointA, Point pointB) {
    	assert (pointA != null && pointB != null && (pointA.getX() != pointB.getX()
    			|| pointA.getY() != pointB.getY()));
        this.centre = new Point((pointA.getX() + pointB.getX()) / 2,
        		(pointA.getY() + pointB.getY()) / 2);
        this.rayon = pointA.distance(pointB) / 2;
        this.couleur = Color.blue;
    }


    /** Construire un cercle à partir de deux points diamétralement opposés
     * et de sa couleur.
     * @param pointA premier point <br>
     * =====> Pre : pointA!= null
     * @param pointB deuxième point <br>
     * =====>Pre : pointB!= null et pointB!=pointA
     * @param ncouleur couleur du cercle <br>
     * =====>Pre : ncouleur != null
     */
    public Cercle(Point pointA, Point pointB, Color ncouleur) {
    	assert (pointA != null && pointB != null && (pointA.getX() != pointB.getX()
    			|| pointA.getY() != pointB.getY()) && ncouleur != null);
        this.centre = new Point((pointA.getX() + pointB.getX()) / 2,
        		(pointA.getY() + pointB.getY()) / 2);
        this.rayon = pointA.distance(pointB) / 2;
        this.couleur = ncouleur;
    }

    /** Créer un cercle à partir du centre et d'un point du cercle.
     * @param centre centre du cercle <br>
     * =====> Pre : centre!=null
     * @param pointA point du cercle <br>
     * =====> Pre : pointA!=null et pointA!=centre
     * @return cercle
     */
    public static Cercle creerCercle(Point centre, Point pointA) {
    	assert (centre != null && pointA != null && (centre.getX() != pointA.getX()
    			|| centre.getY() != pointA.getY()));
    	Cercle cercle = new Cercle(centre, centre.distance(pointA));
    	return cercle;
    }


// Modifier le cercle
    /** Modifier le rayon du cercle.
     * @param nrayon nouveau rayon <br>
     * =====> Pre : nrayon>0
     */
    public void setRayon(double nrayon) {
    	assert (nrayon > 0);
    	this.rayon = nrayon;
    }

    /** Modifier le diamètre du cercle.
     * @param ndiametre nouveau diamètre <br>
     * =====> Pre : ndiametre>0
     */
    public void setDiametre(double ndiametre) {
    	assert (ndiametre > 0);
    	this.rayon = ndiametre / 2;
    }
// Obtenir des informations sur le cercle

    /** Obtenir le centre d'un cercle.
	 * @return centre du cercle
	 */
    public Point getCentre() {
    	Point pointCentre = new Point(this.centre.getX(), this.centre.getY());
        return pointCentre;
    }

    /** Obtenir le rayon d'un cercle.
	 * @return rayon du cercle
	 */
    public double getRayon() {
        return this.rayon;
    }

    /** Obtenir le diamètre du cercle.
	 * @return diamètre du cercle
	 */
    public double getDiametre() {
        return 2 * this.rayon;
    }
    /** Obtenir le périmètre du cercle.
	 * @return périmètre du cercle
	 */
    public double perimetre() {
    	return 2 * PI * this.rayon;
    }
    /** Obtenir l'aire du cercle.
	 * @return aire du cercle
	 */
    public double aire() {
    	return PI * Math.pow(this.rayon, 2);
    }
// Autres méthodes
    /** Translater un cercle suivant l'axe X ou l'axe Y.
	 * @param dx translation suivant l'axe X
     * @param dy translation suivant l'axe Y
	 */
    public void translater(double dx, double dy) {
        this.centre.translater(dx, dy);
    }
    /** Tester si un point appartient à un cercle.
	 * @param pointT point à tester <br>
	 * =====> Pre : pointT!=null
	 * @return Boolean
	 */
    public boolean contient(Point pointT) {
    	assert (pointT != null);
        return (this.centre.distance(pointT) <= this.rayon);
    }
	/** Afficher le cercle. */
	public void afficher() {
		System.out.print(this);
	}

	/** Méthode toString.
	 * @return cercle en String
	 */
	public String toString() {
		return "C" + this.rayon + "@" + this.getCentre();
	}

// Gestion de la couleur
  /** Obtenir la couleur d'un cercle.
	 * @return couleur du cercle
	 */
    public Color getCouleur() {
    	Color laCouleur = new Color(this.couleur.getRGB());
        return laCouleur;
    }

	/** Changer la couleur du point.
	  * @param nouvelleCouleur nouvelle couleur <br>
	  * =====> Pre : nouvelleCouleur!=null
	  */
	public void setCouleur(Color nouvelleCouleur) {
		assert (nouvelleCouleur != null);
		this.couleur = nouvelleCouleur;
	}
}
