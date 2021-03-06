package fenetre;
import javax.swing.JPanel;
import java.awt.Graphics;
import javax.swing.Timer;
import javax.swing.JFrame;
import javax.swing.JLabel;

import java.awt.BorderLayout;
import javax.swing.JButton;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class Chrono extends JPanel{
	private long start_time;
    private int counter = 0;
    private Timer timer;
    private JLabel label;
    public Chrono(JLabel label) {
    	this.label = label;
    }
    @Override
    protected void paintComponent(Graphics g)
    {
        super.paintComponent(g);
        if (timer == null)
        {
            g.drawString("[Uninitialized]", 20, 110);
        } else
        {
            g.drawString("Compte:"+Integer.toString(counter), 20, 90);
            long t = System.currentTimeMillis();
            int delta = (int)((t-start_time)/100);
            g.drawString("Seconds:"+Double.toString(delta/10.0), 20, 120);
        }
    }

    /**
     * Lance l'experience
     */
    public void start()
    {
        timer = new Timer(1000, new ActionListener()
            {
                @Override
                public void actionPerformed(ActionEvent ignored)
                {
                    counter++;
                    label.setText("temps ecoule: " + Integer.toString(counter) + "s");
                }
            });
        timer.start();
        repaint();
    }

    /**
     * Arrete l'experience
     */
    public void stop()
    {
        timer.stop();
    }
}
