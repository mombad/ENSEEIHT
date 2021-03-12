package fenetre;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

import factions.Faction;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Observable;
import java.util.Observer;

import territoires.*;
import principal.*;

public class FenetreJeu {

	// test de l'interface avec une initialisation simplifiée du jeu.
	// On suppose que le joueur a choisi la faction vikings
	private String factionJoueur;
	private Faction faction;
	private static JPanel panelCentral = new JPanel();
	private static JPanel panel_carte = new JPanel();

	
	public FenetreJeu(Territoire[][] mat_territoires, int nbLignes, int nbColonnes, String factionjoueur) {
		Les_territoires liste = new Les_territoires();
		factionJoueur = factionjoueur;
		// initialisation des labels
		//to do plus tard : liste de Jlabel?
		JLabel label1 = new JLabel("");
		JLabel label2 = new JLabel("");
		JLabel label3 = new JLabel("");
		JLabel label4 = new JLabel("");
		JLabel label5 = new JLabel("");
		JLabel label6 = new JLabel("");
		JLabel label7 = new JLabel("");

		// initialisation des boutons
		JButton attaquer;
		JButton deplacer;
		JButton recruter;

		// création et parametrage de la fenétre
		JFrame fenetre = new JFrame("RISK.exe");
		Container contenu = fenetre.getContentPane();
		contenu.setLayout(new BorderLayout());
		fenetre.setTitle("Java-Risk");
	//	fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	//	fenetre.setLocationRelativeTo(null);
		fenetre.setPreferredSize(new Dimension(1000, 800));
		fenetre.setBounds(200,200,1000,800);
		fenetre.setResizable(false);

		// texte informatif sur la liste des territoires
		JPanel info_jeu = new JPanel(new BorderLayout());
		JPanel listeTerritoire = new JPanel(new GridLayout(10, 1));
		JLabel Instruction1 = new JLabel("Liste des territoires : ");

		// information sur chaque territoire.
				String texte = "";
				String nomFaction;
				int indice = 1;
				listeTerritoire.add(Instruction1);
				List <JLabel> lesLabels = new ArrayList<JLabel>();
				List <Territoire> liste1 = new ArrayList<Territoire>();
				List <String> lesID = new ArrayList<String>();
				
				for (Territoire[] ligne : mat_territoires) {
					for (Territoire t : ligne) {
						if (t.getFaction() == null) {
							nomFaction = "personne";
							
						} else {
							nomFaction = t.getFaction().getNom();
							if(t.getFaction().getNom().equals(factionJoueur)) {
								this.faction = t.getFaction();
								System.out.println(this.faction.getNom());
							}
						}
						texte = "Territoire " + indice + " occup� par : " + nomFaction + "\n";
						liste1.add(t);
						lesID.add(t.getID());
						indice++;
						JLabel texteTerritoire = new JLabel(texte);
						lesLabels.add(texteTerritoire);
						listeTerritoire.add(texteTerritoire);
					}
				}
		// texte qui informe sur l'or et le temps
		JPanel or_et_temps = new JPanel(new GridLayout(3, 1));
		
		//or
		JLabel labelInfoOr = new JLabel("");
		or_et_temps.add(labelInfoOr);
		
		// temps
		JLabel temps = new JLabel("temps �coul�: 0s");
		or_et_temps.add(temps);
		Chrono compteur = new Chrono(temps);
		compteur.start();
		
		//Bouton am�liorer
		JButton ameliorer = new JButton("Am�liorer");
		or_et_temps.add(ameliorer);
		
		
		info_jeu.add(listeTerritoire, BorderLayout.WEST);
		info_jeu.add(or_et_temps, BorderLayout.EAST);
		contenu.add(info_jeu, BorderLayout.NORTH);

		// Selection d'un Territoire
		JPanel SelectionTerritoire = new JPanel(new GridLayout(3, 1));
		JLabel Instruction2 = new JLabel("Selection d'un Territoire");
		JScrollPane scrollPane = new JScrollPane();
		JList liste_selection = new JList(lesID.toArray());
		scrollPane.setViewportView(liste_selection);
		liste_selection.setLayoutOrientation(JList.VERTICAL);
		SelectionTerritoire.add(Instruction2);
		SelectionTerritoire.add(scrollPane);
		contenu.add(SelectionTerritoire, BorderLayout.WEST);

		// info sur le Territoire selectionn� et liste des actions possibles
		JPanel Info_Action = new JPanel(new BorderLayout());
		JPanel Info = new JPanel(new GridLayout(7, 1));
		Info.add(label1);
		Info.add(label2);
		Info.add(label3);
		Info.add(label4);
		Info.add(label5);
		Info.add(label6);
		Info_Action.add(Info, BorderLayout.WEST);
		JPanel action = new JPanel(new GridLayout(4, 1));

		// mise en place des boutons
		attaquer = new JButton("Attaquer");
		attaquer.setEnabled(false);
		;
		deplacer = new JButton("D�placer");
		deplacer.setEnabled(false);

		recruter = new JButton("Recruter");
		recruter.setEnabled(false);

		
		action.add(label7);
		action.add(recruter);
		action.add(attaquer);
		action.add(deplacer);
		Info_Action.add(action, BorderLayout.EAST);
		contenu.add(Info_Action, BorderLayout.SOUTH);
		JlistListener list = new JlistListener(liste_selection, liste1, contenu, label1, label2, label3, label4, label5,
				label6, labelInfoOr, label7, attaquer, deplacer, recruter, ameliorer,this,lesLabels);
		liste_selection.addListSelectionListener(list);
		attaquer.addActionListener(new ActionAttaquer(list,this.faction,fenetre));
		deplacer.addActionListener(new ActionDeplacer(list, this.faction, fenetre));
		recruter.addActionListener(new ActionRecruter(this.faction,list));
		ameliorer.addActionListener(new ActionAmeliorer(this.faction,fenetre,list));
		ameliorer.setEnabled(false);

		//Construction du panel central
		//panelCentral.setBackground(Color.BLUE);
		dessinerCentral(mat_territoires);
		
		panelCentral.setLayout(null);
		
		panelCentral.add(panel_carte);
		contenu.add(panelCentral, BorderLayout.CENTER);

		
		
		// autres parametrages de la fenetre
		fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetre.pack();
		fenetre.setVisible(true);
		fenetre.toFront();

	}
	public Faction getFenetreFaction() {
		return this.faction;
	}

	public static void dessinerCentral(Territoire[][] mat_territoires) {
		panel_carte.removeAll();
		panel_carte.setBounds(200,0,Main.getTaillePanelCentral(),Main.getTaillePanelCentral());
		
		Carte uneCarte = new Carte(mat_territoires,Main.getNbLignes(),Main.getNbColonnes());
		JLabel[][] uneMatrice = uneCarte.getMatrice_carte();
			 

		panel_carte.setLayout(new GridLayout(Main.getNbLignes(),Main.getNbColonnes()));
		for (int i = 0; i < Main.getNbLignes(); i++) {
			for (int j = 0; j < Main.getNbColonnes(); j++) {
				
				panel_carte.add( uneMatrice[i][j]);
			}
		}
	}
	

}
