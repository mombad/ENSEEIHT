package fenetre;

import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JSlider;

import factions.Faction;
import territoires.Territoire;
import troupes.*;

public class ActionConfirmerDeplacement implements ActionListener{
	private Faction f;
	private JlistListener listeChoix;
	private JlistListenerVoisin listeCible;
	private Container contenu;
	private JFrame fenetre;
	private JSlider off,def,eq;
	
	public ActionConfirmerDeplacement(Faction f, JlistListener listeChoix, 
			JlistListenerVoisin listeCible,  Container contenu, JFrame fenetre,
			JSlider off, JSlider def, JSlider eq) {
		this.f = f;
		this.listeChoix = listeChoix;
		this.contenu = contenu;
		this.fenetre = fenetre;
		this.listeCible = listeCible;
		this.fenetre = fenetre;
		this.off = off;
		this.def = def;
		this.eq = eq;
	}
	
	public void deplacer(Territoire selected, Territoire dest, int nbTroupes, int choix) {
		int nbpossede;
		if(choix == 0) {
			nbpossede = selected.getNbTroupesOffensives();
		}
		else if (choix == 1) {
			nbpossede = selected.getNbTroupesDefensives();
		} else {
			nbpossede = selected.getNbTroupesEquilibrees();
		}
		if(nbTroupes > selected.getNbTroupesOffensives()) {
			System.out.println("Vous ne possédez pas autant de troupes");
		}
		while(nbTroupes != 0) {
			if(selected.getTroupes().get(nbTroupes) instanceof Offensive) {
				selected.transfTRP(dest, selected.getTroupes().get(nbTroupes));
				nbTroupes--;
			}
		}
	}
	
	public void Conserver(Territoire t, List <Integer> aConserver) {
		List <Troupe> copieSelected = new ArrayList<Troupe>(t.getTroupes());
		t.getTroupes().clear();
		for(int i : aConserver) {
			t.getTroupes().add(copieSelected.get(i));
		}
		System.out.println(t.getTroupes().size());
		
	}
	
	@Override
	public void actionPerformed(ActionEvent e) {
		Territoire selected = listeChoix.getTerritoire();
		int len = selected.getTroupes().size();
		Territoire dest = listeCible.getTerritoire();
		List <Integer> aConserver = new ArrayList<Integer>();
		int nbOff = off.getValue();
		int nbDef = def.getValue();
		int nbEq = eq.getValue();
		// TODO Auto-generated method stub
		for(int i = 0; i < len; i++) {
			if(selected.getTroupes().get(i) instanceof Offensive && nbOff > 0) {
				selected.transfTRP(dest, selected.getTroupes().get(i));
				//indice des troupes a enlever du territoire
				System.out.println(nbOff);
				nbOff--;
			}
			else if(selected.getTroupes().get(i) instanceof Offensive && nbOff <=0){
				aConserver.add(i);
			}
		}
		System.out.println(selected.getTroupes().size());
		//Conserver(selected, aConserver);
		for(int i = 0; i < selected.getTroupes().size(); i++) {
			if(selected.getTroupes().get(i) instanceof Defensive && nbDef > 0) {
				selected.transfTRP(dest, selected.getTroupes().get(i));
				System.out.println(nbDef);
				nbDef--;
			}
			else if(selected.getTroupes().get(i) instanceof Defensive && nbDef <= 0) {
				aConserver.add(i);
			}
		}
		//Conserver(selected, aConserverDef);
		for(int i = 0; i < len; i++) {
			if(selected.getTroupes().get(i) instanceof Equilibre && nbEq > 0) {
				selected.transfTRP(dest, selected.getTroupes().get(i));
				nbEq--;
			} else if (selected.getTroupes().get(i) instanceof Equilibre && nbEq <=0) {
				aConserver.add(i);
			}
		}
		Conserver(selected, aConserver);
		listeChoix.add_label(contenu, listeChoix.getTerritoire());
		fenetre.dispose();
	}
}
