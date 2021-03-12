import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.JLabel;

public class ActionCocher extends MouseAdapter {
	MorpionSwing morpion;
    private int x;    // abscisse de la case
    private int y;    // ordonnée de la case

    public ActionCocher(MorpionSwing morpion, int x, int y) {
    	this.morpion = morpion;
        this.x = x;
        this.y = y;
    }

    @Override
    public void mouseClicked(MouseEvent e) {
			this.morpion.cocher(x, y);
			
    	}
    }