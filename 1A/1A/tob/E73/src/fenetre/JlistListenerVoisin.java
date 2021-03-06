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

public class JlistListenerVoisin implements ListSelectionListener{
	private JList liste;
	private int index;
	private List <Territoire> territoires;
	private Territoire t;
	private Container contenu;
	FenetreJeu fenetre;
	JButton valider;
	List <String> les_territoires;
	
	public JlistListenerVoisin(JList liste, JButton valider,List <Territoire> les_territoires) {
		this.liste = liste;
		this.valider = valider;
		this.territoires = les_territoires;
	}
	
	public Territoire getTerritoire() {
		return this.t;
	}
		

	@Override
	public void valueChanged(ListSelectionEvent e) {
		// TODO Auto-generated method stub
		if (!e.getValueIsAdjusting()) {
			index = this.liste.getSelectedIndex();
			t = territoires.get(index);
			System.out.println("terrritoire : "+ t.getID());
			valider.setEnabled(true);
		}
	}
	

}		

