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
    var loader: VesselDistanceLoader

    var body: some View {
        ZStack {
            ARViewRepresentable(arDelegate: arDelegate)
            Group {
                if !arDelegate.presentMeasurtment {
                    VStack {
                        Spacer()
                        HStack {
                            Text(arDelegate.message)
                                .foregroundColor(Color.primary)
                                .frame(maxWidth: .infinity)
                                .padding(.all)
                            Button {
                                arDelegate.presentMeasurtment.toggle()
                            } label: {
                                Image(systemName: arDelegate.presentMeasurtment ? "chevron.down.circle" : "chevron.up.circle")
                                
                            }
                            .padding(.all)
                            
                        }
                        .background(Color.secondary)
                        
                    }
                } else {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Text(arDelegate.message)
                                .foregroundColor(Color.primary)
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, 20)
                                
                            Button {
                                arDelegate.presentMeasurtment.toggle()
                            } label: {
                                Image(systemName: arDelegate.presentMeasurtment ? "chevron.down.circle" : "chevron.up.circle")
                                
                            }
                            .padding(.all)
                            
                            Button {
                                arDelegate.presentMeasurtment.toggle()
                                print(arDelegate.distance)
                                loader.insert(vesselDistance: arDelegate.distance
                                              , completion: {  })
                            } label: {
                                Image(systemName: "square.and.arrow.down")
                            }
                            .padding(.all)
                        }
                        
                        .background(Color.secondary)
                        
                        MeasurmentListItem(vesselDistance: arDelegate.distance)
                            .padding([.bottom,.leading,.trailing])
                    }
                }
            }
            .padding(.bottom)
        }.edgesIgnoringSafeArea(.all)
    }
}

//struct ARView_Previews: PreviewProvider {
//    static var previews: some View {
//        ARView(activeVesselId: UUID())
//    }
//}
