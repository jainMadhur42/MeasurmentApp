import SwiftUI


struct ContentView<ArContent: View>: View {
    
    @State private var addNewVessel = false
    @Binding var vessels: [LocalVesselInfo]
    var markAsSelected: (String) -> Void
    var insert: (LocalVesselInfo) -> Void
    let injectedView: () -> ArContent
    @State var selectedUUID: UUID = UUID()
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                GeometryReader { reader in
                    Color.green
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                            .ignoresSafeArea()
                    }
                VesselSelectionView(vessels: $vessels
                                    , markAsSelected: markAsSelected
                                    , detailAction: { uuid in
                    NavigationView {
                        MeasurmentList(vesselLoader: CoreDataVesselLoader()
                                       , vesselId: selectedUUID)
                    }
                })
                    .padding(.top)
                    .accentColor(ThemeColor.backGround.theme)
            }
            .navigationTitle("CSMT")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        injectedView()
                    } label: {
                        Image(systemName: "camera.circle")
                            .renderingMode(.template)
                            .foregroundColor(Color.ui.theme)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addNewVessel.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .renderingMode(.template)
                            .foregroundColor(Color.ui.theme)
                    }
                }
            }
            .sheet(isPresented: $addNewVessel) {
                NavigationView {
                    AddVesselInfoView(insert: insert)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction, content: {
                                Button {
                                    addNewVessel.toggle()
                                } label: {
                                    Text("Save")
                                        .foregroundColor(true ? .gray : .green)
                                }
                                .disabled(true)

                            })
                            ToolbarItem(placement: .cancellationAction, content: {
                                Button {
                                    addNewVessel.toggle()
                                } label: {
                                    Text("Cancel")
                                        .foregroundColor(.green)
                                }
                            })
                        }
                }
            }
        }
    }
}
            

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView<Text>(vessels: .constant(LocalVesselLoader.vessels), markAsSelected: { uuid in
            print(uuid)
        }, insert: { _ in print("Insert") }, injectedView: {
            Text("Inject view")
        }, selectedUUID: UUID())
    }
}
