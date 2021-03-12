import javax.swing.JTextArea;

public class ControleurChat extends JTextArea {
	private Chat chat;
	private String pseudo;
	
	public ControleurChat(Chat c, String ps) {
		this.chat = c;
		this.pseudo = ps;
	}
	
	public void Envoyer() {
		Message m = new MessageTexte(this.pseudo, this.getText());
		this.chat.ajouter(m);
		this.setText("");
	}
	
	public String getPseudo() {
		return this.pseudo;
	}
}
