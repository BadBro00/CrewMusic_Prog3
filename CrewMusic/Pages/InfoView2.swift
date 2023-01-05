
import Foundation
import SwiftUI

struct InfoView2: View {
    @State private var mainImageName = "parthenope"
    @State private var mainImageLabel = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    init (){
        let standardAppearance = UITabBarAppearance()
        
        standardAppearance.backgroundColor = UIColor(named: "BackgroundColor2")
        
        UITabBar.appearance().standardAppearance = standardAppearance
    }
    let defaultImage = "parthenope"
    var body: some View {
        ZStack{
            GeometryReader{ geometry in
            }.background(Rectangle()
                            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color("BackgroundColor")))
            GeometryReader{ geometry in
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea([.top,.bottom])
                    .opacity(0.3)
                    .blur(radius: 3)
                    .frame(width: geometry.size.width)
            }
            Text("")
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action : {
                    self.mode.wrappedValue.dismiss()
                }){
                    Image("Back")
                })
            VStack{
                Text("Parthenope team")
                    .fontWeight(.bold)
                    .foregroundColor(Color("AccentColor2"))
                    .font(.system(size:30))
                    .shadow(radius: 6, x: 10, y: 6 )
                Image(mainImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8.0)
                    .padding(10)
                    .overlay(
                        Text(mainImageLabel)
                            .fontWeight(.bold)
                            .padding()
                            .shadow(radius: 10 )
                            .foregroundColor(Color("AccentColor2"))
                            .font(.title),
                        alignment: .bottom)
                HStack{
                    CircularButton(imageName: "ciaramella", mainImage: $mainImageName,mainLabel: $mainImageLabel, defaultName: defaultImage,teamMember: "Angelo Ciaramella")
                    CircularButton(imageName: "agliata", mainImage: $mainImageName,mainLabel: $mainImageLabel, defaultName: defaultImage,teamMember: "Antonio Agliata")
                    CircularButton(imageName: "dicapua", mainImage: $mainImageName,mainLabel: $mainImageLabel, defaultName: defaultImage,teamMember: "Michele Di Capua")
                        
                }
                HStack{
                    CircularButton(imageName: "dinardo", mainImage: $mainImageName,mainLabel: $mainImageLabel, defaultName: defaultImage,teamMember: "Manuel Di Nardo")
                    CircularButton(imageName: "finizio", mainImage: $mainImageName,mainLabel: $mainImageLabel, defaultName: defaultImage,teamMember: "Ignazio Finizio")
                    CircularButton(imageName: "napolitano", mainImage: $mainImageName,mainLabel: $mainImageLabel, defaultName: defaultImage,teamMember: "Nunzio Napolitano")
                }.padding()
            }
        }
    }
}

struct InfoView2_Previews: PreviewProvider {
    static var previews: some View {
        InfoView2()
    }
}
