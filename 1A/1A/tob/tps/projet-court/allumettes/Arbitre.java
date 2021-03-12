package allumettes;

public class Arbitre {
	private Joueur joueur1;
	private Joueur joueur2;
	private boolean confiant;

	public Arbitre(Joueur j1, Joueur j2) {
		this.joueur1 = j1;
		this.joueur2 = j2;
	}

	public void setConfiant(boolean confiant) {
		this.confiant = confiant;
	}

	public void faireJouer(Jeu jeu, Jeu procuration, Joueur j)
			throws OperationInterditeException  {
		int prise = 0;
		boolean fini = true;
		while (fini) {
			try {
				System.out.println("");
				System.out.println("Nombre d'allumettes restantes : "
				+ jeu.getNombreAllumettes());
				System.out.println("Au tour de " + j.getNom() + ".");
				prise = j.getPrise(procuration);
				System.out.print(j.getNom() + " prend " + prise);
				if (prise > 1) {
					System.out.println(" allumettes.");
					} else {
					System.out.println(" allumette.");
					}
				jeu.retirer(prise);
				fini = false;
				} catch (CoupInvalideException e) {
				System.out.print("Erreur ! ");
				System.out.println(e.getMessage());
				System.out.println("Recommencez !");
				}
			}
		}

	public void arbitrer(Jeu jeu) {
		Jeu procuration;
		if (this.confiant) {
			procuration = jeu;
		} else {
			procuration = new Procuration(jeu);
		}
		boolean partieFinie = false;
		int j;
		while (!partieFinie) {
			j = 1;
			partieFinie = testFinJeu(jeu, partieFinie, j);
			partieFinie = gestionTriche(jeu, procuration,
					this.joueur1, partieFinie);
			j = 2;
			partieFinie = testFinJeu(jeu, partieFinie, j);
			partieFinie = gestionTriche(jeu, procuration,
					this.joueur2, partieFinie);
			}
		}

	public boolean getConfiant() {
		return this.confiant;
	}


	public boolean gestionTriche(Jeu jeu, Jeu procuration,
			Joueur joueur, boolean partieFinie) {
		if (!partieFinie) {
			try {
				faireJouer(jeu, procuration, joueur);
				return false;
				} catch (OperationInterditeException e) {
					System.out.print(e.getMessage());
					System.out.println(joueur + " a triché !");
					return true;
					}
			} else {
				return true;
				}
		}


	public boolean testFinJeu(Jeu jeu, boolean partieFinie, int j) {
		if (!partieFinie) {
			if (jeu.getNombreAllumettes() == 0) {
				if (j == 1) {
					afficherFinJeu(this.joueur2,
							this.joueur1);
					} else {
						afficherFinJeu(this.joueur1,
								this.joueur2);
					}
				return true;
				} else {
					return false;
				}
			} else {
				return true;
			}
		}
	public void afficherFinJeu(Joueur j1, Joueur j2) {
		System.out.println(j1.getNom()
				+ " a perdu !");
		System.out.println(j2.getNom()
				+ " a gagné !");
		}
	}
