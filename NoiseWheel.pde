import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


class NoiseWheel implements ActionListener
{
  JSpinner spLocation;
  JButton b1, b2;
  JTextField  toDate;
  JTextField  fromDate;
  JSlider toSlider;
  JSlider fromSlider;
  JLabel l1,l2,l3,l4,l5,l6,l7;
                
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
      spLocation = new JSpinner();
      spLocation.addChangeListener(cl3); 
      
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
      
      l3.setBounds(35,17,350,35);
      l4.setBounds(350,17,350,35);
      fromSlider.setBounds(35,40,350,35);
      l1.setBounds(35,65,350,35);
      fromDate.setBounds(35,90,350,35);
      
      l5.setBounds(35,140,350,35);
      l6.setBounds(350,140,350,35);
      toSlider.setBounds(35,170,350,35);
      l2.setBounds(35,195,350,35);
      toDate.setBounds(35,225,350,35);
      
      l7.setBounds(35,255,350,35);
      spLocation.setBounds(35,285,350,90);
      
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
      r1.setBounds(35,255,50,40);    
      r2.setBounds(85,255,50,40);  
      r3.setBounds(135,255,50,40); 
      r4.setBounds(185,255,50,40);  
      r5.setBounds(235,255,50,40); 
      
      ButtonGroup bg=new ButtonGroup();    
      bg.add(r1);bg.add(r2);bg.add(r3);bg.add(r4);bg.add(r5);    
      
   
      f.getContentPane().removeAll();
      f.add(b2);f.add(l7);f.add(spLocation);
      f.add(l1); f.add(l2); f.add(l3); f.add(l4);
      f.add(l5); f.add(l6); f.add(b1); f.add(toDate);
      f.add(r1);f.add(r2);f.add(r3);f.add(r4);f.add(r5);
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
