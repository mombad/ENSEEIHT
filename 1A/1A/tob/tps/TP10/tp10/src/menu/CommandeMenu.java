package menu;

import editeur.Ligne;

public class CommandeMenu implements Commande {
	
	
	protected Menu menu;
	protected Commande init;
	
	public CommandeMenu(Menu m,Ligne l,Commande i) {		
		this.menu=m;
		this.init=i;
	}
	public void executer() {
		do {
			
			this.init.executer();

			// Afficher le menu
			menu.afficher();

			// Sélectionner une entrée dans le menu
			menu.selectionner();

			// Valider l'entrée sélectionnée
			menu.valider();

		} while (! menu.estQuitte());
	}
	
	public boolean estExecutable() {
		return true;
	}
	

}
