package fenetre;

import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Observable;
import java.util.Observer;

import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.JSlider;

import factions.Faction;
import principal.Main;
import territoires.*;

public class ActionConfirmer implements ActionListener {
	private JSlider off, def, eq;
	private Faction f;
	private JFrame fenetre;
	private JlistListener liste;
	Capitale capitale;
	private Container contenu;

	public ActionConfirmer(Container contenu, JlistListener liste, JFrame fenetre, Faction f, JSlider off, JSlider def,
			JSlider eq) {
		this.off = off;
		this.def = def;
		this.eq = eq;
		this.f = f;
		this.fenetre = fenetre;
		this.liste = liste;
		this.contenu = contenu;
	}

	@Override
	public void actionPerformed(ActionEvent arg0) {
		recruter();

	}

	public void recruter() {
		System.out.println("value: " + off.getValue());
		this.capitale = (Capitale) liste.getTerritoire();
		int erreur = capitale.recruter(off.getValue(), def.getValue(), eq.getValue());
		if (erreur == 0) {
			FenetreErreur f = new FenetreErreur("Vous n'avez pas assez d'or " + "pour recruter ces troupes !");
			f.afficherErreur();
		} else {
			//Main.faireJouerIA();
			liste.add_label(contenu, capitale);
			
			fenetre.dispose();
		}
	}

}
