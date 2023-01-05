
import SwiftUI

struct LyricsView: View {
    @State var SongTitle: String
    @State var SongArtist: String
    @State var SongArtwork: Image
    var body: some View {
        ZStack{
            
           Rectangle()
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .foregroundColor(Color("BackgroundColor"))
            Rectangle()
                .foregroundColor(Color("BackgroundColor2"))
                .cornerRadius(50)
                .padding()

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
                    
                    ScrollView {
                        
                        Text(getLyric(SongTitle, SongArtist))
                            .foregroundColor(Color("TextColor2"))
                    }.padding([.top, .leading, .trailing], 40.0).padding(.bottom, 60.0)
//                    .overlay(
//                        
//                        VStack {
//                            Rectangle()
//                                .padding(.bottom, 40.0)
//                                .frame(width: 500, height:100, alignment: .top)
//                                
//                                .opacity(1)
//                                .blur(radius: 5)
//                                .foregroundColor(Color("BackgroundColor"))
//                            Spacer()
//                            
//                        }
//                        
//                        
//                    ).padding(.bottom)
                    
            }
//                .position(CGPoint(x: 210, y: 125))
            
            
            
        }

}
}

struct LyricsView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsView(SongTitle: "Sample Song", SongArtist: "Sample Artist", SongArtwork: Image("disco"))
    }
}
