
public class EnsembleChaine implements Ensemble{
	private Cellule c;
	
	public EnsembleChaine(int x) {
		this.c=new Cellule(x);
	}
	public boolean estVide() {
		return this==null;
	}
	
	public int cardinal() {
		int cpt=0;
		if (this.c==null) {
			return cpt;
			
		}
		else {
			Cellule cell = this.c;
			while (cell.getSuivante()!=null) {
				cell=cell.getSuivante();
				cpt++;
			}
			
		}
		return cpt;
	}
		
	
		
	
	
	public boolean contient(int a) {
		if (this.c==null) {
			return false;			
		}
		
		Cellule c1=this.c;
		while ((c1.getX() != a)&&( c1!=null )  ) {
			c1=c1.getSuivante();
		}
		
		if (c1==null) {
			return false;
			}
		else {
				return true;
			}
	}	
	 
	
	public void ajouter(int a){
		if (contient(a)) {
			}
		else {
			Cellule c1=this.c;
			while (c1.getSuivante()!=null) {
				c1=c1.getSuivante();
				}
			}
		Cellule c1 = new Cellule(a);
		c1=c1.getSuivante();
		}
	
	
	
	public void supprimer(int a) {
		Cellule c1=this.c;
		if (this.c.getX() ==a) {
			this.c=this.c.getSuivante();
		}
		while ((c.getSuivante()!=null)&&(c1.getSuivante().getX()!=a))  {
			c1.setSuivante(c1.getSuivante());
		}
		if (c1.getSuivante()==null){
			c1.setSuivante(null);
		}
		else {
			c1.setSuivante(c1.getSuivante().getSuivante());
		}
		
		
	
	}
}