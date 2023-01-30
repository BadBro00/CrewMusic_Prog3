package JAVA;

import java.util.ArrayList;

public class Home{
    public static void main(String args[]) {
        Canzone A = new Canzone("a","a","a");
        Canzone B = new Canzone("b","b","b");
        Canzone C = new Canzone("c","c","c");
        ArrayList<Canzone> arrayofSongs = new ArrayList<Canzone>();
        arrayofSongs.add(A);
        arrayofSongs.add(B);
        arrayofSongs.add(C);

        for(Canzone song : arrayofSongs){
            System.out.println("CANZONE: " + song.getTitle() + ", ARTISTA: " + song.getArtist() + ", DALL'ALBUM: " + song.getAlbum() + "\n");
        }
    }
}
