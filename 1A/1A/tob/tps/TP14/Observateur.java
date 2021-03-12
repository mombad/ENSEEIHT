import java.util.Observable;
import java.util.Observer;

public class Observateur implements Observer {
	
	public Observateur(Chat c) {
		c.addObserver(this);
	}

	@Override
	public void update(Observable arg0, Object arg1) {
		System.out.println(arg1);
		
	}

}
