package fenetre;

import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
import javax.swing.JSlider;

import factions.Faction;
import principal.Main;

public class ActionConfirmerAttaque implements ActionListener{
	private Faction f;
	private JlistListener listeAtt;
	private JlistListenerVoisin listeDef;
	private Container contenu;
	private JFrame fenetre;
	private JSlider off,def,eq;
	
	public ActionConfirmerAttaque(Faction f, JlistListener listeAtt, 
			JlistListenerVoisin listeDef,  Container contenu, JFrame fenetre,
			JSlider off, JSlider def, JSlider eq) {
		this.f = f;
		this.listeAtt = listeAtt;
		this.contenu = contenu;
		this.fenetre = fenetre;
		this.listeDef = listeDef;
		this.fenetre = fenetre;
		this.off = off;
		this.def = def;
		this.eq = eq;
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		// TODO Auto-generated method stub
		listeAtt.getTerritoire().attaquer(listeDef.getTerritoire(),
				off.getValue(),def.getValue(),eq.getValue());
		listeAtt.add_label(contenu, listeAtt.getTerritoire());
		Main.faireJouerIA();
		fenetre.dispose();
	
		
	}

}
