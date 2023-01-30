package JAVA;
import java.net.MalformedURLException;
import java.net.URL;

public class apiUser {
    private URL url;
    private String key;

    private void setKey(String key) {
        this.key = key;
    }
    private void setURL(URL url) {
        this.url = url;
    }

    private void retrieve(URL url, String key) { 
        if(url == null){
            throw new IllegalArgumentException("URL cannot be null");
        }else if(key == null){
            throw new IllegalArgumentException("Key cannot be null");
        }else{
            System.out.println("Retrieving...\n");
            //TODO FETCH
        }
    }

    apiUser(String param_url){
        try {
            this.url = new URL(param_url);
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            System.out.println("Malformed URL: " + param_url);
        }
        this.key = "key";
    }

}
