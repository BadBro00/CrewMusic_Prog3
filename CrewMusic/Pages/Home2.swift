
import SwiftUI
import AVKit

struct Home2: View {
    @State var start = false
    @State var to : CGFloat = 0
    @State var count = 0
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var record = false
    // creating instance for recroding...
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    @State var alert = false
    @State private var isActive = false
    @State private var song: Song = Song(id: 0, trackName: "", artistName: "", artworkUrl: "")
    // Fetch Audios...
    @State var audios : [URL] = []
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(Color("BackgroundColor"))
                
                VStack{
                    
                    ZStack{
                        
                        Circle()
                        .trim(from: 0, to: 1)
                            .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        
                        Circle()
                            .trim(from: 0, to: self.to)
                            .stroke(Color("AccentColor2"), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))
                        Button(action: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                self.recorder.stop()
                                self.record.toggle()
                                // updating data for every rcd...
                                self.getAudios()
                                loadData()
                                

                                return
                                    }
                            do{

                                if self.record{

                                    // Already Started Recording means stopping and saving...
                                    
                                    self.recorder.stop()
                                    self.record.toggle()
                                    // updating data for every rcd...
                                    self.getAudios()
                                    loadData()
                                    
                                    return
                                }

                                let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

                                // same file name...
                                // so were updating based on audio count...
                                let filName = url.appendingPathComponent("myRcd\(self.audios.count + 1).m4a")

                                let settings = [

                                    AVFormatIDKey : Int(kAudioFormatMPEG4AAC),
                                    AVSampleRateKey : 12000,
                                    AVNumberOfChannelsKey : 1,
                                    AVEncoderAudioQualityKey : AVAudioQuality.high.rawValue

                                ]

                                self.recorder = try AVAudioRecorder(url: filName, settings: settings)
                                self.recorder.record()
                                self.record.toggle()
                            }
                            catch{

                                print(error.localizedDescription)
                            }
                            
                            if self.count == 6{
                                
                                self.count = 0
                                withAnimation(.default){
                                    
                                    self.to = 0
                                }
                            }
                            self.start.toggle()
                            
                        }) {
                            
                            HStack(spacing: 6){
                                
                                Image("rec")
                               
                            }
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                            .background(Color("BackgroundColor"))
                            
                        }
                        .padding(.vertical, 25)
                    }
                    
                }
                
            }
            NavigationLink( "",
                            destination: CanzoneView(SongTitle: song.trackName, SongArtist: song.artistName, SongArtwork: Image("disco")),
                isActive: $isActive
                )
            
        }
        
        .onAppear(perform: {
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { (_, _) in
            }
        })
        .onReceive(self.time) { (_) in
            
            if self.start{
                
                if self.count != 5{
                    
                    self.count += 1
                    print("ok")
                    
                    withAnimation(.default){
                        
                        self.to = CGFloat(self.count) / 5
                    }
                }
                else{
                
                    self.start.toggle()
                }

            }
            
        }
        
    }
    
    func getAudios(){
 
        do{
 
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
 
            // fetch all data from document directory...
 
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
 
            // updated means remove all old data..
 
            self.audios.removeAll()
 
            for i in result{
 
                self.audios.append(i)
            }
        }
        catch{
 
            print(error.localizedDescription)
        }
    }
 
 
    func audioAppend(url:URL)->String
    {
        do{
            let data = try Data(contentsOf: url)
            return data.base64EncodedString()
        }catch{
 
        }
        return ""
    }
 
    func loadData() {
        guard let url = URL(string: "https://api.audd.io/") else {
            print("Invalid URL")
            return
        }
        let audio = audioAppend(url:audios.last!)
        let bodyData = [
            "api_token": "cea7f9de3db2fd439216997694de69c2",
            "audio" : audio
        ]
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyData)
 
        URLSession.shared.dataTask(with: request) { data, response, error0 in
            if let data = data {
                do{
                    let pippo = try JSONDecoder().decode(Audd.self, from: data)
 
                    dump(pippo)
                   
 
                    var title: String = pippo.result?.title ?? "nil"
                    var artist: String = pippo.result?.artist ?? "nil"
                    var url: String = pippo.result?.appleMusic?.artwork?.url ?? "nil"
                    self.song =   Song(id: 0, trackName: title, artistName: artist, artworkUrl: url)
                    self.isActive.toggle()
                    
//                    ArtworkLoader().loadArtwork(forSong: song) { (image) in
//
//                    }
//                    NavigationLink(
//                        destination: CanzoneView(SongTitle: title, SongArtist: artist, SongArtwork: Image("disco")),
//                        label: {
//                            Text("Navigate")
//                        })
//                    getLyric(title,artist)
 
                } catch{
                    print(error.localizedDescription)
                }
 
            }
 
            // if we're still here it means there was a problem
            print("Fetch failed: \(error0?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    func getLyric(_ track: String, _ artist: String) -> String {
            let apiKeyHappi = "b4a28diOAbg9BnsUZEfjdkH4VhOgE0doeWJYjV3wFv9HpHknCJikslw3"
            let scheme = "https"
            let host = "api.happi.dev"
            let path = "/v1/music"
            let queryItem1 = URLQueryItem(name: "apikey", value: apiKeyHappi)
            let queryItem2 = URLQueryItem(name: "q", value: track + " " + artist)
 
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = path
            urlComponents.queryItems = [queryItem1, queryItem2]
 
            var api_lyrics: String?
            if let url = urlComponents.url{
                print(url)
                do{
                    let data = try Data(contentsOf: url)
                    let tempData = try JSONDecoder().decode(APIResultsSearch.self, from:data)
                    for i in 0..<tempData.result.count {
                        if(tempData.result[i].haslyrics){
                            api_lyrics = tempData.result[i].api_lyrics
                            break
                        }
                    }
                }
                catch{
                    print("Data not found")
                }
            }
            var lyrics_found = ""
            if let api_lyrics_unwrap = api_lyrics {
                let url_lyrics = api_lyrics_unwrap + "?apikey=" + apiKeyHappi
                do{
                    let data = try Data(contentsOf: URL(string: url_lyrics)!)
                    let tempData = try JSONDecoder().decode(APIResultsLyric.self, from:data)
                    lyrics_found = tempData.result.lyrics
 
 
                }
                catch{
                    print("Data not found")
                }
            }
        dump(lyrics_found)
        return lyrics_found
        }
 
    
    
}

struct Home2_Previews: PreviewProvider {
    static var previews: some View {
        Home2()
    }
}
