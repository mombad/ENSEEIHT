package fenetre;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import factions.Faction;

import java.awt.*;
import principal.*;
public class ActionAmeliorer implements ActionListener{
	private Faction f;
	private JFrame fenetre;
	private JlistListener liste;
	private Container contenu;
	public final static int prixAmelioration = 500; 
	public ActionAmeliorer(Faction f,JFrame fenetre, JlistListener liste) {
		this.f = f;
		this.fenetre = fenetre;
		this.liste = liste;
	}

	public void fenetre_ameliorer() {
		double nb_or = f.getOr();
		JFrame fenetre = new JFrame("RISK.exe");
		Container contenu = fenetre.getContentPane();
		contenu.setLayout(new BorderLayout());
		fenetre.setTitle("Java-Risk");
		fenetre.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		fenetre.setLocationRelativeTo(null);
		fenetre.setPreferredSize(new Dimension(350, 200));
		
		JPanel panel = new JPanel(new GridLayout(2,1));
		contenu.add(panel,BorderLayout.CENTER);
		JLabel text = new JLabel("D�penser " + prixAmelioration +" or pour am�liorer vos troupes?");
		JPanel boutons = new JPanel(new FlowLayout());
		JButton oui = new JButton("OUI");
		JButton non = new JButton("NON");
		oui.addActionListener(new ActionConfirmerAmelioration(fenetre, f, liste, contenu));
		panel.add(text);
		boutons.add(oui);
		boutons.add(non);
		panel.add(boutons);
		contenu.add(panel);
		non.addActionListener(new ActionRetour(fenetre));
		
		fenetre.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
	  	fenetre.pack();
	  	fenetre.setVisible(true);
	  	fenetre.toFront();
	}
	@Override
	public void actionPerformed(ActionEvent arg0) {
		// TODO Auto-generated method stub
		fenetre_ameliorer();
		
	}

}
