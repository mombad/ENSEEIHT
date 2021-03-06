package fenetre;

import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;

import factions.Faction;
import principal.*;
import troupes.Troupe;

public class ActionConfirmerAmelioration implements ActionListener {
	private Faction f;
	private JlistListener liste;
	private Container contenu;
	JFrame fenetre;

	public ActionConfirmerAmelioration(JFrame fenetre, Faction f, JlistListener liste, Container contenu) {
		this.f = f;
		this.liste = liste;
		this.fenetre = fenetre;
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		int erreur = f.modifierNiveau(1);
		if (erreur == 0) {
			FenetreErreur f = new FenetreErreur("vous n'avez pas assez d'or "
					+ "pour effectuer cette opération");
			f.afficherErreur();
		} else {
		if (liste.getTerritoire() != null) {
			if (liste.getTerritoire().getTroupes() != null) {
				for (Troupe troupe : liste.getTerritoire().getTroupes()) {
					troupe.majstats();
				}
			}
		}
		
		}
		liste.add_label(contenu, liste.getTerritoire());
		fenetre.dispose();
		
		// TODO Auto-generated method stub

	}

}
