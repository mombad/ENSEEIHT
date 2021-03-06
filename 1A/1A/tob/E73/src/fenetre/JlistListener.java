package fenetre;

import java.awt.Container;
import java.util.ArrayList;
import java.util.List;
import java.util.Observable;
import java.util.Observer;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;

import factions.Faction;
import territoires.*;

public class JlistListener implements ListSelectionListener{
	private JList liste;
	private int index;
	private List <Territoire> territoires;
	private Territoire t;
	private Container contenu;
	FenetreJeu fenetre;
	JLabel label1 = new JLabel("");
	JLabel label2= new JLabel("");
	JLabel label3= new JLabel("");
	JLabel label4= new JLabel("");
	JLabel label5= new JLabel("");
	JLabel label6= new JLabel("");
	JLabel labelInfoOr= new JLabel("");
	JLabel label7 = new JLabel("");
	JButton attaquer;
	JButton recruter;
	JButton deplacer;
	JButton ameliorer;
	List <JLabel> lesLabel;
	public JlistListener(JList liste,List <Territoire> territoires,Container contenu,JLabel label1,
			JLabel label2,JLabel label3,JLabel label4,JLabel label5,
			JLabel label6,JLabel labelInfoOr, JLabel label7, JButton attaquer, 
			JButton deplacer, JButton recruter, JButton ameliorer, FenetreJeu fenetre,
			List <JLabel> lesLabel) {
		this.liste = liste;
		this.territoires = territoires;
		this.contenu = contenu;
		this.label1 = label1;
		this.label2 = label2;
		this.label3 = label3;
		this.label4 = label4;
		this.label5 = label5;
		this.label6 = label6;
		this.labelInfoOr = labelInfoOr;
		this.label7 = label7;
		this.attaquer = attaquer;
		this.deplacer = deplacer;
		this.recruter = recruter;
		this.ameliorer = ameliorer;
		this.fenetre = fenetre;
		this.lesLabel = lesLabel;
		
	}
	
	public int getIndex() {
		return this.index;
	}
	
	public Territoire getTerritoire() {
		return this.t;
	}
	
	public void add_label(Container contenu, Territoire t1) {
		String s = " ";
		recruter.setEnabled(false);
		label2.setText(".forces offensives : " + t1.getAttaqueTotale());
		label3.setText(".forces defensives : " + t1.getDefenseTotale());
		label4.setText(".capitale : " + estCapitale(t1));
		label5.setText(".Voisins : ");
		
		for(int i = 0; i < lesLabel.size(); i++ ) {
			if(this.territoires.get(i).getFaction() != null) {
			lesLabel.get(i).setText("Territoire " + i + " occup??? par : " + 
		this.territoires.get(i).getFaction().getNom() );
			}
		    else {
		    	int j = i + 1;
				lesLabel.get(i).setText("Territoire " + j + " occup??? par : personne" );
			}
		}
		//info or et temps
		labelInfoOr.setText("or: " + fenetre.getFenetreFaction().getOr());
		int indice = 0;
		for (Territoire t : t1.getListeVoisins()) {
			indice++;
		     if(indice == t1.getListeVoisins().size()) {
		    	 s = s + t.getID();
		     }
		     else {
			     s = s  + t.getID() + " , ";
		     }
		}
		label6.setText(s);
		
		if(t1.getFaction() !=null && appartient(fenetre.getFenetreFaction(),t1)) {
			label7.setText("Vous poss???dez ce territoire");
			attaquer.setEnabled(true);
			deplacer.setEnabled(true);
			ameliorer.setEnabled(true);
			if(!(t instanceof Capitale) ) {
			
			}
			else {
				recruter.setEnabled(true);
			}
		}
		else {
			label7.setText("Vous ne poss???dez pas ce territoire" );
			attaquer.setEnabled(false);
			deplacer.setEnabled(false);
			ameliorer.setEnabled(false);
		}
	}
	public String estCapitale(Territoire t) {
		if (t instanceof Capitale) {
			return "OUI";
		}
		else {
			return "NON";
		}
	}
	
	// est ce que territoire t appartient a la faction F?
		public boolean appartient(Faction f, Territoire t) {
			if (f==null || f.getTerritoires() == null) {
				return false;
			}
			else {
			ArrayList<Territoire> ListeTFaction = f.getTerritoires();
			System.out.println(t.getID());
			System.out.println(f.getTerritoires().get(0));
			for(Territoire tfaction : ListeTFaction) {
				System.out.println(tfaction.getID());
				if(t.getID().equals(tfaction.getID())) {
					return true;
				}
			}
			}
			return false;
			
		}
		

	@Override
	public void valueChanged(ListSelectionEvent e) {
		// TODO Auto-generated method stub
		if (!e.getValueIsAdjusting()) {
			index = this.liste.getSelectedIndex();
			t = territoires.get(index);
			add_label(contenu,t);
		}
	}
	

}		
