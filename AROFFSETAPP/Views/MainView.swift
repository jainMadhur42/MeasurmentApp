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
    @State private var howToUse = false
    @State private var viewState: ViewState = .empty
    @State private var isSaveButtonEnable: Bool = false
    @State private var vessels = [LocalVesselInfo]()
    @State private var tempVessel = LocalVesselInfo(id: UUID()
                                            , contactEmail: ""
                                            , contactPersonName: ""
                                            , vesselName: ""
                                            , organisation: "")
    @AppStorage(Constants.activeVessel) private var activeVesselInfo = UUID().uuidString
    
    var body: some View {
        NavigationView {
            Group {
                switch viewState {
                case .loading:
                    Text("Loading...")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.all)
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
                    }, deleteVessel: {
                        vesselInfoLoader.delete(uuid: $0) { error in
                            guard let _ = error else {
                                refresh()
                                activeVesselInfo = self.vessels[0].id.uuidString
                                return
                            }
                        }
                    }, deletedistance: {
                        vesselDistanceLoader.delete(distance: $0) { error in
                            guard let _ = error else {
                                
                                return
                            }
                        }
                    })
                    .padding(.top)
                    .background(ThemeColor.backGround.color)
                case .error(let error):
                    Text("Error occured \(error.localizedDescription)")
                }
            }
            .navigationTitle(
                Text("CSMT")
                
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        ARView2(activeVesselId: $activeVesselInfo
                               , arDelegate: ARDelegate2(activeVesselId: activeVesselInfo)
                               , loader: vesselDistanceLoader)
                    } label: {
                        Image(systemName: "camera.circle")
                            .renderingMode(.template)
                            .foregroundColor(ThemeColor.backGround.color)
                    }
                }
                ToolbarItem {
                    Button {
                        addNewVessel.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                            .renderingMode(.template)
                            .foregroundColor(ThemeColor.backGround.color)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        howToUse.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(ThemeColor.backGround.color)
                    }
                }
            }
            .sheet(isPresented: $addNewVessel) {
                NavigationView {
                    AddVesselInfoView(enableSaveButton: $isSaveButtonEnable
                                      , vesselInfo: $tempVessel
                                      , insert: insert)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction, content: {
                                Button {
                                    insert(localVesselInfo: tempVessel)
                                    addNewVessel.toggle()
                                    refresh()
                                    tempVessel = LocalVesselInfo(id: UUID()
                                                                 , contactEmail: ""
                                                                 , contactPersonName: ""
                                                                 , vesselName: ""
                                                                 , organisation: "")
                                } label: {
                                    Text("Save")
                                        .foregroundColor(isSaveButtonEnable ? ThemeColor.backGround.color : .gray)
                                }
                                .disabled(!isSaveButtonEnable)

                            })
                            ToolbarItem(placement: .cancellationAction, content: {
                                Button {
                                    addNewVessel.toggle()
                                } label: {
                                    Text("Cancel")
                                        .foregroundColor(ThemeColor.backGround.color)
                                }
                            })
                        }
                }
            }
            .sheet(isPresented: $howToUse) {
                HowTo()
            }
        }
        .background(ThemeColor.tint.color)
        .onAppear() {
            
            Theme.navigationBarColors(background: ThemeColor.tint.uiColor)
            
            Theme.tableViewTheme()
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
