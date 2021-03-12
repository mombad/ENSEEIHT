package allumettes;

/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Crégut
 * @version	$Revision: 1.5 $
 */
public class Partie {


		/** Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	static final int NB_ALLUMETTES = 13;

	public static void main(String[] args) {
		String infoJoueur1;
		String infoJoueur2;
		Joueur j1;
		Joueur j2;
		Arbitre arbitre;
		boolean confiant;

		try {
			verifierNombreArguments(args);
			if (args.length > 2) {
				infoJoueur1 = args[1];
				infoJoueur2 = args[2];
				confiant = true;
			} else {
				infoJoueur1 = args[0];
				infoJoueur2 = args[1];
				confiant = false;
			}

			j1 = initialiserJoueur(infoJoueur1);
			j2 = initialiserJoueur(infoJoueur2);
			arbitre = new Arbitre(j1, j2);
			arbitre.setConfiant(confiant);

			JeuReel jeu = new JeuReel(NB_ALLUMETTES);
			arbitre.arbitrer(jeu);

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

	/** Afficher des indications sur la mani�re d'ex�cuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Partie joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert | humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Partie Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}

	public static Joueur initialiserJoueur(String infoJoueur) {
		Joueur j;
		String[] tab = infoJoueur.split("@");
		switch (tab[1]) {
		case "naif":
			j = new Joueur(tab[0], new StrategieNaif());
			break;
		case "expert":
			j = new Joueur(tab[0], new StrategieExpert());
			break;
		case "humain":
			j = new Joueur(tab[0], new StrategieHumain());
			break;
		case "tricheur":
			j = new Joueur(tab[0], new StrategieTricheur());
			break;
		case "rapide":
			j = new Joueur(tab[0], new StrategieRapide());
			break;
		default:
			j = new Joueur(tab[0], new StrategieNaif());
		}
		return j;
	}
}