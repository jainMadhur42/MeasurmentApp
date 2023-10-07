import SwiftUI

let myColor = #colorLiteral(red: 0.02966547571, green: 0.123657383, blue: 0.1941029727, alpha: 1)

struct ContentView: View {
     @State private var navigateToFirstScreen = false
        @State private var navigateToSecondScreen = false
    
    var body: some View {
        NavigationView {
            
            ZStack{
                Color(myColor).ignoresSafeArea(.all)
                VStack{
                   
                     Text("Crowdsourced Bathymetry").font(.title).fontWeight(.bold).foregroundColor(.white)
                        //.position(CGPoint(x: 200.0, y: 50.0))
                     Text("Vessel Offset Measurement Tool").font(.title).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
                        //.position(CGPoint(x: 200.0, y: 150.0))
                   Spacer()
                    
                    Button(action: {
                    self.navigateToFirstScreen = true
                    }) {
                    Text("New Measurement")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                   // .position(x:200,y:370)
                    }
                    Button(action: {
                    self.navigateToSecondScreen = true
                    }) {
                    Text("Load Measurement")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    //.position(x:200,y:450)
                    }
                    Spacer()
                       Image("comitlogodesc").resizable()
                     .aspectRatio(contentMode:.fit)
                    // .position(CGPoint(x: 200.0, y: 500.0))
                     
                   
                    NavigationLink(destination: NewMeasurement(), isActive: $navigateToFirstScreen) {
                     EmptyView()
                     }
                     
                     NavigationLink(destination: LoadMeasurement(), isActive: $navigateToSecondScreen) {
                     EmptyView()
                     }
                    
                }
            }
        }
    }

                
            }
            


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
