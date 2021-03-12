package strategie;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import factions.Faction;
import troupes.*;
import territoires.*;

public class StrategieIA implements Strategie{

	private ArrayList<Troupe> deplace;
	private Faction f;
	
	private Capitale capitaleIA;;
	
	public StrategieIA(Faction faction) {
		this.f = faction;
	}
	@Override
	public void jouerTour() {
		this.capitaleIA = trouverCapitale();
		double or = f.getOr();
		long nombre = Math.round(0.70*or/Offensive.PRIX);
		if (nombre > 0) {
		System.out.println("Je recrute");
		
		capitaleIA.recruter(nombre,0,0);
		}
		
		if (estDanger().booleen) {
			System.out.println("Je suis en danger");
			renforcer(estDanger().territoire);
		}
		else {
			StrategieIAIndicateur si = opportuniteAttaque();
			if (si.booleen) {
				System.out.println("TAILLE IA AVANT ATK " + f.getTerritoires().size());
				si.territoire.attaquer(voisinFaible(si.territoire),(int) (si.territoire.getNbTroupesOffensives()*0.9),0,0);
				System.out.println("TAILLE IA APRES ATK " + f.getTerritoires().size());
			}
			else {
				or = f.getOr();
				nombre = Math.round(0.70*or/Offensive.PRIX);
				if (nombre > 0) {
				System.out.println("Je recrute");
				capitaleIA.recruter(0,nombre,0);
				System.out.println("J'eparpille");
				eparpiller(capitaleIA);
				}	
			}
		}
	}
	
	public StrategieIAIndicateur estDanger() {
		StrategieIAIndicateur retour = new StrategieIAIndicateur();
		boolean danger = false;
		System.out.println("Je cherche ma capitale");
		Territoire territoire = capitaleIA;
		System.out.println("J'ai trouvé ma capitale");
		int i = 0;
		while (!danger && i<f.getTerritoires().size()) {
			System.out.println(i);
			territoire = f.getTerritoires().get(i);
			if (territoire.getDefenseTotale()<1.5*maxTroupesVoisins(territoire)) {
				danger = true;
			}
			i++;
			
		}
		retour.booleen = danger;
		retour.territoire = territoire;					
		return retour;
	}
	
	
	
	
	public double maxTroupesVoisins(Territoire t) {
		double max = 0;
		for (int i=0; i<t.getListeVoisins().size(); i++) {
			if (!this.f.getTerritoires().contains(t.getListeVoisins().get(i))){
			if (max<t.getListeVoisins().get(i).getAttaqueTotale()) {
				max = t.getListeVoisins().get(i).getAttaqueTotale();
				}
		}}
		return max;
	}
	
	
	public Territoire voisinFaible(Territoire t) {
		double min = t.getAttaqueTotale();
		System.out.println(min);
		Territoire faible = null;
		for (int i=0; i<t.getListeVoisins().size(); i++) {
			if (min>t.getListeVoisins().get(i).getDefenseTotale()) {
				min = t.getListeVoisins().get(i).getDefenseTotale();
				faible = t.getListeVoisins().get(i);
				}
		}
		return faible;		
	}
	
	public StrategieIAIndicateur opportuniteAttaque() {
		int i = 0;
		boolean opportunite = false;
		Territoire faible;
		Territoire t = f.getTerritoires().get(i);
		StrategieIAIndicateur retour = new StrategieIAIndicateur();

		while (!opportunite) {
			faible = voisinFaible(t);
			if (faible.getDefenseTotale()<0.8*t.getAttaqueTotale()) {	
				System.out.println("J'ai trouvé un faible très nul");

				opportunite = true;
				retour.territoire = t;
				
				
			}
			i++;
			if (!opportunite){
				t = f.getTerritoires().get(i);
			}
		}
		retour.booleen = opportunite;
		return retour;
	}

