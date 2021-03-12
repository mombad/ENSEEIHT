public class Cellule {
	private int x;
	
	private Cellule suivante;
	
	public Cellule(int y) {
		this.x=y;
	}
	
	public int getX() {
		return this.x;
	}
	
	public void setX(int y) {
		this.x=y;
	}
	
	public void setSuivante(Cellule c) {
		this.suivante=c;
	}
	
	public  Cellule getSuivante() {
		return this.suivante;
	}
}
