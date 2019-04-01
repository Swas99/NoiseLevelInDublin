import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;



class NoiseTimeline implements ActionListener
{
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
      
  for(int i = 1; i<=12; i++)
    selectedLocations[i] = false;
  selectedLocations[1] = true;
  
      l1 = new JLabel("From Date: " + getDateString(MIN));
      l2 = new JLabel("To Date: " + getDateString(MAX));
       
      b1 = new JButton("Process!");
      b2 = new JButton("BACK");
      
      fromSlider = new JSlider(JSlider.HORIZONTAL, MIN, MAX, MIN);      
      toSlider = new JSlider(JSlider.HORIZONTAL, MIN, MAX, MAX);
      toSlider.addChangeListener(cl2);
      fromSlider.addChangeListener(cl1);
      
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
       
      l7.setBounds(35,160,350,35);
      cb1.setBounds(35,185,81,35);
      cb2.setBounds(118,185,81,35);    
      cb3.setBounds(198,185,81,35);  
      cb4.setBounds(278,185,81,35); 
      cb5.setBounds(358,185,81,35);  
      cb6.setBounds(431,185,81,35);
      cb7.setBounds(35,215,81,35);
      cb8.setBounds(118,215,81,35);    
      cb9.setBounds(198,215,81,35);  
      cb10.setBounds(278,215,81,35); 
      cb11.setBounds(358,215,81,35);  
      cb12.setBounds(431,215,81,35);
      cb1.setActionCommand("cb1");            
      cb1.addActionListener(this);
      cb2.setActionCommand("cb2");            
      cb2.addActionListener(this);
      cb3.setActionCommand("cb3");            
      cb3.addActionListener(this);
      cb4.setActionCommand("cb4");            
      cb4.addActionListener(this);
      cb5.setActionCommand("cb5");            
      cb5.addActionListener(this);
      cb6.setActionCommand("cb6");            
      cb6.addActionListener(this);
      cb7.setActionCommand("cb7");            
      cb7.addActionListener(this);
      cb8.setActionCommand("cb8");            
      cb8.addActionListener(this);
      cb9.setActionCommand("cb9");            
      cb9.addActionListener(this);
      cb10.setActionCommand("cb10");            
      cb10.addActionListener(this);
      cb11.setActionCommand("cb11");            
      cb11.addActionListener(this);
      cb12.setActionCommand("cb12");            
      cb12.addActionListener(this); 
      
      b1.setBounds(35,510,350,100);
      b1.setActionCommand("b1");            
      b1.addActionListener(this);
      b2.setBounds(35,450,350,40);
      b2.setActionCommand("b2");            
      b2.addActionListener(this);
      
      
      JLabel l8 = new JLabel("Group By:");
      JRadioButton r1=new JRadioButton("Hour");    
      JRadioButton r2=new JRadioButton("Day");
      JRadioButton r3 =new JRadioButton("Week");
      JRadioButton r4 =new JRadioButton("Month");
      JRadioButton r5 =new JRadioButton("Year");
      l8.setBounds(35,248,300,40);
      r1.setBounds(35,275,80,40);    
      r2.setBounds(118,275,80,40);  
      r3.setBounds(191,275,80,40); 
      r4.setBounds(280,275,80,40);  
      r5.setBounds(371,275,80,40); 
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
      
      
      JRadioButton r6=new JRadioButton("Use Average Noise For Grouping");    
      JRadioButton r7=new JRadioButton("Plot 'group criteria' as an increasing function in Y-axis"); 
      r6.setEnabled(false);
      r7.setSelected(true);
      r6.setBounds(35,330,350,40);    
      r7.setBounds(35,360,350,40);   
      r6.setActionCommand("r6");            
      r6.addActionListener(this);
      r7.setActionCommand("r7");            
      r7.addActionListener(this); 
      
