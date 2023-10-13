//
//  VesselSelectionView.swift
//  AROFFSETAPP
//
//  Created by Madhur on 12/10/23.
//

import SwiftUI

struct VesselListItemView: View {
    
    var vessel: LocalVesselInfo
    
    @AppStorage(Constants.activeVessel) private var activeVesselInfo = UUID().uuidString
    var isSelected: Bool {
        activeVesselInfo == vessel.id.uuidString
    }
    
    var body: some View {
        Button {
            activeVesselInfo = vessel.id.uuidString
        } label: {
            HStack {
                Text(vessel.vesselName)
                    .fontWeight(.bold)
                    .padding()
                    .cornerRadius(10)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: isSelected ? "checkmark.circle" : "circle")
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
        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct VesselSelectionView<Content: View>: View {
    
    @Binding var vessels: [LocalVesselInfo]
    @ViewBuilder var addNewVesselView: () -> Content
    
    var body: some View {
        ScrollView {
            
            addNewVesselView()
            
            ForEach(vessels) { vessel in
                VesselListItemView(vessel: vessel)
            }
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.all)
        .background(Color(myColor))
    }
    
    
}

struct VesselSelctionView_Previews: PreviewProvider {
    static var previews: some View {
        VesselSelectionView(vessels:
                .constant( LocalVesselLoader.vessels), addNewVesselView: {
                    Text("Hello")
                })
    }
}
