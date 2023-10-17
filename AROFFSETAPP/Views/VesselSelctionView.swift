//
//  VesselSelectionView.swift
//  AROFFSETAPP
//
//  Created by Madhur on 12/10/23.
//

import SwiftUI

struct VesselListItemView: View {
    
    var vessel: LocalVesselInfo
    var markAsSelected: (String) -> Void
    @State var showVesselDistance = false
    var detailAction: (UUID) -> Void
    
    var body: some View {
        Button {
            markAsSelected(vessel.id.uuidString)
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
                Image(systemName: "checkmark.circle")
                    .opacity(vessel.isSelected ? 1.0 : 0.0)
                    .foregroundColor(ThemeColor.tint.color)
                    .padding(.all)
            }
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(ThemeColor.tint.color, lineWidth: 2)
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct VesselSelectionView: View {
    
    @Binding var vessels: [LocalVesselInfo]
    var markAsSelected: (String) -> Void
    var detailAction: (UUID) -> Void
    
    var body: some View {
        ScrollView {
            ForEach(vessels) { vessel in
                VesselListItemView(vessel: vessel, markAsSelected: markAsSelected, detailAction: detailAction)
            }
        }
    }
    
    
}

struct VesselSelctionView_Previews: PreviewProvider {
    static var previews: some View {
        VesselSelectionView(vessels: .constant(LocalVesselLoader.vessels), markAsSelected: { uuid in
            print("Mark As selected \(uuid)")
        }, detailAction: {
            print("Hello \($0)")
        })
               
    }
}
