import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.GridLayout;

import javax.swing.*;

public class VueChatFenetre extends JFrame {
	JButton fermer;
	Container contenu;
	public VueChatFenetre(Chat c, String pseudo) {
		this.contenu = this.getContentPane();
		contenu.setLayout(new GridLayout(4,1,30,30));		
		this.fermer = new JButton("Fermer");
		this.contenu.add(this.fermer,BorderLayout.NORTH);
		this.contenu.add(new VueChat(c));
		this.setSize(500,500);
		this.setVisible(true);
		
		ControleurChatFenetre ccf = new ControleurChatFenetre(new ControleurChat(c,pseudo));
		c.ajouter(new MessageTexte(pseudo,"vient de se connecter"));
		this.add(ccf.cc,BorderLayout.SOUTH);
		this.add(ccf.ok);

		
		fermer.addMouseListener(new ActionFermer());
	}
}
