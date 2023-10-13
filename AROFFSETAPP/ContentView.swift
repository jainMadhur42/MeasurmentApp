import SwiftUI

let myColor = #colorLiteral(red: 0.02966547571, green: 0.123657383, blue: 0.1941029727, alpha: 1)

struct ContentView: View {
    
    @State private var showNewMeasurment = false
    @State private var addNewVessel = false
    @State private var showLoadMeasurment = false
    @State private var calculateDistance = false
    @State private var vessels = [LocalVesselInfo]()
    
    var vesselInfoLoader: VesselInfoLoader
    
    @AppStorage(Constants.activeVessel) private var activeVesselInfo = UUID().uuidString
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack(spacing: 8) {
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
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                Spacer()
                VStack {
                    
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
                    
                    NavigationLink(destination: ARView()
                                   , isActive: $calculateDistance) {
                        EmptyView()
                     }
                     
                     NavigationLink(destination: VesselList(vesselInfoLoader: CoreDataVesselLoader())
                                    , isActive: $showLoadMeasurment) {
                         EmptyView()
                     }
                   
                }
                Spacer()

                Image("comitlogodesc")
                    .resizable()
                    .aspectRatio(contentMode:.fit)
            }
            
            .background(Color(myColor))
            .ignoresSafeArea(.all)
            .toolbar {
                ToolbarItem {
                    Button {
                        addNewVessel.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                        
                    }

                }
            }
            .sheet(isPresented: $addNewVessel) {
                VesselSelectionView(vessels: $vessels) {
                    createBorderedButton(with: "Add New Vessel", image: "plus.circle")
                }
            }
            .sheet(isPresented: $showNewMeasurment) {
                MetaData(vesselInfoLoader: vesselInfoLoader)
            }
        }
        .onAppear() {
            vesselInfoLoader.retrieve { result in
                switch result {
                case .success(let vessels):
                    self.vessels = vessels
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @ViewBuilder func createBorderedButton(with text: String, image systemName: String) -> some View {
        Button {
            addNewVessel.toggle()
            showNewMeasurment.toggle()
        } label: {
            HStack {
                Text(text)
                    .fontWeight(.bold)
                    .padding()
                    .cornerRadius(10)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(.white)
                Image(systemName: systemName)
                    .foregroundColor(.green)
                    .padding(.all)
            }
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.green, lineWidth: 2)
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .fixedSize(horizontal: false, vertical: true)
    }
}
            


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vesselInfoLoader: LocalVesselLoader())
    }
}
