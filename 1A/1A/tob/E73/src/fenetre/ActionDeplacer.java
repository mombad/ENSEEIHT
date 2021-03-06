package fenetre;

import java.awt.Container;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JSlider;

import factions.Faction;
import territoires.*;


public class ActionDeplacer implements ActionListener {
	private JlistListener list;
	private Faction f;
	JFrame fenetre;

	public ActionDeplacer(JlistListener list, Faction f, JFrame fenetre) {
		this.list = list;
		this.f = f;
		this.fenetre = fenetre;

	}

	public void fenetre_deplacer() {
		int FPS_MIN = 0;
		int MaxAtk;
		int MaxDef;
		int MaxEq;
		int FPS_INIT = 0;
		JFrame fenetre = new JFrame();
		Container contenu = fenetre.getContentPane();
		contenu.setLayout(new GridLayout(10, 1));
		fenetre.setTitle("Deplacer");
		fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetre.setLocationRelativeTo(null);
		fenetre.setPreferredSize(new Dimension(400, 500));
		
		MaxAtk = list.getTerritoire().getNbTroupesOffensives();
		MaxDef = list.getTerritoire().getNbTroupesDefensives();
		MaxEq = list.getTerritoire().getNbTroupesEquilibrees();

		contenu.add(new JLabel("Ou voulez vous envoyer vos troubes ?"));

		List<String> les_territoires = new ArrayList<String>();
		List<Territoire> listeT = new ArrayList<Territoire>();
		for (Territoire t : list.getTerritoire().getListeVoisins()) {
			if(this.f.getTerritoires().contains(t)) {
				listeT.add(t);
				les_territoires.add(t.getID());
			}
		}
		JList liste_selection = new JList(les_territoires.toArray());
		contenu.add(liste_selection);

		contenu.add(new JLabel("Combien de troupes souhaitez vous envoyer?"));
		JSlider slider = new JSlider(JSlider.HORIZONTAL, FPS_MIN, MaxAtk, FPS_INIT);
		// slider.addChangeListener(null);

		// Turn on labels at major tick marks.
		slider.setMajorTickSpacing(1);
		slider.setMinorTickSpacing(1);
		slider.setPaintTicks(true);
		slider.setPaintLabels(true);
		JLabel label = new JLabel("troupes offensives : ");
		contenu.add(label);
		slider.addChangeListener(new JsliderListener(label, slider, "troupes offensives :"));
		contenu.add(slider);

		JSlider slider1 = new JSlider(JSlider.HORIZONTAL, FPS_MIN, MaxDef, FPS_INIT);
		// Turn on labels at major tick marks.
		slider1.setMajorTickSpacing(1);
		slider1.setMinorTickSpacing(1);
		slider1.setPaintTicks(true);
		slider1.setPaintLabels(true);
		JLabel label1 = new JLabel("troupes defensives : ");
		contenu.add(label1);
		contenu.add(slider1);
		slider1.addChangeListener(new JsliderListener(label1, slider1, "troupes d??fensives :"));

		JLabel label2 = new JLabel("troupes ??quilibr??es : ");

		JSlider slider21 = new JSlider(JSlider.HORIZONTAL, FPS_MIN, MaxEq, FPS_INIT);
		// Turn on labels at major tick marks.
		slider21.setMajorTickSpacing(1);
		slider21.setMinorTickSpacing(1);
		slider21.setPaintTicks(true);
		slider21.setPaintLabels(true);
		contenu.add(label2);
		slider21.addChangeListener(new JsliderListener(label2, slider21, "troupes ??quilibr??es :"));
		contenu.add(slider21);

		JPanel boutons = new JPanel(new FlowLayout());
		JButton valider = new JButton("Valider");
		JButton abandonner = new JButton("Abandonner");
		boutons.add(valider);
		valider.setEnabled(false);
		boutons.add(abandonner);
		contenu.add(boutons);
		abandonner.addActionListener(new ActionRetour(fenetre));
		
		JlistListenerVoisin listeCible = new JlistListenerVoisin(liste_selection,valider,listeT);
		liste_selection.addListSelectionListener(listeCible);
		valider.addActionListener(new ActionConfirmerDeplacement(this.f, list, listeCible, 
				contenu, fenetre, slider, slider1, slider21));

		fenetre.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		fenetre.pack();
		fenetre.setVisible(true);
		fenetre.toFront();
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		fenetre_deplacer();
		// TODO Auto-generated method stub

	}

}
