import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


class NoiseWheel implements ActionListener
{
  JSpinner spLocation;
  JButton b1, b2;
  JSlider toSlider;
  JSlider fromSlider;
  JLabel l1,l2,l7;
                
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
      l7 = new JLabel("Select Location:");
      spLocation = new JSpinner(new SpinnerListModel(locNames));
      spLocation.addChangeListener(cl3); 
      
      l1 = new JLabel("From Date: " + getDateString(MIN));
      l2 = new JLabel("To Date: " + getDateString(MAX));
       
      b1 = new JButton("Process!");
      b2 = new JButton("BACK");
      
      fromSlider = new JSlider(JSlider.HORIZONTAL, MIN, MAX, MIN);      
      toSlider = new JSlider(JSlider.HORIZONTAL, MIN, MAX, MAX);
      
      fromSlider.setBounds(35,40,350,35);
      l1.setBounds(35,65,350,35);
      
      toSlider.setBounds(35,100,350,35);
      l2.setBounds(35,125,350,35);
      
      l7.setBounds(35,155,350,35);
      spLocation.setBounds(35,185,350,35);
      
      b1.setBounds(35,480,350,100);
      b1.setActionCommand("b1");            
      b1.addActionListener(this);
      b2.setBounds(35,420,350,40);
      b2.setActionCommand("b2");            
      b2.addActionListener(this);
                      
      toSlider.addChangeListener(cl2);
      fromSlider.addChangeListener(cl1);
      
      
      
      JRadioButton r1=new JRadioButton("Hourly");    
      JRadioButton r2=new JRadioButton("Daily");
      JRadioButton r3 =new JRadioButton("Weekly");
      JRadioButton r4 =new JRadioButton("Monthly");
      JRadioButton r5 =new JRadioButton("Yearly");
      r5.setSelected(true);
      r1.setBounds(35,222,80,40);    
      r2.setBounds(118,222,80,40);  
      r3.setBounds(191,222,80,40); 
      r4.setBounds(280,222,80,40);  
      r5.setBounds(371,222,80,40); 
      
      ButtonGroup bg=new ButtonGroup();    
      bg.add(r1);bg.add(r2);bg.add(r3);bg.add(r4);bg.add(r5);   
      
      
      JRadioButton r6=new JRadioButton("Average Values for cycle");    
      JRadioButton r7=new JRadioButton("Raw values"); 
      r6.setSelected(true);
      r6.setBounds(35,250,180,40);    
      r7.setBounds(215,250,180,40);   
      
      ButtonGroup bg2=new ButtonGroup();    
      bg2.add(r6);bg2.add(r7);
      
      JRadioButton r8=new JRadioButton("Show Markers");    
      JRadioButton r9=new JRadioButton("Hide Markers"); 
      r8.setSelected(true);
      r9.setBounds(35,280,180,40);    
      r8.setBounds(215,280,180,40);   
      
      ButtonGroup bg3=new ButtonGroup();    
      bg3.add(r8);bg3.add(r9);
      
   
      f.getContentPane().removeAll();
      f.add(b2);f.add(l7);f.add(spLocation);
      f.add(r6);f.add(r7);f.add(r8);f.add(r9);
      f.add(l1); f.add(l2); f.add(b1);
      f.add(r1);f.add(r2);f.add(r3);f.add(r4);f.add(r5); f.add(toSlider); f.add(fromSlider);
         
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

 
void loadAndDrawDataForWheel()
{ 
  Table table_1;
  
  table_1 = loadTable("data_8", "csv");
  //table_1.sort(1);
  println(table_1.getRowCount() + " total rows in table");
  
  float[] SEGMENTS = {12.0, 288.0, 288.0 * 7, 288.0 * 30, 288.0 * 365};
  float segements = SEGMENTS[wheelType];
  float[] PERIODICITY = {365.0 * 24.0, 365.0, 52.0, 12.0, 1};
  float cyclePeriodicity = PERIODICITY[wheelType];
  float cycleCount = cyclePeriodicity * 6.25; 
  
  int cx = displayWidth/2;
  int cy = displayHeight/2;
  float radius = 700.0;
  
  float thetaInc = 360/segements;
  float radiusDec = (radius)/cycleCount;
  println(radiusDec);
  float start = 0;
  float end   = thetaInc;
  int cycles = 0;
  
  ArrayList<Float> rList = new ArrayList();
  
  for (int i = 0; i<table_1.getRowCount(); i++)
  //for (int i = 0; i<7*288; i++)
  {
      TableRow row = table_1.getRow(i);

      float NOISE = row.getFloat(1);
 
      fillColor = getColorForNoise(NOISE);
      
      fill(fillColor);
      stroke(fillColor);
      arc(cx, cy, radius, radius, radians(start), radians(end));
      start = end;
      end += thetaInc;
      
     if(start >= 360)
     {
         if(cycles%cyclePeriodicity == 0)
           rList.add(radius);

         start = 0;
         end = thetaInc;
         radius -= radiusDec;
         cycles++;
     }
  }
   
  for(float r : rList)
  {
      println(r);
      stroke(color(0,0,0));
      noFill();
      circle(cx,cy,r);
  }
}