      ButtonGroup bg2=new ButtonGroup();    
      bg2.add(r6);bg2.add(r7);
       
   
      f.getContentPane().removeAll();
      f.add(r6);f.add(r7);f.add(b2);f.add(l7);
      f.add(l1); f.add(l2); f.add(b1);
      f.add(r1);f.add(r2);f.add(r3);f.add(r4);f.add(r5);
      f.add(toSlider); f.add(fromSlider);f.add(l8);
      f.add(cb1);f.add(cb2);f.add(cb3);f.add(cb4);f.add(cb5);f.add(cb11);
      f.add(cb6);f.add(cb7);f.add(cb8);f.add(cb9);f.add(cb10);f.add(cb12);
         
      f.repaint();
  }
  
  
  
  public void actionPerformed(ActionEvent e) {
    
    switch(e.getActionCommand())
    {
      case "b1":
       currentScreen = NOISE_TIMElINE_SCREEN;
       needToDraw = true;
       break;
      case "b2":
       objHome.createHomePage();
       break;
      case "r1":
       groupBy = 0;
       break;
      case "r2":
       groupBy = 1;
       break;
      case "r3":
       groupBy = 2;
       break;
      case "r4":
       groupBy = 3;
       break;
      case "r5":
       groupBy = 4;
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
      case "cb1":
       selectedLocations[1] = !selectedLocations[1];
       break;
      case "cb2":
       selectedLocations[2] = !selectedLocations[2];
       break;
      case "cb3":
       selectedLocations[3] = !selectedLocations[3];
       break;
      case "cb4":
       selectedLocations[4] = !selectedLocations[4];
       break;
      case "cb5":
       selectedLocations[5] = !selectedLocations[5];
       break;
      case "cb6":
       selectedLocations[6] = !selectedLocations[6];
       break;
      case "cb7":
       selectedLocations[7] = !selectedLocations[7];
       break;
      case "cb8":
       selectedLocations[8] = !selectedLocations[8];
       break;
      case "cb9":
       selectedLocations[9] = !selectedLocations[9];
       break;
      case "cb10":
       selectedLocations[10] = !selectedLocations[10];
       break;
      case "cb11":
       selectedLocations[11] = !selectedLocations[11];
       break;
      case "cb12":
       selectedLocations[12] = !selectedLocations[12];
       break;
       
    }
  }
}
 
 
void loadAndDrawDataForTimeline()
{
  
  float x_buffer = 220;
  float y_buffer = 100;
  float x_0 = x_buffer*2;
  float y_0 = y_buffer;
  float x_n = displayWidth - x_buffer;
  float y_n = displayHeight - y_buffer;
  
  int totalLocations = 0;
  for(int i = 1; i<=12; i++)
  {
    if(selectedLocations[i])
      totalLocations++;
  }
  if(totalLocations == 0)
    return;
  
  
  int[] SEGMENTS = {12, 288, 288 * 7, 288 * 30, 288 * 365};
  long dataPointsInSelectedInterval =  getNumberOfPointsInSelectionPeriod(startDate, endDate);
  long segments;
  if(groupBy>-1)
    segments = SEGMENTS[groupBy];
  else
    segments = dataPointsInSelectedInterval;
  
  int totalStripsForOneLocation = (int)Math.ceil(dataPointsInSelectedInterval/(double)segments);
  int totalStrips = totalStripsForOneLocation * totalLocations;
  float stripHeight = (y_n-y_0)/totalStrips;
  float y = y_n;
  float blockWidth = (x_n-x_0)/segments;
  for(int i = 1; i<=12; i++)
  {
    if(!selectedLocations[i])
      continue;
    
    List<Float> noiseData = new ArrayList();  
    long currentTime = 0;
    long segmentCounter = 0;
    float yStart_group = y;
    Table table_1 = loadTable("data_" + i, "csv");
    for (int j = 0; j<table_1.getRowCount(); j++)
    { 
        TableRow row = table_1.getRow(j);
        currentTime = row.getLong(0);
        if(currentTime<startDate)
          continue;
        if(currentTime>endDate)
          break;
        
        noiseData.add(row.getFloat(1));
        segmentCounter++;
        if(segmentCounter == segments)
        {
            segmentCounter=0;
            drawStrip(x_0,y,x_n,y,stripHeight,blockWidth, noiseData);
            noiseData.clear();
            y -= stripHeight;
        }
    }
    if(segmentCounter != 0)
    {
        segmentCounter=0;
        drawStrip(x_0,y,x_n,y,stripHeight, blockWidth, noiseData);
        noiseData.clear();
        y -= stripHeight;
    }
    
    
    //Draw Location Label
    fill(color(0));
    stroke(color(0));
    line(x_0-18, y, x_n + 40, y);
    float rectHeight = (y_n-y_0)/totalLocations -16;
    rect( x_n +8, y+8, 10, rectHeight);
    
    textAlign(LEFT, CENTER);
    drawAxis((x_n +8), (y+y+rectHeight + 16)/2, x_n + 40, (y+y+rectHeight+16)/2,true,1,1, locNames[i]);
    
    //Draw Group Labels
    drawGroupLabel(yStart_group, y, x_0,stripHeight, totalStripsForOneLocation);
  }
  
  
  
  drawXAxisLabels(x_0, y_n, x_n, y_n, startDate, segments);
  drawAxis(x_0,y_n,x_n+45,y_n,true,17,8,"time");
  drawAxis(x_0,y_n,x_0,y_0-45,false,1,1,"Time-Groups");
  drawAxis(x_n,y_n,x_n,y_0-45,false,0,0,"locations");
   
  drawMetaDataForTimeLine();
}


