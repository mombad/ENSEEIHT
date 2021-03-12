package fenetre;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.GridLayout;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class FenetreErreur {
	private String message;
	public FenetreErreur(String message){
		this.message = message;
	}
	public void afficherErreur() {
		JFrame fenetre = new JFrame("RISK.exe");
		Container contenu = fenetre.getContentPane();
		contenu.setLayout(new BorderLayout());
		fenetre.setTitle("Erreur");
		fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetre.setLocationRelativeTo(null);
		fenetre.setPreferredSize(new Dimension(350, 200));
		
		JPanel panel = new JPanel(new GridLayout(2,1));
		contenu.add(panel,BorderLayout.CENTER);
		JLabel text = new JLabel(this.message);
		JPanel boutons = new JPanel(new FlowLayout());
		JButton ok = new JButton("OK");
		ok.addActionListener(new ActionRetour(fenetre));
		panel.add(text);
		boutons.add(ok);
		panel.add(boutons);
		contenu.add(panel);
		
		fenetre.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
	  	fenetre.pack();
	  	fenetre.setVisible(true);
	  	fenetre.toFront();
	}
	
	

}
