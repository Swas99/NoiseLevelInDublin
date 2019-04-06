package hacker_rank;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.util.*;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONArray; //Add org.json to dependency OR download and add jar 
import org.json.JSONObject;


class DVNoiseExp
{
 
    public static void main (String[] args) throws java.lang.Exception
    {
        DVNoiseExp objCodeChef = new DVNoiseExp();
        objCodeChef.solve();
    }

    StringBuilder out;
    long _MIN = 1356998400;
    long _MAX = 1553385600;
    final long FIVE_MIN = 60 * 5;
	HashMap<Long, String> map = new HashMap<Long, String>();
    public void solve() throws Exception
    {
    	makeReq(1,_MIN);
    }
    
    private void makeReq(int i, long day) throws Exception
    {
        long ONE_DAY = 24 * 60 * 60;
        if(day == _MAX)
        {
        	saveDataForLoc(i);
            i++;
            day = _MIN;
        }
        if(i == 13)
        {
            System.out.println("____________DONE____________");
            return;
        }

        String BASE_URL = "http://dublincitynoise.sonitussystems.com/applications/api/dublinnoisedata.php?location=%d&start=%d&end=%d";
        String url = String.format(Locale.ENGLISH,BASE_URL,i,day,day);
//        System.out.println("Noise_REQ_URL      = " + url);
        long finalDay = day;
        int finalI = i;

//		System.out.println("LOCATION\tDAY");
//		System.out.println(String.format("%d\t%d", i, finalDay));
		
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("GET");
		int responseCode = con.getResponseCode();
		if (responseCode == HttpURLConnection.HTTP_OK) { // success
			BufferedReader in = new BufferedReader(new InputStreamReader(
					con.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
			
			saveData(response.toString(), finalI, finalDay);
		} 
		else 
		{
			System.out.println("GET request did not work");
		}
		con.disconnect();
		con = null;
		makeReq(finalI, finalDay + ONE_DAY);
    }

	private void saveDataForLoc(int loc) throws Exception {

    	String outFile = "C:\\Users\\Swastik\\Desktop\\MastersDegree_CS\\Semester_2\\DataVisualization\\ass_4\\data_";
        BufferedWriter writer = new BufferedWriter(new FileWriter(outFile + loc));

    	long s = _MIN;
		while(s < _MAX)
		{
			if(!map.containsKey(s))
				map.put(s, "-1");
			s += FIVE_MIN;
		}
    	List<Long> sortedKeys = new ArrayList<Long>(map.size());
    	sortedKeys.addAll(map.keySet());
    	Collections.sort(sortedKeys);
    	
    	s = _MIN;
    	for(long key : sortedKeys)
    	{
    		if(key!=s)
    		{
    			System.out.println(key); //ISSUE!! 
    			break;
    		}
    		writer.append(String.format("%d,%s\n", key,map.get(key)));
    		s+=FIVE_MIN;
    	}
    	System.out.println(map.size());
    	map.clear();
    	writer.close();
	}

	private void saveData(String response, int loc, long l_day) {
		try
		{
			JSONObject jsonObj = new JSONObject(response);
			JSONArray day = jsonObj.getJSONArray("dates");
			JSONArray time = jsonObj.getJSONArray("times");
			JSONArray noise =jsonObj.getJSONArray("aleq");
			
			long itemTime = 0;
			for(int i = 0; i<day.length(); i++)
			{
				itemTime = getSeconds(day.getString(i),time.getString(i));
				map.put(itemTime, noise.getString(i));
			}
		}catch(Exception e)//No Data for this day
		{
//			System.out.println("xx" + e.getMessage()); 
		}
	}
	
	public static long getSeconds(String date, String time) throws Exception
	{
		String temp[] = time.split(":");
		int min = Integer.parseInt(temp[1]);
		min -= min%5;
		if(min<10)
			time = temp[0] + ":0" + min + ":" + temp[2];
		else
			time = temp[0] + ":" + min + ":" + temp[2];
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
		return sdf.parse(date + " " + time).getTime() / 1000;
	}
 
	public static String getDateString(long time)
	{
        Date date=new Date(time*1000);
        java.text.SimpleDateFormat df2 = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        df2.setTimeZone(TimeZone.getTimeZone("GMT"));
        return df2.format(date);
	}
 
}
