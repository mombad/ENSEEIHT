import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.GridLayout;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextArea;

public class ControleurChatFenetre extends JPanel {
	JButton ok;
	ControleurChat cc;
	

	
	 public ControleurChatFenetre(ControleurChat cchat) {
		this.ok = new JButton("OK");
		this.cc = cchat;
		this.add(this.cc);
		this.add(this.ok,BorderLayout.EAST);
		
		this.setVisible(true);		
		this.ok.addMouseListener(new ActionEnvoyer(this.cc));

	}

}
