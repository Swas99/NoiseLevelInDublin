import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

int wheelType = 4;
boolean hideMarkers = false;
int selectedLocationIndex = 1;
boolean useAverageValues = false;

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
          int index=0;
          for(Object o :locNames) {
              if(o.equals(spLocation.getValue()))
                  selectedLocationIndex = index;
              index++;
          }      
          if(selectedLocationIndex<1 || selectedLocationIndex>12)
             selectedLocationIndex = 1;
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
      r1.setActionCommand("r1");            
      r1.addActionListener(this); 
      r2.setActionCommand("r2");            
      r2.addActionListener(this); 
      r3.setActionCommand("r3");            
      r3.addActionListener(this); 
      r4.setActionCommand("r4");            
      r4.addActionListener(this); 
      r5.setActionCommand("r5");            
      r5.addActionListener(this);
      
      ButtonGroup bg=new ButtonGroup();    
      bg.add(r1);bg.add(r2);bg.add(r3);bg.add(r4);bg.add(r5);   
      
      
      JRadioButton r6=new JRadioButton("Use Absolute Noise Values in sectors");    
      JRadioButton r7=new JRadioButton("Use Average Noise Values to represent sectors"); 
      r6.setSelected(true);
      r6.setBounds(35,260,380,40);    
      r7.setBounds(35,290,380,40);   
      
      ButtonGroup bg2=new ButtonGroup();    
      bg2.add(r6);bg2.add(r7);
      
      JRadioButton r8=new JRadioButton("Hide Markers");    
      JRadioButton r9=new JRadioButton("Show Markers"); 
      r9.setSelected(true);
      r9.setBounds(35,330,180,40);    
      r8.setBounds(215,330,180,40);   
      
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
       currentScreen = NOISE_WHEEL_SCREEN;
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
      case "r6":
       useAverageValues = false;
       break;
      case "r7":
       useAverageValues = true;
       break;
      case "r8":
       hideMarkers = true;
       break;
      case "r9":
       hideMarkers = false;
       break;
       
    }
  } 
}
 
void loadAndDrawDataForWheel()
{  
  Table table_1 = loadTable("data_" + selectedLocationIndex, "csv");
  
  int[] SEGMENTS = {12, 288, 288 * 7, 288 * 30, 288 * 365}; //1 Segment = 1 time unit; SEGMENTS[i] = Number Of Data-Points in one time-unit
  int segments = SEGMENTS[wheelType];
  
  double[] PERIODICITY = {365.0 * 24.0, 365.0, 365.0/7.0, 12.0, 1}; //PERIODICITY[i] Circles = 1 Year; (Each Circle is drawn with a smaller radius(reduced by a constant after each circle)
  double cyclePeriodicity = PERIODICITY[wheelType];//To draw cricles that represent 1 year
  double cycleCount = getCycleCount(startDate,endDate, wheelType); 
  
  int cx = displayWidth/2;
  int cy = displayHeight/2;
  double radiusBuffer = 60;
  double maxRadius = 700.0;
  double thetaDec = 360.0/segments;
  double radiusDec = (maxRadius-radiusBuffer)/cycleCount;
  double radius = maxRadius;
  double end = 360;
  double start   = end - thetaDec;
  int cycles = 0;
  int segmentCounter = 0;


  println("->Wheel Type  : " + wheelType);
  println("->Start Radius: " + radius);
  println("->Segments    : " + segments);
  println("->Theta Dec   : " + thetaDec);
  println("->Cycle Count : " + cycleCount);
  println("->Periodicity : " + cyclePeriodicity);
  
  ArrayList<Double> rList = new ArrayList();
  for (int i = table_1.getRowCount()-1; i>=0; i--)
  { 
      TableRow row = table_1.getRow(i);
      
      if(row.getLong(0)>endDate)
        continue;
      if(row.getLong(0)<startDate)
        break;
      
     //Handle 28 OR 29 OR 31 day month
     //Handle Leap Year
     //Not 100% correct but will work for now
       switch(wheelType)
       {
         case 3: //Monthly
         int currentDate = getDayOfMonth(row.getLong(0));
         int currentMonth = getMonthFromTime(row.getLong(0));
         if(currentDate == 31)
           i -= ONE_DAY/288;
         else if(currentMonth == 2)
         {
           if(isALeapYear(row.getLong(0)))
           {
             if(currentDate == 29)
               segmentCounter++;
           }
           else
           {
             if(currentDate == 28)
               segmentCounter+=2;
           }
         }
         break;
         case 4: //Yearly
         if(isALeapYear(row.getLong(0)) && segmentCounter == segments)
           i -= ONE_DAY/288;
         break;
       }
     if(i<0)
       break;
     
      double NOISE = row.getDouble(1);
      fillColor = getColorForNoise(NOISE);
      
      segmentCounter++;
      fill(fillColor);
      stroke(fillColor);
      arc(cx, cy, (float)radius, (float)radius, radians(start), radians(end));
      end = start;
      start -= thetaDec;
      
     if(segmentCounter == segments)
     {
         if(cycles%cyclePeriodicity == 0)
         {
           println("Loss(degrees) = " + end);
           rList.add(radius);
         }

         end = 360;
         start = end - thetaDec;
         radius -= radiusDec;
         segmentCounter = 0;
         cycles++;
     }
     
     
  }
  
  println("finalS          : " + start);
  println("finalE          : " + end);
  println("finalRadius     : " + radius);
  println("final segCount  : " + segmentCounter);
  
  if(segmentCounter!=0)
  {
    noFill();
    stroke(0);
    arc(cx, cy, (float)radius, (float)radius, radians(start), radians(360));
  }
  
  for(double r : rList)
  {
      stroke(color(0,0,0));
      noFill();
      circle(cx,cy,(float)r);
  }
  
  
  drawMarkersOnTheCircumference(maxRadius, endDate, wheelType,segments);
}



