import java.beans.EventHandler;

import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


class AverageNoiseLevels implements ActionListener
{
  JButton b1, b2;
  JSlider toSlider;
  JSlider fromSlider;
  JLabel l1,l2;
                
static final int MIN = 1356998400;
static final int MAX = 1553385600;
  
  ChangeListener cl1 = new ChangeListener()
  {
      public void stateChanged(ChangeEvent e) {
        startDate = (long)fromSlider.getValue();         
        if(startDate>endDate)
          startDate = endDate;
        l1.setText("From: " + getDateString(startDate));
    }
  };
  
  ChangeListener cl2 = new ChangeListener()
  {
      public void stateChanged(ChangeEvent e) {
          endDate = (long)toSlider.getValue();  
          if(startDate>endDate)
             endDate = startDate;
          l2.setText("To: " + getDateString(endDate));
    }
  };
  
  void createPage()
  {   
      l1 = new JLabel("From Date: " + getDateString(MIN));
      l2 = new JLabel("To Date: " + getDateString(MAX));
      
      b1 = new JButton("Process!");
      b2 = new JButton("BACK");
      
      fromSlider = new JSlider(JSlider.HORIZONTAL, MIN, MAX, MIN);      
      toSlider = new JSlider(JSlider.HORIZONTAL, MIN, MAX, MAX);
      
      fromSlider.setBounds(35,50,350,35);
      l1.setBounds(35,80,350,35);
      
      toSlider.setBounds(35,133,350,35);
      l2.setBounds(35,165,350,35);
      
      b1.setBounds(35,480,350,100);
      b1.setActionCommand("b1");            
      b1.addActionListener(this);
      b2.setBounds(35,420,350,40);
      b2.setActionCommand("b2");            
      b2.addActionListener(this);
                      
      toSlider.addChangeListener(cl2);
      fromSlider.addChangeListener(cl1);
      
      f.getContentPane().removeAll();
      f.add(b2);
      f.add(l1); f.add(l2);f.add(b1);
      f.add(toSlider); f.add(fromSlider);
      f.repaint();
  }
  
  
  
  public void actionPerformed(ActionEvent e) {
    
    switch(e.getActionCommand())
    {
      case "b1":
       currentScreen = AVERAGE_NOISE_SCREEN;
       needToDraw = true;
       break;
      case "b2":
       objHome.createHomePage();
       break;
    }
  } 
}


void drawHeader()
{
  String line_1 = "Dublin Average Noise Levels";
  String line_2 = "[" + getDateString(startDate) + " - " + getDateString(endDate) + "]";
  fill(color(0));
  
  textAlign(CENTER, CENTER);
  textSize(26);
  text(line_1, displayWidth/2, 18);
  
  textSize(20);
  text(line_2, displayWidth/2, 48);
}

void drawLocationWithAverageValues()
{
  int buffer_x = 20;
  int buffer_y = 53;
  
  int x,y;
  x = (displayWidth - 2*buffer_x)/4;
  y = (displayHeight - 2*buffer_y)/3;
 
  int paddingX = x/10;
  int paddingY = y/7;
  
  int loc_i = 1;
  int marginTop = 44;
  for(int i=buffer_x; i<(buffer_x+ x*4); i+=x)
  {
    for(int j=buffer_y + marginTop; j<(buffer_y+ y*3); j+=y)
    {
      float avgNoiseForLocation = computeAverageNoise(loc_i, startDate, endDate);
      fill(getColorForNoise(avgNoiseForLocation));
      rect(i+paddingX,j+paddingY,x-(2*paddingX),y-(2*paddingY));    
    
      fill(color(0));
      if(loc_i == 5)
        textSize(13);
      else
        textSize(14);
      text(
      locNames[loc_i++] + "\nAvg. Noise = " + avgNoiseForLocation, 
      ((i+paddingX) + (x-(2*paddingX))/2),
      j+9);      
    }
  }
}
