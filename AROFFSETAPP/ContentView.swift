import SwiftUI

let myColor = #colorLiteral(red: 0.02966547571, green: 0.123657383, blue: 0.1941029727, alpha: 1)

struct ContentView: View {
    
    @State private var showNewMeasurment = false
    @State private var showLoadMeasurment = false
    @State private var calculateDistance = false
    @AppStorage(Constants.activeVessel) private var activeVesselInfo = UUID().uuidString
    
    var body: some View {
        NavigationView {
            VStack {
                 Spacer()
                 Text("Crowdsourced Bathymetry")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                   
                 Text("Vessel Offset Measurement Tool")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(activeVesselInfo)
                
                
                Button {
                    showNewMeasurment.toggle()
                } label: {
                    Text("New Measurement")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                Button {
                    showLoadMeasurment.toggle()
                } label: {
                    Text("Load Measurement")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                Button {
                    calculateDistance.toggle()
                } label: {
                    Text("Calculate Distance")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                Image("comitlogodesc")
                    .resizable()
                    .aspectRatio(contentMode:.fit)
                
                
                NavigationLink(destination: ARView()
                               , isActive: $calculateDistance) {
                    EmptyView()
                 }
                 
                 NavigationLink(destination: VesselList(vesselInfoLoader: CoreDataVesselLoader())
                                , isActive: $showLoadMeasurment) {
                     EmptyView()
                 }
            }
            .background(Color(myColor))
            .ignoresSafeArea(.all)
        }
    }
}
            


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
