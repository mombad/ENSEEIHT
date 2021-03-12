import java.awt.Component;
import java.awt.Graphics;
import java.util.Observable;
import java.util.Observer;
import javax.swing.*;
public class VueChat extends JTextArea implements Observer{
	
	public VueChat(Chat c) {
		c.addObserver(this);
		}
	
	@Override
	public void update(Observable o, Object arg) {
		this.append(arg.toString() + "\n");		
		}
	
	

}
