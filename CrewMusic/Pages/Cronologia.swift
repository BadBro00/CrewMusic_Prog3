
import SwiftUI

struct CronologiaView: View {
	@StateObject var viewModel = StocksViewModel()
	@State var text:String = ""
	@State var songtitle:String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var Listone = ["Blinding Lights","Creep","Pamplona"]
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
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
	var body: some View {
        NavigationView{
            ZStack{
                
                Rectangle()
                    .padding(.top, -20.0)
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(Color("BackgroundColor"))
                VStack{
                    Spacer()
                    List{
                        ForEach(Listone, id: \.self){
                            (item) in
                            Text(item)
                            .buttonStyle(MyNewPrimitiveButtonStyle(color:(Color("BackgroundColor2"))))
                           .listRowBackground(Color("BackgroundColor2"))
                        }.onDelete(perform: { indexSet in
                            self.Listone.remove(atOffsets: indexSet)
                        })
                        }
            
        }.navigationBarItems(leading: btnBack).navigationBarHidden(true)
            }.navigationTitle(Text("Cronologia"))
        }.navigationBarTitle("CRONOLOGIA",displayMode: .inline)
        .foregroundColor(Color("AccentColor2"))
    }
}

struct Stock: Identifiable{
	//La var id è necessaria, UUID è un assegnatore random di quest'ultimi
    var id : Int
	let artistName: String
	let songTitle:String
    let songArt: String
}
class StocksViewModel: ObservableObject{
	//DEFINISCO VALORI "DI BASE" PER L'ARRAY
	@Published var stocks: [Stock] = [
		//Published così che la view possa aggiornarsi e riconfigurarsi ogni volta che l'array cambia
		
        Stock(id: 1, artistName: "RadioHead", songTitle: "Creep",songArt: "disco"),
        Stock(id: 2, artistName: "The Weeknd", songTitle: "BlindingLights",songArt: "disco"),
        Stock(id: 3, artistName: "Fabri Fibra, Massimo Pericolo", songTitle: "Star Wars",songArt: "disco"),
        Stock(id: 4, artistName: "Pop Smoke", songTitle: "Dior",songArt: "disco")
	]
}


struct Button_Previews: PreviewProvider {
    static var previews: some View {
        CronologiaView()
    }
}
