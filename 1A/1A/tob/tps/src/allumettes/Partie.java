package allumettes;

/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Cr√©gut
 * @version	$Revision: 1.5 $
 */
public class Partie implements Jeu  {

	private int nombreAllumettes;
	
		/** Lancer une partie. En argument sont donn√©s les deux joueurs sous
	 * la forme nom@strat√©gie.
	 * @param args la description des deux joueurs
	 */
	public Partie(int nombreInitialAllumettes) {
		this.nombreAllumettes = nombreInitialAllumettes;
	}
	
	public static void main(String[] args) {
		String joueur1;
		String joueur2;
		Joueur j1;
		Joueur j2;
		Arbitre arbitre;

		try {
			verifierNombreArguments(args);
			if (args.length<3) {
				joueur1 = args[0];
				joueur2 = args[1];
				j1 = new Joueur(joueur1.split("@")[0],joueur1.split("@")[1]);
				j2 = new Joueur(joueur2.split("@")[0],joueur2.split("@")[1]);
				arbitre = new Arbitre(j1,j2,false);
			}
			else {
				joueur1 = args[1];
				joueur2 = args[2];
				j1 = new Joueur(joueur1.split("@")[0],joueur1.split("@")[1]);
				j2 = new Joueur(joueur2.split("@")[0],joueur2.split("@")[1]);
				arbitre = new Arbitre(j1,j2,true);
			}			
			
			
			if (arbitre.getConfiant()==false) {	
				Procuration partie = new Procuration(13);
				arbitre.arbitrer(partie);				
			}
			else {				
				Partie partie = new Partie(13);
				arbitre.arbitrer(partie);
			}
		

		
			
			
			
		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
		
	}

	private static void verifierNombreArguments(String[] args) {
		final int nbJoueurs = 2;
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : "
					+ args.length);
		}
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : "
					+ args.length);
		}
	}

	/** Afficher des indications sur la mani√®re d'ex√©cuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Partie joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@strat√©gie"
				+ "\n\t\t" + "strategie = naif | rapide | expert | humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Partie Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}

	@Override
	public int getNombreAllumettes() {		
		return nombreAllumettes;
	}

	@Override
	public void retirer(int nbPrises) throws CoupInvalideException {
		if (nombreAllumettes-nbPrises<0) {
			throw new CoupInvalideException(nbPrises,"Le nombre entrÈ est supÈrieur au nombre d'allumettes restantes");
		}
		if (nbPrises>Jeu.PRISE_MAX) {
			throw new CoupInvalideException(nbPrises,"Le nombre entrÈ dÈpasse le nombre maximal d'allumettes prises autorisÈ en un coup");
		}
		if (nbPrises<=0) {
			throw new CoupInvalideException(nbPrises,"Le nombre entrÈ doit Ítre supÈrieur ‡ 0");
		}
		nombreAllumettes= nombreAllumettes-nbPrises;
	}

	

}
//

