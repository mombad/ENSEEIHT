/**
 * Définition d'un agenda individuel.
 */
public class AgendaIndividuel extends AgendaAbstrait {

	private String[] rendezVous;	// le texte des rendezVous


	/**
	 * Créer un agenda vide (avec aucun rendez-vous).
	 *
	 * @param nom le nom de l'agenda
	 * @throws IllegalArgumentException si nom nul ou vide
	 */
	public AgendaIndividuel(String nom) {
		super(nom);
		this.rendezVous = new String[Agenda.CRENEAU_MAX + 1];
			// On gaspille une case (la première qui ne sera jamais utilisée)
			// mais on évite de nombreux « creneau - 1 »
	}


	@Override
	public void enregistrer(int creneau, String rdv) throws OccupeException {
		this.verifierCreneauValide(creneau);
		if ((rdv==null)||(rdv.length()==0)) {
			throw new IllegalArgumentException("RDV invalide");
		}
		try{
			String str = this.getRendezVous(creneau);
			throw new OccupeException("Le créneau est occupé");
		}
		catch(LibreException e) {
			this.rendezVous[creneau] = rdv;
		}
	}


	@Override
	public boolean annuler(int creneau) {
		this.verifierCreneauValide(creneau);
		boolean modifie = this.rendezVous[creneau] != null;
		this.rendezVous[creneau] = null;
		return modifie;
	}


	@Override
	public String getRendezVous(int creneau) throws LibreException {
		this.verifierCreneauValide(creneau);
		if (this.rendezVous[creneau]==null) {
			throw new LibreException("Le RDV est valide");
		}
		return this.rendezVous[creneau];
	}


}
