//
//  MeasurmentList.swift
//  AROFFSETAPP
//
//  Created by Madhur on 10/10/23.
//

import SwiftUI

struct MeasurmentList: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var vesselLoader: VesselDistanceLoader
    var vesselId: UUID
    @State var vesselDistances: [LocalVesselDistance] = []
    var deletedistance: (UUID) -> Void
    
    var body: some View {
        Group {
            if vesselDistances.count == 0 {
                VStack {
                    Text("No Distances calculated for this vessel")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding(.all)
                }
            } else {
                List(vesselDistances) { vesselDistance in
                    MeasurmentListItem(vesselDistance: vesselDistance)
                        .swipeActions(content: {
                            Button {
                                deletedistance(vesselDistance.id)
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "xmark.bin.circle.fill")
                            }
                            .tint(ThemeColor.deleteColor.color)
                        })
                }
                .padding(.top)
                .background(ThemeColor.backGround.color)
            }
        }
        
        .onAppear() {
            vesselLoader.retrieve(for: vesselId) { result in
                switch result {
                case .success(let distances):
                    self.vesselDistances = distances
                case .failure(let error):
                    print("Error \(error)")
                }
            }
        }
    }
}

struct MeasurmentList_Previews: PreviewProvider {
    static var previews: some View {
        MeasurmentList(vesselLoader: LocalVesselLoader(), vesselId: UUID(), deletedistance: {
            print($0)
        })
    }
}
