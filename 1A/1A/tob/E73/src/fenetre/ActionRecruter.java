package fenetre;

import java.awt.event.ActionListener;
import java.util.Observable;
import java.util.Observer;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JSlider;

import factions.Faction;
import territoires.*;
import troupes.Offensive;
import troupes.*;
import principal.*;

public class ActionRecruter implements ActionListener {
	private Faction f;
	private JlistListener liste;
	
	public ActionRecruter(Faction f, JlistListener liste) {
		this.f= f;
		this.liste = liste;
	}
	public void fenetre_recruter() {
		int prixOff = (int)Math.floor(Offensive.PRIX);
		double prixDef = Defensive.PRIX;
		double prixEq =  Equilibre.PRIX;
		System.out.println(prixOff);
		int FPS_MIN = 0;
		int FPS_MAX = (int)Math.floor(f.getOr());
		FPS_MAX = (int)Math.floorDiv(FPS_MAX, prixOff);
		int FPS_INIT = 0;
		
		JLabel label = new JLabel("troupes offensives");
		JFrame fenetre = new JFrame();
		Container contenu = fenetre.getContentPane();
		contenu.setLayout(new GridLayout(10, 1));
		fenetre.setTitle("Recruter");
		fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetre.setLocationRelativeTo(null);
		fenetre.setPreferredSize(new Dimension(400, 500));

		contenu.add(new JLabel("Combien de troupes souhaitez vous recruter?"));
		JSlider slider = new JSlider(JSlider.HORIZONTAL, FPS_MIN, FPS_MAX, FPS_INIT);
		// slider.addChangeListener(null);

		// Turn on labels at major tick marks.
		slider.setMajorTickSpacing(25);
		slider.setMinorTickSpacing(1);
		slider.setPaintTicks(true);
		slider.setPaintLabels(true);
		contenu.add(label);
		slider.addChangeListener(new JsliderListener(label, slider, "troupes offensives :"));
		contenu.add(slider);

		JSlider slider1 = new JSlider(JSlider.HORIZONTAL, FPS_MIN, FPS_MAX, FPS_INIT);
		// Turn on labels at major tick marks.
		slider1.setMajorTickSpacing(25);
		slider1.setMinorTickSpacing(1);
		slider1.setPaintTicks(true);
		slider1.setPaintLabels(true);
		JLabel label1 = new JLabel("troupes d???fensives : ");
		contenu.add(label1);
		contenu.add(slider1);
		slider1.addChangeListener(new JsliderListener(label1, slider1, "troupes d???fensives :"));

		JLabel label2 = new JLabel("troupes ???quilibr???es : ");

		JSlider slider21 = new JSlider(JSlider.HORIZONTAL, FPS_MIN, FPS_MAX, FPS_INIT);
		// Turn on labels at major tick marks.
		slider21.setMajorTickSpacing(25);
		slider21.setMinorTickSpacing(1);
		slider21.setPaintTicks(true);
		slider21.setPaintLabels(true);
		contenu.add(label2);
		slider21.addChangeListener(new JsliderListener(label2, slider21, "troupes ???quilibr???es :"));
		contenu.add(slider21);

		JPanel boutons = new JPanel(new FlowLayout());
		JButton valider = new JButton("Valider");
		JButton abandonner = new JButton("Abandonner");
		boutons.add(valider);
		boutons.add(abandonner);
		contenu.add(boutons);
		abandonner.addActionListener(new ActionRetour(fenetre));
		valider.addActionListener(new ActionConfirmer(contenu, this.liste, fenetre, f, slider, slider1, slider21));

		fenetre.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		fenetre.pack();
		fenetre.setVisible(true);
		fenetre.toFront();
	}

	@Override
	public void actionPerformed(ActionEvent e) {
		fenetre_recruter();

		// TODO Auto-generated method stub

	}

}
