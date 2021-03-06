package fenetre;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import principal.*;

public class MenuPrincipal extends JFrame {
	
	String[] factions = {"Egyptiens","Indiens", "Mongols","Romains","Samurais","Spartiates","Vikings"};
	String[] nombreIA = {"1","2","3","4","5","6"};
	String[] carte = {"3x3","4x4","5x5"};
	
	//JListForm selection;
	
	private JPanel container = new JPanel(), form = new JPanel();
	
	private JLabel titre = new JLabel();
	
	//choix factions
	private JLabel labelfactions = new JLabel("Choix de la faction");
	private JComboBox combofactions = new JComboBox(factions);
	
	//choix IA
	private JLabel labelIA = new JLabel("Nombre d'IA");
	private JComboBox comboIA = new JComboBox(nombreIA);
	
	//choix carte
	private JLabel labelcarte = new JLabel("Taille de la carte");
	private JComboBox combocarte = new JComboBox(carte);
	
	//bouton jouer
	private JButton jouer = new JButton("Jouer");
	
	public MenuPrincipal() {
		
		//parametrage de la fenetre
		this.setTitle("Menu principal");
		this.setSize(300,300);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setLocationRelativeTo(null);
		
		//redimension de l'image (titre)
		ImageIcon imageicone = new ImageIcon(Main.CHEMIN + "titre.png");
		Image image = imageicone.getImage();
		Image newimage = image.getScaledInstance(300, 100, Image.SCALE_DEFAULT);
		imageicone = new ImageIcon(newimage);
		titre.setIcon(imageicone);
		
		//fenetre
		container.setBackground(Color.white);
		container.setLayout(new BorderLayout());
		
		//formulaire
		form.setBackground(Color.white);
		GridLayout g = new GridLayout(3,2);
		g.setVgap(5);
		form.setLayout(g);
	
		combofactions.setPreferredSize(new Dimension(100,20));
		comboIA.setPreferredSize(new Dimension(100,20));
		combocarte.setPreferredSize(new Dimension(100,20));
		
		form.add(labelfactions);
		form.add(combofactions);
		form.add(labelIA);
		form.add(comboIA);
		form.add(labelcarte);
		form.add(combocarte);
		
		//agencement des composants dans la fenetre
		container.add(titre, BorderLayout.NORTH);
		container.add(form, BorderLayout.CENTER);
		container.add(jouer, BorderLayout.SOUTH);
		jouer.addActionListener(new ActionDemarrer());
		
		this.setContentPane(container);
		this.setVisible(true);
		
	}
	class ActionDemarrer implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			Main.jeu(combocarte.getSelectedIndex()+3, comboIA.getSelectedIndex()+2, combofactions.getSelectedItem().toString());
		}
	}
}
