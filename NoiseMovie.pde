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
      
      l1 = new JLabel("From Date: " + getDateString(MIN));
      l2 = new JLabel("To Date: " + getDateString(MAX));
       
      b1 = new JButton("Play!");
      b2 = new JButton("BACK");
      
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
 
