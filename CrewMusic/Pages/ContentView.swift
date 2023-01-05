

import SwiftUI


struct ContentView: View {
    @State private var selection: Int = 0
    @State private var pushView = false
    @ObservedObject var viewModel: SongListViewModel = SongListViewModel()
    init(){
        
        UITableView.appearance().backgroundColor = UIColor.clear
                          UITableViewCell.appearance().backgroundColor = UIColor.clear
        
    }
    
    var body: some View {
            
        TabView(selection: $selection){
            NavigationView{
            ZStack{
                GeometryReader{ geometry in
                }.background(Rectangle()
                 .ignoresSafeArea(.all).foregroundColor(Color("BackgroundColor")))
                HStack {
                    Spacer()
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        NavigationLink(
                        destination : InfoView1())
                        {Image("Info")}
                            .onTapGesture {self.pushView.toggle()}
                            .position(.init(x: 350, y: -90))
                            
                           Spacer()
                    }
                        .padding()
                
                        }
                VStack{
                        GeometryReader{
                            geometry in Image("logo").frame(width: geometry.size.width, height:geometry.size.height)
                                .blur(radius: 100000)
                            Text("Premi per ricerca con audio:").font(.title).foregroundColor(Color("AccentColor2")).position(CGPoint(x: 205, y: 55))
                            NavigationLink(destination: Home2()){
                                Image("logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200, height: 200, alignment: .center)
                                    .shadow( radius: 10, x: 3.0, y: 2.0)
                            }.position(CGPoint(x: 210, y: 200))
                            .navigationBarTitle(self.pushView ? "" : "")
                        }.background(Rectangle()
                                .edgesIgnoringSafeArea(.all)
                                        .foregroundColor(Color("BackgroundColor")))
                }
                VStack{
                    SearchBar(searchTerm: $viewModel.searchTerm)
                    if (viewModel.songs.isEmpty || viewModel.searchTerm.isEmpty) {
                      EmptyStateView()
                    } else {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color("BackgroundColor"))
                                .edgesIgnoringSafeArea(.all)
                            List(viewModel.songs){
                              song in
                              SongView(song: song)
                                
                            }
                            
                        }.background(Color("BackgroundColor"))
                      
                        }
                }
                .padding(.top, 75.0)
               
        }
                
}
                .tabItem {
                    Image(selection == 0 ? "HomeON" : "Home")                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                }.tag(0)
            ZStack{
                GeometryReader{ geometry in
                }.background(Rectangle()
                                .ignoresSafeArea(.all)
                                .foregroundColor(Color("BackgroundColor")))
            }
               CanzoneView(SongTitle: "", SongArtist: "",SongArtwork: Image("disco")).tabItem {
                    ZStack{
                        Image(selection == 1 ? "UltimaRicercaON" : "UltimaRicerca")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                }.tag(1)
            ZStack{
                GeometryReader{ geometry in
                }.background(Rectangle()
                                .ignoresSafeArea(.all)
                                .foregroundColor(Color("BackgroundColor")))
            }
                CronologiaView().tabItem {
                    Image(selection == 2 ? "HistoryON" : "History")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.tag(2)
        }
        .onAppear(){
            print("ciao")
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
