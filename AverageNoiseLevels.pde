import java.beans.EventHandler;

import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


class AverageNoiseLevels implements ActionListener
{
  JButton b1, b2;
  JTextField  toDate;
  JTextField  fromDate;
  JSlider toSlider;
  JSlider fromSlider;
  JLabel l1,l2,l3,l4,l5,l6;
                
static final int MIN = 1356998400;
static final int MAX = 1553385600;
  
  ChangeListener cl1 = new ChangeListener()
  {
      public void stateChanged(ChangeEvent e) {
        startDate = (long)fromSlider.getValue(); 
        fromDate.setText(getDateString(startDate));
    }
  };
  
  ChangeListener cl2 = new ChangeListener()
  {
      public void stateChanged(ChangeEvent e) {
          endDate = (long)toSlider.getValue(); 
          toDate.setText(getDateString(endDate));
    }
  };
  
  void createPage()
  {   
      l1 = new JLabel("From Date");
      l2 = new JLabel("To Date");
      l3 = new JLabel(getDateString(MIN));
      l4 = new JLabel(getDateString(MAX));
      l5 = new JLabel(getDateString(MIN));
      l6 = new JLabel(getDateString(MAX));
      
      toDate = new JTextField (getDateString(MAX));
      fromDate = new JTextField (getDateString(MIN));
      toDate.setEnabled(false);
      fromDate.setEnabled(false);
      b1 = new JButton("Process!");
      b2 = new JButton("BACK");
      
      fromSlider = new JSlider(JSlider.HORIZONTAL, MIN, MAX, MIN);      
      toSlider = new JSlider(JSlider.HORIZONTAL, MIN, MAX, MAX);
      
      l3.setBounds(35,20,350,35);
      l4.setBounds(350,20,350,35);
      fromSlider.setBounds(35,50,350,35);
      l1.setBounds(35,80,350,35);
      fromDate.setBounds(35,110,350,35);
      
      l5.setBounds(35,170,350,35);
      l6.setBounds(350,170,350,35);
      toSlider.setBounds(35,200,350,35);
      l2.setBounds(35,225,350,35);
      toDate.setBounds(35,255,350,35);
      
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
      f.add(l1); f.add(l2); f.add(l3); f.add(l4);
      f.add(l5); f.add(l6); f.add(b1); f.add(toDate);
      f.add(fromDate); f.add(toSlider); f.add(fromSlider);
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
  
  println(line_2);
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
