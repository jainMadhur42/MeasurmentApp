//
//  MainView.swift
//  AROFFSETAPP
//
//  Created by Madhur on 16/10/23.
//

import SwiftUI

enum ViewState {
    case loading
    case empty
    case completed
    case error(Error)
}

struct MainView: View {
    
    var vesselInfoLoader: VesselInfoLoader
    var vesselDistanceLoader: VesselDistanceLoader
    @State private var addNewVessel = false
    @State var viewState: ViewState = .empty
    @State var isSaveButtonEnable: Bool = false
    @State private var vessels = [LocalVesselInfo]()
    @AppStorage(Constants.activeVessel) private var activeVesselInfo = UUID().uuidString
    
    var body: some View {
        NavigationView {
            Group {
                switch viewState {
                case .loading:
                    Text("Loading")
                case .empty:
                    Button {
                        addNewVessel.toggle()
                    } label: {
                        VStack {
                            Text("No Vessel Present Click Here to Add New vessel")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding(.all)
                            Image(systemName: "plus.circle")
                                .renderingMode(.template)
                                .foregroundColor(Color.ui.theme)
                        }
                    }
                case .completed:
                    VesselList(vessels: $vessels
                               , markAsSelected: { uuid in
                        activeVesselInfo = uuid
                        self.vessels = mapSelection(vessels: self.vessels)
                    })
                case .error(let error):
                    Text("Error occured \(error.localizedDescription)")
                }
            }
            .navigationTitle("CSMT")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        ARView(activeVesselId: UUID(uuidString: activeVesselInfo)!)
                    } label: {
                        Image(systemName: "camera.circle")
                            .renderingMode(.template)
                            .foregroundColor(.green)
                    }
                }
                ToolbarItem {
                    Button {
                        addNewVessel.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .renderingMode(.template)
                            .foregroundColor(.green)
                    }
                }
            }
            .sheet(isPresented: $addNewVessel) {
                NavigationView {
                    AddVesselInfoView(enableSaveButton: $isSaveButtonEnable, insert: insert)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction, content: {
                                Button {
                                    addNewVessel.toggle()
                                    refresh()
                                } label: {
                                    Text("Save")
                                        .foregroundColor(isSaveButtonEnable ? .green : .gray)
                                }
                                .disabled(!isSaveButtonEnable)

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
        .onAppear() {
            refresh()
        }
    }
    
    private func refresh() {
        viewState = .loading
        vesselInfoLoader.retrieve { result in
            switch result {
            case .success(let vessels):
                self.vessels = mapSelection(vessels: vessels)
            case .failure(let error):
                self.viewState = .error(error)
            }
            self.viewState = vessels.isEmpty ? .empty : .completed
        }
    }
    
    private func mapSelection(vessels: [LocalVesselInfo]) -> [LocalVesselInfo] {
        
        return vessels.map {
            LocalVesselInfo(id: $0.id
                            , contactEmail: $0.contactEmail
                            , contactPersonName: $0.contactPersonName
                            , vesselName: $0.vesselName
                            , organisation: $0.organisation
                            , isSelected: activeVesselInfo == $0.id.uuidString)
        }
    }
    
    private func insert(localVesselInfo: LocalVesselInfo) {
        vesselInfoLoader.insert(vesselInfo: localVesselInfo, completion: { result in
            switch result {
            case .success(let uuid):
                activeVesselInfo = uuid.uuidString
            case .failure(let error):
                print("error Occurred \(error)")
            }
            refresh()
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vesselInfoLoader: LocalVesselLoader(), vesselDistanceLoader: LocalVesselLoader())
    }
}