	public void renforcer(Territoire t) {
		Capitale capitale = capitaleIA;
		double or = f.getOr();
		long nombre = Math.round(0.70*or/Defensive.PRIX);
		if (nombre > 0) {
		capitale.recruter(0,nombre,0);	}	
		System.out.println("J'ai recruté " + nombre + " troupes");
		List<Territoire> chemin = new ArrayList<Territoire>();//chemin
		trouverChemin(capitale,t,chemin);
		deplace = new ArrayList<Troupe>();
		if (t.getID() != capitale.getID()) {
		for (int i= 0; i<capitale.getTroupes().size(); i++) {
			if (capitale.getTroupes().get(i) instanceof Defensive){ 
				if (capitale.getTroupes() != null) {
				deplace.add(capitale.getTroupes().get(i));
			}
		}
			}
		if (chemin.size()>2) {
		for (int k=0; k<chemin.size(); k++) {
			for (Troupe Tr : deplace) {
			chemin.get(k).transfTRP(chemin.get(k+1), Tr);
			System.out.println("TAILLE TERRITOIRE IA " + f.getTerritoires().size());
		}}
			}
	}}
	
	public void initChemin(int[][] matrice, boolean fini, List<Territoire> chemin,List<Territoire> interdit,Territoire depart,Territoire destination ) {	
		int taille = f.getTerritoires().size();
		for (int i=0; i<taille;i++) {		//Initialisation ï¿½ 0	
			for (int j=0; j<taille; j++) {
				matrice[i][i]=0;
			}
		}
		
		for (int i=0; i<taille;i++) {		//Si i a comme voisin j alors on met un 1 dans la case correspondante
			matrice[i][i]=1;
			for (int j=0; j<taille; j++) {
				for (int k=0; k<f.getTerritoires().get(j).getListeVoisins().size(); k++) {
					if (f.getTerritoires().get(j).getListeVoisins().get(k) == f.getTerritoires().get(i)){
						matrice[i][j] = 1;
					}
				}
			}
		}
	}
	public void recursiveChemin(int[][] matrice, boolean fini, List<Territoire> chemin,List<Territoire> interdit,Territoire depart,Territoire destination) {
		if (!fini) {
			int i = f.getTerritoires().indexOf(depart);
			int j = f.getTerritoires().indexOf(destination);
			if (matrice[i][j]==1) {
				chemin.add(destination);
				fini = true;
				}
			else {
				if(!interdit.contains(f.getTerritoires().get(i))) {
				chemin.add(f.getTerritoires().get(i));
				interdit.add(f.getTerritoires().get(i));
				for (int k=0; i<matrice.length; i++) {
					if (!interdit.contains(f.getTerritoires().get(k)) && matrice[i][k]==1) {
						recursiveChemin(matrice,fini,chemin,interdit,f.getTerritoires().get(k),destination);
					}				
					}							
					if (!fini) {chemin.remove(chemin.size());}

				}
			}			
		}
	}
	
	public void trouverChemin(Territoire depart, Territoire destination, List<Territoire> chemin) {
		boolean fini = false;
		List<Territoire> interdit = new ArrayList<Territoire>();//territoires utilisï¿½s
		int taille = f.getTerritoires().size();
		int[][] matrice = new int [taille][taille];
		initChemin(matrice,fini,chemin,interdit,depart,destination);
		recursiveChemin(matrice,fini,chemin,interdit,depart,destination);
	}
	
	public Capitale trouverCapitale() {		
		int i = 0;
		System.out.println("TAILLE TERRITOIRE IA " + f.getTerritoires().size());
		Territoire c = f.getTerritoires().get(i);
		while (!(c instanceof Capitale)) {
			i++;
			c = f.getTerritoires().get(i);
		}
		return (Capitale) c;
	}
	
	public void eparpiller(Capitale c) {
		for(int i=0; i<c.getTroupes().size();i=i+2) {
			int nombre = f.getTerritoires().size();
			Random r = new Random();
			int choisi = r.nextInt(nombre)+1;
			List<Territoire> chemin = new ArrayList<Territoire>();
			trouverChemin(c,f.getTerritoires().get(choisi),chemin);
			deplaceChemin(chemin,c.getTroupes().get(i));
		}
	}
	public void deplaceChemin(List<Territoire> chemin, Troupe Tr) {
		for (int k=0; k<chemin.size()+1; k++) {
			chemin.get(k).transfTRP(chemin.get(k+1), Tr);
			}
	}

}
