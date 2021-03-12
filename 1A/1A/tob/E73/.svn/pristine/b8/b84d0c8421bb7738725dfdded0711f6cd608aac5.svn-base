package fenetre;

import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.JLabel;
import javax.swing.*;

public class JsliderListener implements ChangeListener{
	private JLabel label;
	private int value;
	private JSlider slider;
	String txt;
	public JsliderListener(JLabel label,JSlider slider, String txt ) {
		this.label = label;
		this.slider = slider;
		this.txt = txt; 
	}
	@Override
	public void stateChanged(ChangeEvent arg0) {
		value = slider.getValue();
		label.setText(txt + value);
		
		// TODO Auto-generated method stub
		
	}

}
