package territoires;
import java.util.List;

public class Territoire_test {
	private int forces_offensives;
	private int forces_defensives;
	private int numero;
	private Boolean capitale;
	String nom;
	private List <Territoire_test> voisin;
	public Territoire_test(int forces_offensives, int forces_defensives, int numero, Boolean capitale,String nom,List <Territoire_test> voisin ) {
		this.forces_offensives = forces_offensives;
		this.forces_defensives = forces_defensives;
		this.numero = numero;
		this.capitale = capitale;
		this.nom = nom;
		this.voisin = voisin;
		
	}
	
	public List <Territoire_test> getVoisin(){
		return this.voisin;
	}
	
	public String getNom() {
		return this.nom;
	}
	public int getNumero() {
		return this.numero;
	}
	
	public int getForces_defensives() {
		return this.forces_defensives;
	}
	
	public int getForces_offensives() {
		return this.forces_offensives;
	}
	
	public String estCapitale() {
		if(this.capitale) {
			return "oui";
			}
		else {
			return "non";
		}
	}
}
