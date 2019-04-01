import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

 
class NoiseMovie implements ActionListener
{
  JButton b1, b2;
  JSlider toSlider;
  JSlider fromSlider;
  JLabel l1,l2, l7;
                
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
  
  ChangeListener cl3 = new ChangeListener()
  {
      public void stateChanged(ChangeEvent e) {
          //endDate = (long)toSlider.getValue(); 
          //toDate.setText(getDateString(endDate));
    }
  };
  
  void createPage()
  {   
      
  for(int i = 1; i<=12; i++)
    selectedLocations[i] = false;
  selectedLocations[1] = true;
    
    
      l1 = new JLabel("From Date: " + getDateString(MIN));
      l2 = new JLabel("To Date: " + getDateString(MAX));
       
      b1 = new JButton("Play!");
      b2 = new JButton("BACK");
      b1.setEnabled(false);
      
      fromSlider = new JSlider(JSlider.HORIZONTAL, MIN, MAX, MIN);      
      toSlider = new JSlider(JSlider.HORIZONTAL, MIN, MAX, MAX);
      
      fromSlider.setBounds(35,26,350,35);
      l1.setBounds(35,53,350,35);
      
      toSlider.setBounds(35,90,350,35);
      l2.setBounds(35,115,350,35);
      
      
      l7 = new JLabel("Select Location(s):");
      JCheckBox cb1=new JCheckBox(locNames[1]);    
      JCheckBox cb2=new JCheckBox(locNames[2]);
      JCheckBox cb3 =new JCheckBox(locNames[3]);
      JCheckBox cb4 =new JCheckBox(locNames[4]);
      JCheckBox cb5 =new JCheckBox(locNames[5]);
      JCheckBox cb6 =new JCheckBox(locNames[6]);
      JCheckBox cb7 =new JCheckBox(locNames[7]);
      JCheckBox cb8 =new JCheckBox(locNames[8]);
      JCheckBox cb9 =new JCheckBox(locNames[9]);
      JCheckBox cb10 =new JCheckBox(locNames[10]);
      JCheckBox cb11 =new JCheckBox(locNames[11]);
      JCheckBox cb12 =new JCheckBox(locNames[12]);
      cb1.setSelected(true);
       
      l7.setBounds(35,150,350,35);
      cb1.setBounds(35,175,81,35);
      cb2.setBounds(118,175,81,35);    
      cb3.setBounds(198,175,81,35);  
      cb4.setBounds(278,175,81,35); 
      cb5.setBounds(358,175,81,35);  
      cb6.setBounds(431,175,81,35);
      cb7.setBounds(35,205,81,35);
      cb8.setBounds(118,205,81,35);    
      cb9.setBounds(198,205,81,35);  
      cb10.setBounds(278,205,81,35); 
      cb11.setBounds(358,205,81,35);  
      cb12.setBounds(431,205,81,35);
      
      b1.setBounds(35,510,350,100);
      b1.setActionCommand("b1");            
      b1.addActionListener(this);
      b2.setBounds(35,450,350,40);
      b2.setActionCommand("b2");            
      b2.addActionListener(this);
                      
      toSlider.addChangeListener(cl2);
      fromSlider.addChangeListener(cl1);
        
      
      JRadioButton r6=new JRadioButton("Output Value = Actual noise at current time");    
      JRadioButton r7=new JRadioButton("Output Value = Average noise till current time"); 
      r6.setSelected(true);
      r6.setBounds(35,280,350,40);    
      r7.setBounds(35,310,350,40);   
      
      ButtonGroup bg2=new ButtonGroup();    
      bg2.add(r6);bg2.add(r7);
       
   
      f.getContentPane().removeAll();
      f.add(r6);f.add(r7);f.add(b2);f.add(l7);
      f.add(l1); f.add(l2);f.add(b1);f.add(toSlider); f.add(fromSlider);
      f.add(cb1);f.add(cb2);f.add(cb3);f.add(cb4);f.add(cb5);f.add(cb11);
      f.add(cb6);f.add(cb7);f.add(cb8);f.add(cb9);f.add(cb10);f.add(cb12);
         
      f.repaint();
  }
  
  
  
  public void actionPerformed(ActionEvent e) {
    
    switch(e.getActionCommand())
    {
      case "b1":
       setupMovie();
       currentScreen = NOISE_MOVIE_SCREEN;
       needToDraw = true;
       break;
      case "b2":
       objHome.createHomePage();
       break;
      case "r1":
       wheelType = 0;
       break;
      case "r2":
       wheelType = 1;
       break;
      case "r3":
       wheelType = 2;
       break;
      case "r4":
       wheelType = 3;
       break;
      case "r5":
       wheelType = 4;
       break;
    }
  }
}
 
  float noise = 0;
  int i_start = -1;
  int i_end = -1;
  int loc_i = 1;
  int marginTop = 44;
  Table table[] = new Table[13];
  int buffer_x = 20;
  int buffer_y = 53;
  int x = (displayWidth - 2*buffer_x)/4;
  int y = (displayHeight - 2*buffer_y)/3;
 
  int paddingX = x/10;
  int paddingY = y/7;
   int index;
void setupMovie()
{
  
  for(int i =1; i<=12; i++)
  {
    String dataFile = "data_" + i;
    table[i] = loadTable(dataFile, "csv");  
  }
  
  long currentTime = 0;
  for (int j = 0; j<table[1].getRowCount(); j++)
  { 
      TableRow row = table[1].getRow(j);
      currentTime = row.getLong(0);
      if(currentTime<startDate)
        continue;
      else if(i_start == -1)
        i_start = j;
      i_end = j;
      if(currentTime>endDate)
        break;
  }
  index = i_start;
}


void playNoiseMovie()
{
   if(index>=i_end)
     return;
    drawMovieHeader(table[loc_i].getRow(index).getLong(0));
    for(loc_i = 1; loc_i<=12; loc_i++)
    {
        for(int i=buffer_x; i<(buffer_x+ x*4); i+=x)
        {
          for(int j=buffer_y + marginTop; j<(buffer_y+ y*3); j+=y)
          {
            if(selectedLocations[loc_i])
            {
                
                noise = table[loc_i].getRow(index).getFloat(1);
                fill(getColorForNoise(noise));
                rect(i+paddingX,j+paddingY,x-(2*paddingX),y-(2*paddingY));    
              
                fill(color(0));
                if(loc_i == 5)
                  textSize(13);
                else
                  textSize(14);
                text(
                locNames[loc_i] + "\nNoise = " + noise, 
                ((i+paddingX) + (x-(2*paddingX))/2),
                j+9);  
                text(
                locNames[loc_i] + "\nNoise = " + noise, 
                ((i+paddingX) + (x-(2*paddingX))/2),
                j+9);    
            }
          }
        }
    }
    index++;
}


void drawMovieHeader(long time)
{
  String line_1 = "Dublin Noise Levels";
  String line_2 = "Time: " + getDateString(time);
  fill(color(0));
  
  textAlign(CENTER, CENTER);
  textSize(26);
  text(line_1, displayWidth/2, 18);
  
  textSize(20);
  text(line_2, displayWidth/2, 48);
}
