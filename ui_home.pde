import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

class HomeUI implements ActionListener
{
  JButton b1,b2,b3, b4;
  
  void createHomePage()
  { 
      b1 = new JButton("Average Noise Levels");
      b2 = new JButton("Noise Wheel");
      b3 = new JButton("Noise Timeline");
      b4 = new JButton("Noise Movie");
      
      b1.setBounds(35,35,350,100);
      b2.setBounds(35,170,350,100);
      b3.setBounds(35,305,350,100);
      b4.setBounds(35,440,350,100);

      b1.setActionCommand("b1");
      b2.setActionCommand("b2");
      b3.setActionCommand("b3");
      b4.setActionCommand("b4");            
      
      b1.addActionListener(this);
      b2.addActionListener(this);
      b3.addActionListener(this);
      b4.addActionListener(this);
                   
      f.getContentPane().removeAll();     
      f.add(b1); f.add(b2); f.add(b3); f.add(b4);
      f.repaint();
  }
  
  public void actionPerformed(ActionEvent e) {
    
    switch(e.getActionCommand())
    {
      case "b1":
      AverageNoiseLevels objAverageNoiseLevels = new AverageNoiseLevels();
      objAverageNoiseLevels.createPage();
      break;
      case "b2":
      NoiseWheel objNoiseWheel = new NoiseWheel();
      objNoiseWheel.createPage();
      break;
      case "b3":
      NoiseTimeline objNoiseTimeline = new NoiseTimeline();
      objNoiseTimeline.createPage();
      break;
      case "b4":
      NoiseMovie objNoiseMovie = new NoiseMovie();
      objNoiseMovie.createPage();
      break;
    }
  } 
  
  
}
