//
//  Function&Class.swift
//  CrewMusic
//
//  Created by Ipavon on 11/04/21.
//

import SwiftUI

struct LastSearch:View {
    var body: some View{
        ZStack{
            GeometryReader{
                geometry in
            }.background(Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(Color("ColoreScuro")))
            Text("CIAO")
        }
    }
}

//struct RicercAudio: View{
//@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//var btnBack : some View {
//        Button(action:{
//            self.presentationMode.wrappedValue.dismiss()}){
//            HStack{
//                Image("Back")
//                    .aspectRatio(contentMode: .fill)
//                    .foregroundColor(.white)
//                Text("Indietro")
//                    .foregroundColor(Color(red: 0.984, green: 0.4, blue: 0.507, opacity: 1.0))
//                }
//            }
//        }
//    var body: some View{
//            ZStack{
//                GeometryReader{
//                    geometry in
//                }.background(Rectangle()
//                                .edgesIgnoringSafeArea(.all)
//                                .foregroundColor(Color("ColoreScuro")))
//                VStack{
//                    Text("Ricerca...").foregroundColor(Color("AccentColor"))
//                    NavigationLink(destination: Search()){
//                        Image("rec")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 150, height: 300, alignment: .center)
//                }.position(CGPoint(x: 210, y: 150))
//            }
//        }
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: btnBack)
//    }
//}

//struct Search : View{
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    var btnBack : some View {
//            Button(action:{
//                self.presentationMode.wrappedValue.dismiss()}){
//                HStack{
//                    Image("Back")
//                        .aspectRatio(contentMode: .fill)
//                        .foregroundColor(.white)
//                    Text("Indietro")
//                        .foregroundColor(Color(red: 0.984, green: 0.4, blue: 0.507, opacity: 1.0))
//                    }
//                }
//            }
//    var body: some View{
//        ZStack{
//            GeometryReader{
//                geometry in
//            }.background(Rectangle()
//                            .edgesIgnoringSafeArea(.all)
//                            .foregroundColor(Color("ColoreScuro")))
//            VStack{
//                NavigationLink(destination: CanzoneView()){
//                    Text("ECCO LA CANZONE: ")
//                        Image("disco2")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 150, height: 300, alignment: .center)
//                }.position(CGPoint(x: 210, y: 150))
//            }
//        }
//        .navigationBarItems(leading: btnBack)
//        .navigationBarBackButtonHidden(true)
//    }
//}

struct SongInfoDisplay:View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var btnBack : some View {
            Button(action:{
                self.presentationMode.wrappedValue.dismiss()}){
                    Image("Back")
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.white)
                    Text("Indietro")
                        .foregroundColor(Color(red: 0.984, green: 0.4, blue: 0.507))
    }
}
    var body: some View{
        NavigationView{
            ZStack{
                GeometryReader{
                    geometry in
                }.background(Rectangle()
                                .edgesIgnoringSafeArea(.all))
                                .foregroundColor(Color("ColoreScuro"))
                VStack{
                    Text("Artist: RadioHead ").foregroundColor(Color("AccentColor"))
                    Text("Title: Creep").foregroundColor(Color("AccentColor"))
                    HStack{
                        Image("disco2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 100, alignment: .center)
                    }
                }.position(CGPoint(x: 210, y: 50))
                }
            }.navigationBarItems(leading: btnBack)
             .navigationBarBackButtonHidden(true)

    }
}

//struct SongView: View {
//    
//  @ObservedObject var song: SongViewModel
//  var body: some View {
//    HStack {
//      ArtworkView(image: song.artwork)
//        .padding(.trailing)
//      VStack(alignment: .leading) {
//        Text(song.trackName).foregroundColor(Color("AccentColor2"))
//        Text(song.artistName).foregroundColor(Color("SecondaryTextColor"))
//          .foregroundColor(Color("BackgroundColor2"))
//        }
//     
//    }
//    .padding()
//  }
//}


struct ArtworkView: View {
  let image: Image?

  var body: some View {
    ZStack {
      if image != nil {
        image
      } else {
        Color(.systemIndigo)
        Image(systemName: "music.note")
          .font(.largeTitle)
          .foregroundColor(.white)
      }
    }
    
  }
}

struct EmptyStateView: View{
    var body: some View{
        VStack{
        }
        .padding(5)
        .foregroundColor(Color(.systemIndigo))
    }
}

struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    @Binding var searchTerm: String
    
    func makeUIView(context: Context) -> UISearchBar {
       
      let searchBar = UISearchBar(frame: .zero)
        let textFieldInsideUISearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideUISearchBar?.textColor = UIColor(Color("AccentColor2"))
      searchBar.delegate = context.coordinator
      searchBar.searchBarStyle = .minimal
      searchBar.placeholder = "Write the song or the artist..."
      searchBar.enablesReturnKeyAutomatically = false
      return searchBar
        
    }
    func updateUIView(_ uiView: UISearchBar, context: Context) {
    }
    func makeCoordinator() -> SearchBarCoordinator {
      return SearchBarCoordinator(searchTerm: $searchTerm)
    }

    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
      @Binding var searchTerm: String
      init(searchTerm: Binding<String>) {
        self._searchTerm = searchTerm
      }
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text ?? ""
        UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
        }
    }
}

struct SongView: View {
    @State private var pushView = false
    @ObservedObject var song: SongViewModel
    var body: some View{
        
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("BackgroundColor2"))
                NavigationLink(
                    destination : CanzoneView(SongTitle: song.trackName, SongArtist: song.artistName, SongArtwork: song.artwork ?? Image("disco"))){
                    
                    ZStack {
                        HStack{
                            
                            HStack {
                                ArtworkView(image: song.artwork)
                                    .clipShape(Rectangle())
                                    .cornerRadius(25.0)
                                    .frame(width:  75, height: 75)
                                    .overlay(

                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color("AccentColor"),lineWidth: 3))
                                    
                            }.padding()
                            HStack {
                                VStack(alignment: .center){
                                    
                                    Text(song.trackName).font(.title).foregroundColor(Color("AccentColor2"))
                                    Text(song.artistName).font(.headline).foregroundColor(Color("SecondaryTextColor"))
                                }
                            }.padding(5)
                        }
                    }
            }
                    .onTapGesture {self.pushView.toggle()}
            
            
        }
        
        
        
            
    
        
        
    }
}

struct MusicButton: View {
    let imageName: String
    let ArtistName: String
    let SongName: String
    
    var body: some View{
        
        

        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color("BackgroundColor2"))
            HStack{

                HStack {
                    Image("disco")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Rectangle())
                        .cornerRadius(25.0)
                        .frame(width:  75, height: 75)
                        .overlay(

                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color("AccentColor"),lineWidth: 3))

                }.padding()
                HStack {
                    VStack(alignment: .center){
                        Text(ArtistName).font(.title).foregroundColor(Color("AccentColor2"))
                        Text(SongName).font(.headline).foregroundColor(Color("SecondaryTextColor"))
                    }
                }.padding(5)
                HStack() {
                    Spacer()
                    Image("trash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                }.padding()
            }
        }

    }
}

struct CircularButton: View {
    var imageName: String
    @Binding var mainImage: String
    @Binding var mainLabel: String
    var defaultName: String
    var teamMember: String
    var body: some View {
        Button(action: {
            if (self.mainImage != self.imageName){
                self.mainImage = self.imageName
                self.mainLabel = self.teamMember
            }else{
                self.mainImage = self.defaultName
                self.mainLabel = ""
            }
        }){Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .shadow(radius: 10 )
            .onCondition(imageName == mainImage, addModifiers: {
                $0.overlay(
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 50))
                    .foregroundColor(Color("AccentColor2"))
                )
            })
        }
                }
}

struct MenuView : View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body : some View {
        Text("")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image("Back")
            })
    }
}

struct InformationButton: View{
    var imageName: String
    var text: String
    var body: some View{
        Rectangle()
            .frame(width: 150, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundColor(/*@START_MENU_TOKEN@*/Color("BackgroundColor2")/*@END_MENU_TOKEN@*/)
            .cornerRadius(20)
            .padding()
            .shadow(radius: 30 )
            .overlay(
        ButtonOverlay(imageName: imageName, text: text)
        )
    }
}

struct ButtonOverlay : View{
    var imageName: String
    var text: String
    var body: some View{
        VStack{
            
            VStack {
                Image(imageName)
                    .frame(width: 75, height: 75)
            }
            
            VStack {
                Text(text)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .font(.title2)
                    .foregroundColor(Color("AccentColor2"))
            }
            VStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color("AccentColor"))
                    .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Image("arrowRight")
                )
            }
                
        }.frame(width: 150, height: 175)
    }
    
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

