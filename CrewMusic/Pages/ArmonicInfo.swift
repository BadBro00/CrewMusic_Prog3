
import SwiftUI

struct ArmonicInfo: View {
    @State var SongTitle: String
    @State var SongArtist: String
    @State var SongArtwork: Image
    @State var SongBpm: String = ""
    @State var SongLenght: String = ""
    @State var SongGenre: String = ""
    @State var SongRelease: String = ""
    @State var SongLink: String = ""
    var body: some View {
        ZStack{
            
           Rectangle()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color("BackgroundColor"))
            

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
                    .frame(width: 500, height:150, alignment: .center)
                    .position(CGPoint(x: 200, y: 230))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(1)
                    .blur(radius: 25)
                    .foregroundColor(Color("BackgroundColor"))
                    
            }
            
                VStack{
                    SongArtwork
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Rectangle())
                    .cornerRadius(25.0)
                    .frame(width: 100, height: 100)
                    .overlay(

                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("AccentColor"),lineWidth: 3))
                    .shadow(radius: 10 )
                    .padding()
                Text(SongTitle).font(.title).foregroundColor(Color("AccentColor2"))
                Text(SongArtist).font(.subheadline).foregroundColor(Color("SecondaryTextColor"))
                    VStack {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color("BackgroundColor2"))
                                .cornerRadius(50)
                                .padding()
                            VStack{
                                HStack {
                                    
                                    Text("Bpm:")
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("AccentColor2"))
                                        .padding(.leading, 30.0)
                                        .font(.title)
                                    Text(SongBpm)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("TextColor2"))
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                                    
                                    Spacer()
                                }.padding(1.0)
                                HStack {
                                    
                                    Text("Song Lenght:")
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("AccentColor2"))
                                        .padding(.leading, 30.0)
                                        .font(.title)
                                    Text(SongLenght)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("TextColor2"))
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                                    
                                    Spacer()
                                }.padding(1.0)
                            }.padding(.vertical, 40.0)
                        }
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color("BackgroundColor2"))
                                .cornerRadius(50)
                                .padding()
                            VStack{
                                HStack {
                                    
                                    Text("Genre:")
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("AccentColor2"))
                                        .padding(.leading, 30.0)
                                        .font(.title)
                                    Text(SongGenre)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("TextColor2"))
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                                    
                                    Spacer()
                                }.padding(1.0)
                                HStack {
                                    
                                    Text("Song Release:")
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("AccentColor2"))
                                        .padding(.leading, 30.0)
                                        .font(.title)
                                    Text(SongRelease)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("TextColor2"))
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                                    
                                    
                                    Spacer()
                                }.padding(1.0)
                                HStack {
                                    
                                    Text("Song Link:")
                                        .fontWeight(.medium)
                                        .foregroundColor(Color("AccentColor2"))
                                        .padding(.leading, 30.0)
                                        .font(.title)
                                    Button(action: {
                                        UIApplication.shared.openURL(URL(string: SongLink)!)
                                    }) {
                                        Text("Click to open")
                                            .font(.title)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("TextColor2"))
                                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                                    }
                                    
                                    
                                    
                                    Spacer()
                                }.padding(1.0)
                            }.padding(.vertical, 40.0)
                        }
                        
                    }
                    
            }
//                .position(CGPoint(x: 210, y: 125))
            
            
            
        }
}
}
struct ArmonicInfo_Previews: PreviewProvider {
    static var previews: some View {
        ArmonicInfo(SongTitle: "Sample Song", SongArtist: "Sample Artist", SongArtwork: Image("disco"), SongBpm: "90", SongLenght: "4:30", SongGenre: "Rock", SongRelease: "10/11/1994",SongLink: "www.spotify.com")
    }
}