void drawMarkersOnTheCircumference(double r, long end, int wheelType, int segments)
{
  
    String[] unit = { "Minute_", "Hour_", "Day_", "Day_", "Day_" };
    double[] ONE_UNIT = { 60.0, 24.0, 7.0, 30.0, 365.0};
    double thetaForOneSegement = 360/ONE_UNIT[wheelType];
    
    double thetaDec = 45;
     
    noFill();
    stroke(color(99,99,255));
    double theta = 360;
    int cx = displayWidth/2;
    int cy = displayHeight/2;
    
    while(theta>0)
    {
        println("[ " + (theta-thetaForOneSegement) + ", " + (theta) + " ]");
        arc(cx, cy, (float)r, (float)r, radians(theta-thetaForOneSegement), radians(theta));
        theta -= thetaDec;
    }
    
    //long timeInc[] = new long[5];
      //end -= timeInc[wheelType];
    //double x1,y1,x2,y2;
    //long ONE_HOUR = 60 * 60;
    //long wheelCircumference[] = { ONE_HOUR, ONE_HOUR*24,ONE_HOUR*24*7, ONE_HOUR*24*30,ONE_HOUR*24*365};
    //for(int i = 0; i<5; i++)
    //  timeInc[i] = wheelCircumference[i]/4;
    //int hTextAlign[] = { LEFT, CENTER, RIGHT, CENTER, LEFT};
    //int vTextAlign[] = {TOP, TOP, CENTER, BOTTOM, BOTTOM};
        //x1 = cx + r * cos(radians(theta));
        //y1 = cy + r * sin(radians(theta));
        //textAlign(hTextAlign[i], vTextAlign[i]);
        //textSize(17);
        //text("   " + getDateString(end) + "   ", x1, y1);
    //int buffer = 10;
    //x1 = cx + r * cos(radians(0)) + buffer;
    //y1 = cy + r * sin(radians(0));
    //x2 = cx + r * cos(radians(180)) - buffer;
    //y2 = cy + r * sin(radians(180));
    //line(x1, y1, x2, y2);
    //x1 = cx + r * cos(radians(90));
    //y1 = cy + r * sin(radians(90)) + buffer;
    //x2 = cx + r * cos(radians(270));
    //y2 = cy + r * sin(radians(270)) - buffer;
    //line(x1, y1, x2, y2);
}
