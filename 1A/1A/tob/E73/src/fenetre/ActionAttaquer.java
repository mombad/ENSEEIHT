package fenetre;

import java.awt.Container;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JSlider;

import factions.Faction;
import principal.Main;
import territoires.*;

import java.util.List;

public class ActionAttaquer implements ActionListener {
	
	private JlistListener list;
	JFrame fenetre;
	Faction f;
	


	public ActionAttaquer(JlistListener list,Faction f,JFrame fenetre) {
		this.list = list;
		this.fenetre = fenetre;
		this.f = f;
	}
	
	
	public void fenetre_attaquer(){
		//valeur min
		int FPS_MIN = 0;
		
		//valeurs max
		int MaxAtk;
		int MaxDef;
		int MaxEq;
		
		//valeur initiale
		int FPS_INIT = 0;
		
		//parametrage de la nouvelle fenetre
		JFrame fenetre = new JFrame();
		Container contenu = fenetre.getContentPane();
		contenu.setLayout(new GridLayout(10,1));
		fenetre.setTitle("Attaquer");
		fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetre.setLocationRelativeTo(null);
		fenetre.setPreferredSize(new Dimension(400, 500));
		
		//selection territoire cibl� (voisin uniquement)
		contenu.add(new JLabel("Quelle Territoire souhaitez vous attaquer ?"));
		List <String> les_territoires = new ArrayList<String>();  
		List <Territoire> listeT = new ArrayList<Territoire>();
		for (Territoire t : list.getTerritoire().getListeVoisins()) {
			if(!this.f.getTerritoires().contains(t)) {
				listeT.add(t);
				les_territoires.add(t.getID());
			}
		}
		JList  liste_selection = new JList(les_territoires.toArray()); 
		contenu.add(liste_selection);
		
		//initialisation du nombres de troupes maximales a envoyer par classe
		MaxAtk = list.getTerritoire().getNbTroupesOffensives();
		MaxDef = list.getTerritoire().getNbTroupesDefensives();
		MaxEq = list.getTerritoire().getNbTroupesEquilibrees();
		
		contenu.add(new JLabel("Combien de troupes souhaitez vous envoyer?"));
		JSlider slider = new JSlider(JSlider.HORIZONTAL,
                FPS_MIN, MaxAtk, FPS_INIT);
		
		//*************************premier slide*******************
		//Param�trage du slider 1
		slider.setMajorTickSpacing(1);
		slider.setMinorTickSpacing(1);
		slider.setPaintTicks(true);
		slider.setPaintLabels(true);
		
		//information sur le nombre de troupes offensives choisies
		JLabel label = new JLabel("troupes offensives :");
		contenu.add(label);
		contenu.add(slider);
		slider.addChangeListener(new JsliderListener(label,slider,"troupes offensives :"));
		
		//*************************second slide**************************
		//information sur le nombre de troupes defensives choisies
		JLabel label1 = new JLabel("troupes d�fensives :");
		JSlider slider1 = new JSlider(JSlider.HORIZONTAL,
                FPS_MIN, MaxDef, FPS_INIT);
		

		//Param�trage du second slide 
		slider1.setMajorTickSpacing(1);
		slider1.setMinorTickSpacing(1);
		slider1.setPaintTicks(true);
		slider1.setPaintLabels(true);
		contenu.add(label1);
		contenu.add(slider1);
		slider1.addChangeListener(new JsliderListener(label1,slider1,
				"troupes d�fensives :"));
		
		//*********************3 eme slide *********************
		JLabel label2 = new JLabel("troupes �quilibr�es :");
		JSlider slider2 = new JSlider(JSlider.HORIZONTAL,
                FPS_MIN, MaxEq, FPS_INIT);
		

		//Parametrage de 3 eme slide
		slider2.setMajorTickSpacing(1);
		slider2.setMinorTickSpacing(1);
		slider2.setPaintTicks(true);
		slider2.setPaintLabels(true);
		contenu.add(label2);
		slider2.addChangeListener(new JsliderListener(label2,slider2,"troupes �quilibr�es :"));
		contenu.add(slider2);
		
		//ajout des boutons et des (Action/ListSelection)Listener
		JPanel boutons = new JPanel(new FlowLayout());
		JButton valider = new JButton("Valider");
		JButton abandonner = new JButton("Abandonner");
		boutons.add(valider);
		valider.setEnabled(false);
		boutons.add(abandonner);
		abandonner.addActionListener(new ActionRetour(fenetre));
		contenu.add(boutons);
		JlistListenerVoisin list1 = new JlistListenerVoisin(liste_selection,valider, listeT);
		liste_selection.addListSelectionListener(list1);
		valider.addActionListener(new ActionConfirmerAttaque(f, list, list1, 
				contenu, fenetre,
				slider, slider1, slider2));
		
		//autre parametrage de la fenetre.
		fenetre.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
	  	fenetre.pack();
	  	fenetre.setVisible(true);
	  	fenetre.toFront();
	}
	
	
	@Override
	public void actionPerformed(ActionEvent arg0) {
		fenetre_attaquer();
		System.out.println("attaquer");
		// TODO Auto-generated method stub
		
	}

}
