package fenetre;

import territoires.*;

import javax.swing.*;
import java.awt.*;
import java.util.*;

import principal.*;

public class Carte {
	protected Territoire[][] matrice;
	protected JLabel[][] matrice_carte;
    
	
    /*
	ImageIcon Viking_C = new ImageIcon(Main.getChemin()+ "Viking_Capitale.jpg");
	ImageIcon Viking_T = new ImageIcon(Main.getChemin() +"Viking_Territoire.jpg");
	ImageIcon Romain_C = new ImageIcon(Main.getChemin()+"Romain_Capitale.jpg");
	ImageIcon Romain_T = new ImageIcon(Main.getChemin()+"Romain_Territoire.jpg");
	ImageIcon Egyptien_C = new ImageIcon(Main.getChemin()+"Egyptien_Capitale.jpg");
	ImageIcon Egyptien_T = new ImageIcon(Main.getChemin()+"Egyptien_Territoire.jpg");
	ImageIcon Libre = new ImageIcon(Main.getChemin()+"Libre.jpg");

*/
	private int x = (int)(Main.getTaillePanelCentral()/Main.getNbLignes()*0.9);
	private int y = (int)(Main.getTaillePanelCentral()/Main.getNbColonnes()*0.9);
	
	ImageIcon Viking_C = new ImageIcon(new ImageIcon(Main.CHEMIN + "Viking_Capitale.jpg").getImage().getScaledInstance(x,y, Image.SCALE_DEFAULT));
	ImageIcon Viking_T = new ImageIcon(new ImageIcon(Main.CHEMIN + "Viking_Territoire.jpg").getImage().getScaledInstance(x, y, Image.SCALE_DEFAULT));
	
	ImageIcon Indien_C = new ImageIcon(new ImageIcon(Main.CHEMIN + "Indien_Capitale.jpg").getImage().getScaledInstance(x,y, Image.SCALE_DEFAULT));
	ImageIcon Indien_T = new ImageIcon(new ImageIcon(Main.CHEMIN + "Indien_Territoire.jpg").getImage().getScaledInstance(x,y, Image.SCALE_DEFAULT));

	ImageIcon Samurai_C = new ImageIcon(new ImageIcon(Main.CHEMIN + "Samurai_Capitale.jpg").getImage().getScaledInstance(x,y, Image.SCALE_DEFAULT));
	ImageIcon Samurai_T = new ImageIcon(new ImageIcon(Main.CHEMIN + "Samurai_Territoire.jpg").getImage().getScaledInstance(x,y, Image.SCALE_DEFAULT));

	ImageIcon Spartiate_C = new ImageIcon(new ImageIcon(Main.CHEMIN + "Spartiate_Capitale.jpg").getImage().getScaledInstance(x,y, Image.SCALE_DEFAULT));
	ImageIcon Spartiate_T = new ImageIcon(new ImageIcon(Main.CHEMIN + "Spartiate_Territoire.jpg").getImage().getScaledInstance(x,y, Image.SCALE_DEFAULT));

	ImageIcon Mongol_C = new ImageIcon(new ImageIcon(Main.CHEMIN + "Mongol_Capitale.jpg").getImage().getScaledInstance(x,y, Image.SCALE_DEFAULT));
	ImageIcon Mongol_T = new ImageIcon(new ImageIcon(Main.CHEMIN + "Mongol_Territoire.jpg").getImage().getScaledInstance(x,y, Image.SCALE_DEFAULT));

	
	ImageIcon Romain_C = new ImageIcon(new ImageIcon(Main.CHEMIN + "Romain_Capitale.jpg").getImage().getScaledInstance(x, y, Image.SCALE_DEFAULT));
	ImageIcon Romain_T = new ImageIcon(new ImageIcon(Main.CHEMIN + "Romain_Territoire.jpg").getImage().getScaledInstance(x, y, Image.SCALE_DEFAULT));
	 
	ImageIcon Egyptien_C = new ImageIcon(new ImageIcon(Main.CHEMIN + "Egyptien_Capitale.jpg").getImage().getScaledInstance(x, y, Image.SCALE_DEFAULT));
	ImageIcon Egyptien_T = new ImageIcon(new ImageIcon(Main.CHEMIN + "Egyptien_Territoire.jpg").getImage().getScaledInstance(x, y, Image.SCALE_DEFAULT));
	
	ImageIcon Libre = new ImageIcon(new ImageIcon(Main.CHEMIN + "Libre.jpg").getImage().getScaledInstance(x, y, Image.SCALE_DEFAULT));
	
	
	//(int i = 0; i < this.matrice[0].length; i++)
	//(int j = 0; j < this.matrice[i].length; j++)
	public Carte(Territoire[][] matrice,int lignes, int colonnes) {
		System.out.println(x + " et " +  y);
		this.matrice = new Territoire[lignes][colonnes];
		for (int i = 0; i<lignes; i++) {
			for  (int j = 0; j<colonnes; j++){
				
				this.matrice[i][j] = matrice[i][j];
				}
			}
		
		
		
	this.matrice_carte = new JLabel[lignes][colonnes];
	for (int i = 0; i < lignes; i++) {
		for (int j = 0; j < colonnes; j++) {
			this.matrice_carte[i][j] = new JLabel();
			if (this.matrice[i][j].getFaction() != null) {
			if (this.matrice[i][j].getFaction().getNom() != null) {
			switch (this.matrice[i][j].getFaction().getNom()) {
			case "Vikings":
				if (matrice[i][j] instanceof Capitale) {
					this.matrice_carte[i][j].setIcon(Viking_C);

				} else {
					this.matrice_carte[i][j].setIcon(Viking_T);
				}
				break;
			case "Mongols":
				if (matrice[i][j] instanceof Capitale) {
					this.matrice_carte[i][j].setIcon(Mongol_C);
				} else {
					this.matrice_carte[i][j].setIcon(Mongol_T);
				}
				break;
				
			case "Spartiates":
				if (matrice[i][j] instanceof Capitale) {
					this.matrice_carte[i][j].setIcon(Spartiate_C);
				} else {
					this.matrice_carte[i][j].setIcon(Spartiate_T);
				}
				break;
			case "Samurais":
				if (matrice[i][j] instanceof Capitale) {
					this.matrice_carte[i][j].setIcon(Samurai_C);
				} else {
					this.matrice_carte[i][j].setIcon(Samurai_T);
				}
				break;
			case "Indiens":
				if (matrice[i][j] instanceof Capitale) {
					this.matrice_carte[i][j].setIcon(Indien_C);
				} else {
					this.matrice_carte[i][j].setIcon(Indien_T);
				}
				break;

				
			case "Romains":
				if (matrice[i][j] instanceof Capitale) {
					this.matrice_carte[i][j].setIcon(Romain_C);
				} else {
					this.matrice_carte[i][j].setIcon(Romain_T);
				}
				break;

			case "Egyptiens":
				if (matrice[i][j] instanceof Capitale) {
					this.matrice_carte[i][j].setIcon(Egyptien_C);
				} else {
					this.matrice_carte[i][j].setIcon(Egyptien_T);
				}
				break;
				}
			}
		}else {
			this.matrice_carte[i][j].setIcon(Libre);
			}
		}	
	}
}
	


	public JLabel[][] getMatrice_carte() {
		return matrice_carte;
	}



	public void setMatrice_carte(JLabel[][] matrice_carte) {
		this.matrice_carte = matrice_carte;
	}
}

