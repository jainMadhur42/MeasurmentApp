//
//  ARView.swift
//  SwiftUIARKit
//
//  Created by Gualtiero Frigerio on 18/05/21.
//

import SwiftUI

struct ARView: View {
    
    @Binding var activeVesselId: String
    @ObservedObject var arDelegate: ARDelegate
    @State var showError = false
    @State var isSaved = false
    var loader: VesselDistanceLoader
    var share: (LocalVesselDistance) -> Void
    
    var body: some View {
        if !arDelegate.enableSave {
            ZStack {
                ARViewRepresentable(arDelegate: arDelegate)
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text(arDelegate.formattedDistance)
                        .font(.title3)
                    
                    Text(arDelegate.x)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.green)
                       
                    Text(arDelegate.y)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.red)
                    
                    Text(arDelegate.z)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.blue)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                .padding(EdgeInsets(top: 45, leading: 8, bottom: 16, trailing: 0))
            }.edgesIgnoringSafeArea(.all)
        } else {
            VStack {
                MeasurmentListItem(vesselDistance: arDelegate.coordinates)
                    .padding(.all)
                HStack {
                    Button {
                        arDelegate.resetScene()
                    } label: {
                        Text("close")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        loader.insert(vesselDistance: arDelegate.coordinates) { _ in
                            print("Distance Saved")
                            DispatchQueue.main.async {
                                arDelegate.resetScene()
                            }
                        }
                    } label: {
                        Text("Save")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        share(arDelegate.coordinates)
                    } label: {
                        Text("Share")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}