//func getRelatedSongs(_ idArtist: String) -> String {
//        let apiKeyHappi = "b4a28diOAbg9BnsUZEfjdkH4VhOgE0doeWJYjV3wFv9HpHknCJikslw3"
//        let scheme = "https"
//        let host = "api.happi.dev"
//        let path = "/v1/music/artists/" + idArtist +"/smart-playlist"
//        let queryItem1 = URLQueryItem(name: "apikey", value: apiKeyHappi)
//        
//        var urlComponents = URLComponents()
//        urlComponents.scheme = scheme
//        urlComponents.host = host
//        urlComponents.path = path
//        urlComponents.queryItems = [queryItem1]
//        
//        var api_lyrics: String?
//        if let url = urlComponents.url{
//            print(url)
//            do{
//                let data = try Data(contentsOf: url)
//                let tempData = try JSONDecoder().decode(APIResultsSearch.self, from:data)
//                for i in 0..<tempData.result.count {
//                    if(tempData.result[i].haslyrics){
//                        api_lyrics = tempData.result[i].api_lyrics
//                        break
//                    }
//                }
//            }
//            catch{
//                print("Data not found")
//            }
//        }
//        var lyrics_found = ""
//        if let api_lyrics_unwrap = api_lyrics {
//            let url_lyrics = api_lyrics_unwrap + "?apikey=" + apiKeyHappi
//            do{
//                let data = try Data(contentsOf: URL(string: url_lyrics)!)
//                let tempData = try JSONDecoder().decode(APIResultsLyric.self, from:data)
//                lyrics_found = tempData.result.lyrics
//                
//                
//            }
//            catch{
//                print("Data not found")
//            }
//        }
//    dump(lyrics_found)
//    return lyrics_found
//    }


extension View{
    @ViewBuilder func onCondition<T>(_ condition: Bool, addModifiers:
    (Self)->T)-> some View
    where T : View{
        if condition{
            addModifiers(self)
        }else{
            self
        }
    }
}

func getRelatedSong(_ id_artist: String){
       let apiKeyHappi = "b4a28diOAbg9BnsUZEfjdkH4VhOgE0doeWJYjV3wFv9HpHknCJikslw3"

       let scheme = "https"
       let host = "api.happi.dev"
       let path = "/v1/music/artists/\(id_artist)/smart-playlist"

       let queryItem1 = URLQueryItem(name: "apikey", value: apiKeyHappi)

       var urlComponents = URLComponents()
       urlComponents.scheme = scheme
       urlComponents.host = host
       urlComponents.path = path
       urlComponents.queryItems = [queryItem1]

       if let url = urlComponents.url{
           print(url)
           do{
               let data = try Data(contentsOf: url)
               let tempData = try JSONDecoder().decode(APIResultsSearch.self, from:data)
//                for item in 1...5{
//                    let artist = item["artist"] as! String
//                    print(artist)
//                }

           }
           catch{
               print("Data not found")
           }
       }

   }

struct MyNewPrimitiveButtonStyle: PrimitiveButtonStyle {
    var color: Color

    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, color: color)
    }
   
    struct MyButton: View {
        @State private var pressed = false

        let configuration: PrimitiveButtonStyle.Configuration
        let color: Color

        var body: some View {

            return configuration.label
                .foregroundColor(.white)
                .padding(15)
                .background(RoundedRectangle(cornerRadius: 5).fill(color))
                .compositingGroup()
                .shadow(color: .black, radius: 3)
                .opacity(self.pressed ? 0.5 : 1.0)
                .scaleEffect(self.pressed ? 0.8 : 1.0)
                .onLongPressGesture(minimumDuration: 2.5, maximumDistance: .infinity, pressing: { pressing in
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.pressed = pressing
                }
                if pressing {
                    print("My long pressed starts")
                    print("I can initiate any action on start")
                } else {
                    print("My long pressed ends")
                    print("I can initiate any action on end")
                }
            }, perform: { })
        }
    }
}

func songSterrURL(_ track: String, _ artist: String) -> String {
        var finalURL : String
        finalURL = "http://www.songsterr.com/a/wa/bestMatchForQueryString?s=" + "\(track)" + "&a=" + "\(artist)" + "&track=bass"
        
        return finalURL
    }
//func convertURL(_ urlImage: String)-> Image{
//    let url = URL(string:"\(urlImage)")
//    if let data = try? Data(contentsOf: url!)
//    {
//        let image: UIImage = UIImage(data: data) ?? Image("disco")
//        return image
//    }
//    
//}
//struct Button_Previews: PreviewProvider {
//    static var previews: some View {
//       InformationButton(imageName: "violino", text: "info")
//    }
//}

