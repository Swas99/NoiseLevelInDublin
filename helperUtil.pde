import java.util.*;

long ONE_DAY = 24 * 60 * 60;

public static String getDateString(long time)
{
      Date date=new Date(time*1000);
      java.text.SimpleDateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
      df2.setTimeZone(TimeZone.getTimeZone("GMT"));
      return df2.format(date);
}

float radians(double deg)
{
  return (float)(deg * 22.0 / 180.0 / 7.0);
}

color getColorForNoise(double noise)
{
  if(noise == -1)
    return color(#FF6DE6);
    
  color rangeColors[] = 
  {
    color(#135629), //LOWER BOUND
    color(#197035), //0-34.99
    color(#238543), //35-39.99
    color(#78C679), //40-44.99
    color(#C2E69A), //45-49.99
    color(#FFFFB2), //50-55.99
    color(#FECC5C), //55-59.99
    color(#FD8E3C), //60-64.99
    color(#FF0909), //65-69.99
    color(#B30622), //70-74.99
    color(#67033B), //75-79.99
    color(#1C0054), //80+
    color(#000000), //UPPER BOUND
  };
  int toColor = 0;
  if(noise<35)
    toColor = 1;
  else if(noise<40)
    toColor = 2;
  else if(noise<45)
    toColor = 3;
  else if(noise<50)
    toColor = 4;
  else if(noise<55)
    toColor = 5;
  else if(noise<60)
    toColor = 6;
  else if(noise<65)
    toColor = 7;
  else if(noise<70)
    toColor = 8;
  else if(noise<75)
    toColor = 9;
  else if(noise<80)
    toColor = 10;
  else
    toColor = 11;
  
  float mixer = (float)getMixerValue(noise);
  
  //println( lerpColor(rangeColors[toColor-1], rangeColors[toColor], mixer));
  return lerpColor(rangeColors[toColor-1], rangeColors[toColor], mixer);
}

double getMixerValue(double val)
{
    if(val<35)
    {
      return val/35.0;
    }
    
    if(val>80)
    {
      return (140 -val)/60.0;
    }
    
    int intVal = (int)val;
    intVal -= intVal%5;
    
    return (val-intVal)/5.0;
}

double getCycleCount(long start, long end, int wheelType)
{
  double[] SEGMENTS = {12.0, 288.0, 288.0 * 7, 288.0 * 30, 288.0 * 365};
  long numOfDataPoints = getNumberOfPointsInSelectionPeriod(start, end);
  return numOfDataPoints/SEGMENTS[wheelType];
}
boolean isALeapYear(long time)
{
    Date date=new Date(time*1000);
    java.text.SimpleDateFormat df2 = new java.text.SimpleDateFormat("yyyy");
    df2.setTimeZone(TimeZone.getTimeZone("GMT"));
    String year = df2.format(date);
    int intYear = Integer.parseInt(year);
    return (intYear % 100 == 0) ? (intYear % 400 == 0) : (intYear % 4 == 0);
}

int getDaysInMonth(long time)
{
    Date date=new Date(time*1000);
    java.text.SimpleDateFormat df2 = new java.text.SimpleDateFormat("MM");
    df2.setTimeZone(TimeZone.getTimeZone("GMT"));
    String month = df2.format(date);
    int intMonth = Integer.parseInt(month);
    int daysInMonth [] = { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    return daysInMonth[intMonth];
}

int getMonthFromTime(long time)
{
    Date date=new Date(time*1000);
    java.text.SimpleDateFormat df2 = new java.text.SimpleDateFormat("MM");
    df2.setTimeZone(TimeZone.getTimeZone("GMT"));
    String month = df2.format(date);
    return Integer.parseInt(month);
}

int getDayOfMonth(long time)
{
    Date date=new Date(time*1000);
    java.text.SimpleDateFormat df2 = new java.text.SimpleDateFormat("dd");
    df2.setTimeZone(TimeZone.getTimeZone("GMT"));
    String dayOfMonth = df2.format(date);
    return Integer.parseInt(dayOfMonth);
}

long getNumberOfPointsInSelectionPeriod(long start, long end)
{
  long FIVE_MIN = 5 * 60;
  return (end-start)/FIVE_MIN;
}
  
float computeAverageNoise(int loc, long start, long end)
{
  Table table;
  String dataFile = "data_" + loc;
  table = loadTable(dataFile, "csv");
  float noise = 0;
  float count = 0;
  for(TableRow row : table.rows())
  {
    long _time = row.getLong(0);
    if(start<=_time && end>=_time)
    {
      float _noise = row.getFloat(1);
      if(_noise >0)
      {
        noise += _noise;
        count++;
      }
    }
    else if(_time>end)
      break;
  }
  println("Location = " + locNames[loc]);
  println("Total Noise = " + noise);
  println("Total Rows = " + count);
  println("Start : End = " + start + " : " + end );
  println("Average Noise = " + noise/count);
  println();
  return noise/count;
}
