import javax.swing.JFrame;

public class test {
	
	public static void main(String args[]) {
		//Chat c = new Chat();
//		Observateur o = new Observateur(c);
	//	MessageTexte m = new MessageTexte("jojo","Je m'appelle Jojo");
		//c.ajouter(m);

	//	MessageTexte m1 = new MessageTexte("lolo","Je m'appelle lolo");
	//	c.ajouter(m1);
		
		Chat c = new Chat();
		
		VueChatFenetre f = new VueChatFenetre(c,"Joe");
		VueChatFenetre f1 = new VueChatFenetre(c, "Jack");
		
		
		
		
	}
	

}
