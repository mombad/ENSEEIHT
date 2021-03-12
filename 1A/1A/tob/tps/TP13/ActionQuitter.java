import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class ActionQuitter extends MouseAdapter {
	@Override
	public void mouseClicked(MouseEvent ev) {
		System.out.println("On quitte le jeu.");
        System.exit(0);
        }
	}
