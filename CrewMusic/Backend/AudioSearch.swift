import SwiftUI
import AVKit
 
 
struct AudioSearch : View {
 
    @State var record = false
    // creating instance for recroding...
    @State var session : AVAudioSession!
    @State var recorder : AVAudioRecorder!
    @State var alert = false
 
 
    // Fetch Audios...
    @State var audios : [URL] = []
 
    var body: some View{
 
        NavigationView{
 
            VStack{
 
                List(self.audios,id: \.self){i in
 
                    // printing only file name...
 
                    Text(i.relativeString)
                }
 
//                List(results, id: \.trackId) { item in
//                    VStack(alignment: .leading) {
//                        Text(item.trackName)
//                            .font(.headline)
//                        Text(item.collectionName)
//                    }
//                }
 
 
 
                Button(action: {
 
                    // Now going to record audio...
 
                    // Intialization...
 
                    // Were going to store audio in document directory...
 
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
 
 
                }) {
 
                    ZStack{
 
                        Circle()
                            .fill(Color.red)
                            .frame(width: 70, height: 70)
 
                        if self.record{
 
                            Circle()
                                .stroke(Color.white, lineWidth: 6)
                                .frame(width: 85, height: 85)
                        }
                    }
                }
                .padding(.vertical, 25)
            }
            .navigationBarTitle("Record Audio")
        }
        .alert(isPresented: self.$alert, content: {
 
            Alert(title: Text("Error"), message: Text("Enable Access"))
        })
        .onAppear {
 
            do{
 
                // Intializing...
 
                self.session = AVAudioSession.sharedInstance()
                try self.session.setCategory(.playAndRecord)
 
                // requesting permission
                // for this we require microphone usage description in info.plist...
                self.session.requestRecordPermission { (status) in
 
                    if !status{
 
                        // error msg...
                        self.alert.toggle()
                    }
                    else{
 
                        // if permission granted means fetching all data...
 
                        self.getAudios()
 
                    }
                }
            }
            catch{
 
                print(error.localizedDescription)
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
 
                    getLyric(title,artist)
 
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


struct AudioSearch_Previews: PreviewProvider {
    static var previews: some View {
        AudioSearch()
    }
}
