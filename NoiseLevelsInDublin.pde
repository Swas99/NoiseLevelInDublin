import javax.swing.*;

HomeUI objHome;
JFrame f= new JFrame("Noise Viz");  


int fillColor;
int backgroundColor;

long startDate = 1356998400; 
long endDate = 1553385600;

int wheelType = 4;
int groupBy = -1;
boolean hideMarkers = false;
int selectedLocationIndex = 1;
boolean useAverageValues = false;
String locNames[] = {"Drumcondra Library_", "Drumcondra Library","Bull Island","Ballyfermot Civic Centre","Ballymun Library","Dublin City Council Rowing Club","Walkinstown Library","Woodstock Gardens","Navan Road","Raheny Library","Irishtown Stadium","Chancery Park","Blessington St. Basin"};
float avgNoiseLevels[] = {-1, 52.73164,50.096222,55.71103,61.510845,54.30555,51.46327,46.688187,54.004524,53.58606,50.208145,60.348946,50.85076};
boolean selectedLocations[] = {true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false};

void setup() {
  
  f.setLayout(null);  
  f.setVisible(true);
  f.setSize((int)(displayWidth/2.69),displayHeight-69);
  
  
  surface.setResizable(true);
  //size(displayWidth, displayHeight);
  
  fullScreen();
  //noLoop();
  //smooth();
  
  objHome = new HomeUI();
  objHome.createHomePage();
}

final int AVERAGE_NOISE_SCREEN = 1;
final int NOISE_WHEEL_SCREEN = 2;
final int NOISE_TIMElINE_SCREEN = 3;
final int NOISE_MOVIE_SCREEN = 4;

int currentScreen = 0;

boolean needToDraw = true;
void draw() { 
  if(!needToDraw)
    return;
    
  backgroundColor = color(#FFFFFF);
  background(backgroundColor);
  switch(currentScreen)
  {
    case AVERAGE_NOISE_SCREEN: 
    drawHeader();
    drawLocationWithAverageValues();
    needToDraw = false;
    break;
    case NOISE_WHEEL_SCREEN:
    drawLegend();
    loadAndDrawDataForWheel();
    needToDraw = false;
    break;
    case NOISE_TIMElINE_SCREEN:
    drawLegend();
    loadAndDrawDataForTimeline();
    needToDraw = false;
    break;
    case NOISE_MOVIE_SCREEN:
    playNoiseMovie();
    break;
  }
}
 

void drawLegend()
{
    float y = 20;
    int i=0;
    textAlign(LEFT,CENTER);
    for(double noise = 20;noise<=115; noise+=0.1)
    {
      fillColor = getColorForNoise(noise);
      fill(fillColor);
      stroke(fillColor);
      
      rect(44,y,20, .3);
      if(i%100 == 0)
      {
        line(44, y, 72, y);
        text((int)noise + " dB", 72, y);
      }
      i++;
      y+=.3;
    }
    
    fillColor = getColorForNoise(-1);
    fill(fillColor);
    stroke(fillColor);
    rect(44,y+10,20, 8);
    line(44, y+14, 72, y+14);
    text("Data Not Available", 72, y+14);
}
