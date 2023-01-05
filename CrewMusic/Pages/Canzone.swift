

import SwiftUI

struct CanzoneView: View {
    @State private var pushView = false
    @State var SongTitle: String
    @State var SongArtist: String
    @State var SongArtwork: Image
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

    var body: some View {
        ZStack{
            GeometryReader{geometry in
				Image("logoborderless")
					.aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
					.edgesIgnoringSafeArea(.all)
					.blur(radius: 100000)
					.frame(width: geometry.size.width, height: geometry.size.height)
                }.background(Rectangle()
                    .edgesIgnoringSafeArea(.all)
                                .foregroundColor(Color("BackgroundColor")))
            ZStack{
                Image("sample")
                    .resizable()
                    .frame(width: 450, height: 250, alignment: .center)
                    .position(CGPoint(x: 200, y: 125))
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            ZStack{
                Rectangle()
                    .frame(width: 450, height: 200, alignment: .center)
                    .position(CGPoint(x: 200, y: 170))
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .blur(radius: 50)
                    .opacity(0.7)
            }
            ZStack{
                Rectangle()
                    .frame(width: 500, height:200, alignment: .center)
                    .position(CGPoint(x: 200, y: 290))
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .opacity(1)
                    .blur(radius: 20)
                    .foregroundColor(Color("BackgroundColor"))
                    
            }
            VStack{
                VStack {
                    VStack{
                        
                        
//                        ArtworkView(image: SongArtwork)
                        SongArtwork
                        .resizable()
                        .clipShape(Rectangle())
                        .cornerRadius(20.0)
                        .frame(width: 100, height: 100)
                        
                        .overlay(

                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("AccentColor"),lineWidth: 3))
                        .shadow(radius: 10 )
                        .padding(.bottom, 7.0)
                    Text(SongTitle).font(.title).foregroundColor(Color("AccentColor2"))
                        Text(SongArtist).font(.subheadline).foregroundColor(Color("SecondaryTextColor")).padding(.bottom, 15.0)
                    }
                }
                VStack {
                    HStack{
                        
                        HStack {
                            
                            Link(destination: URL(string: songSterrURL(SongTitle, SongArtist))!, label: {
                                InformationButton(imageName: "chitarra", text: "Chords")
                            })
//                            NavigationLink(destination: Chords(SongTitle: SongTitle, SongArtist: SongArtist, SongArtwork: SongArtwork)){
//
//}.onTapGesture {self.pushView.toggle()}
                        }
                        HStack {
                            NavigationLink(destination: ArmonicInfo(SongTitle: SongTitle, SongArtist: SongArtist, SongArtwork: SongArtwork)){
                                                        InformationButton(imageName: "violino", text: "Information")
                            }.onTapGesture {self.pushView.toggle()}
                            
                        }
                    }
                    HStack{
                        HStack {
                            NavigationLink(destination: LyricsView(SongTitle: SongTitle, SongArtist: SongArtist, SongArtwork: SongArtwork)){
                                                        InformationButton(imageName: "microfono", text: "lyrics")
                            }.onTapGesture {self.pushView.toggle()}
                        }
                        HStack {
                            NavigationLink(destination: RelatedSongView(SongTitle: SongTitle, SongArtist: SongArtist, SongArtwork: SongArtwork)){
                                                        InformationButton(imageName: "disco2", text: "Related Songs")
                            }.onTapGesture {self.pushView.toggle()}
        
                            
                        }
                    }
                }
                
            }
            
        }.navigationBarItems(leading: btnBack)
		.navigationBarBackButtonHidden(true)
    }
}


struct CanzoneView_Previews: PreviewProvider {
    static var previews: some View {
        CanzoneView(SongTitle: "SampleSong", SongArtist: "SampleArtist", SongArtwork: Image("disco"))
    }
}
