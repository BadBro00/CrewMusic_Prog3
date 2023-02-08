package JAVA;

import java.util.Scanner;
import java.net.URL;
import java.net.URLEncoder;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;

public class retriever {
    private String myHost = "https://api.ksoft.si/";
    private String apiKey = "https://api.ksoft.si/lyrics/search";
    public void retrieve(String apiK,String songName,int Limit){
        String myString = apiK + "?songName=value1&Limit=value2";
        URLConnection connection = new URL(myString).openConnection();
        connection.setRequestProperty("header1", header1);
        connection.setRequestProperty("header2", header2);
        //Get Response  
        InputStream is = connection.getInputStream();
        System.out.println(connection.getContentType());
        String charset = "UTF-8";
        String s = songName;
        // Format query for preventing encoding problems
        String query = String.format("s=%s",URLEncoder.encode(s, charset));
        HttpResponse <JsonNode> response = Unirest.get(host + "?" + query)
            .header("ksoft-host", myHost)
            .header("ksoft-key", apiKey)
            .asJson();
        System.out.println(response.getStatus());
        System.out.println(response.getHeaders().get("Content-Type"));

    }
    public void Retriever(){
        this.apiKey = "https://api.ksoft.si/lyrics/search";
        this.myHost = "https://api.ksoft.si/";
    }
}