void drawMetaDataForTimeLine()
{
  textSize(17);
  textAlign(LEFT,CENTER);
  fill(color(0));
  stroke(fillColor);
  
  String line_1 = "NOISE DATA: timeline";
  String line_2 = "From Date : " + getDateString(startDate);
  String line_3 = "To Date   : " + getDateString(endDate);
  text(line_1, 44, displayHeight - 190);
  text(line_2, 44, displayHeight - 170);
  text(line_3, 44, displayHeight - 150);
}

void drawXAxisLabels(float x1, float y1,float x2, float y2, long start, long segments)
{  
    long end = start + segments*FIVE_MIN;
    long mid = (start + end)/2;
    float x_mid = (x1 + x2)/2;
    float y_mid = (y1 + y2)/2;
    
    textAlign(CENTER,TOP);
    
    line(x1, y1, x1, y1 + 20);
    text(getDateString(start), x1, y1 + 20);
    
    line(x_mid, y_mid, x_mid, y_mid + 20);
    text(getDateString(mid), x_mid, y_mid + 20);
    
    line(x2, y2, x2, y2 + 20);
    text(getDateString(end), x2, y2 + 20);
}

void drawGroupLabel(float y1, float y2, float x, float stripHeight, int totalStrips)
{
  if(groupBy == -1)
    return;
    
    textAlign(RIGHT,CENTER);
    
    String[] unit =     { "HOUR_", "DAY_", "WEEK_", "MONTH_", "YEAR_" };
    drawAxis(x, y1- stripHeight/2, x-20, y1-stripHeight/2, true, -1,1,unit[groupBy] + "1");
    drawAxis(x, y2+stripHeight/2, x-30, y2+17, true, -1,1, unit[groupBy] + totalStrips);
}

void drawStrip(float x_0,float y_0, float x_n, float y_n, float stripHeight,float blockWidth, List<Float> noiseData)
{
    int dataPoints = noiseData.size();
    float x = x_0;
    float y = y_0;
    float xInc = blockWidth;
    float yInc = (y_n - y_0)/dataPoints;
    for(float noiseItem: noiseData)
    {
        fillColor = getColorForNoise(noiseItem);
        fill(fillColor);
        stroke(fillColor);
        rect(x,y-stripHeight, blockWidth, stripHeight);
        x += xInc;
        y += yInc;
    }
}
