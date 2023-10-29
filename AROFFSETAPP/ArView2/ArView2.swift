//
//  ARView2.swift
//  SwiftUIARKit
//
//  Created by Gualtiero Frigerio on 18/05/21.
//

import SwiftUI

struct ARView2: View {
    
    @Binding var activeVesselId: String
    @ObservedObject var arDelegate: ARDelegate2
    @State var showError = false
    @State var isSaved = false
    var loader: VesselDistanceLoader

    var body: some View {
        if !arDelegate.enableSave {
            ZStack {
                ARViewRepresentable2(arDelegate: arDelegate)
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
     
    //            .sheet(isPresented: $arDelegate.enableSave) {
    //                NavigationView {
    //                    DistanceInsertConfirmationView(distance: arDelegate.coordinates)
    //                        .toolbar {
    //                            ToolbarItem(placement: .confirmationAction, content: {
    //                                Button {
    
    //                                } label: {
    //                                    Text("Save")
    //
    //                                }
    //                            })
    //                            ToolbarItem(placement: .cancellationAction, content: {
    //                                Button {
    //                                    arDelegate.enableSave.toggle()
    //                                } label: {
    //                                    Text("Cancel")
    //                                        .foregroundColor(ThemeColor.backGround.color)
    //                                }
    //                            })
    //                        }
    //                }
    //            }
            }.edgesIgnoringSafeArea(.all)
        } else {
            VStack {
                MeasurmentListItem(vesselDistance: arDelegate.coordinates)
                    .padding(.all)
                HStack {
                    Button {
                        arDelegate.enableSave = false
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
                        
                    } label: {
                        Text("Share")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}


