package fenetre;
import territoires.*;

import java.awt.Container;
import java.awt.Dimension;
import java.awt.GridLayout;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

import principal.*;
import strategie.*;
import troupes.*;
public class TestCarte {

	
	private JFrame fenetre;
	
	public TestCarte() {
		Territoire[][] mat_territoires = Main.genererCarte(Main.getNbLignes(), Main.getNbColonnes(), Main.getNbFactions());
		
		Carte uneCarte = new Carte(mat_territoires,Main.getNbLignes(),Main.getNbColonnes());
		JLabel[][] uneMatrice = uneCarte.getMatrice_carte();
		
		//f.addTerritoire(carte[0][0]);
		this.fenetre = new JFrame("fenetre");
		fenetre.pack();			// redimmensionner la fenêtre
	 
		fenetre.setBounds(200,200,600,400);
		//fenetre.setResizable(false);

		fenetre.setLayout(new GridLayout(Main.getNbLignes(),Main.getNbColonnes()));
		for (int i = 0; i < Main.getNbLignes(); i++) {
			for (int j = 0; j < Main.getNbColonnes(); j++) {
		
						fenetre.add( uneMatrice[i][j]);
			}
		}
	//	contenu.add(affiche.matrice_carte[0][0]);
		fenetre.setPreferredSize(new Dimension(700, 700));

		fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetre.setLocationRelativeTo(null);
		fenetre.setVisible(true);
		
	}
	
	public static void main(String args[]) {
		new TestCarte();
	}
	
}
