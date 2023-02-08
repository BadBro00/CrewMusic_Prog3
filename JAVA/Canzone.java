package JAVA;

import java.net.URL;

public class Canzone extends songInterface{
    private String title;
    private String album;
    private String artist;
    private URL songUrl;
    
    Canzone(String ttl, String abm,String ats){
        this.title = ttl;
        this.album = abm;
        this.artist = ats;
    }
    public String getTitle(){
        return this.title;
    }
    public String getAlbum(){
        return  this.album;
    }
    public String getArtist(){
        return this.artist;
    }
    public void setURL(URL url){
        this.songUrl = url;
    }
}
