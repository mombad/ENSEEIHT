package troupes;

public abstract class Troupe {

	protected double atk;
	protected double def;
	public static double PRIX;

	/* Renvoie la statistique d'attaque de la troupe. */
	public double getATK() {
		return atk;
	}

	/* Renvoie la statistique de défense de la troupe. */
	public double getDEF() {
		return def;
	}
	

	/* Améliore les statistiques de la troupe. */
	public void majstats() {
		atk = atk * 1.15 ;
		def = def * 1.15 ;
	}
	
	/* Améliore les statistiques de la troupe avec possibilité de choisir le pourcentage d'amélioration. */
	public void majstats(int prctATK, int prctDEF) {
		atk = atk * (1+0.01*prctATK);
		def = def * (1+0.01*prctDEF);
	}

}
