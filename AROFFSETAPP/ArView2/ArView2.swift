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
    var loader: VesselDistanceLoader

    var body: some View {
        ZStack {
            ARViewRepresentable2(arDelegate: arDelegate)
            Button {
                
            } label: {
                Image(systemName: "plus")
            }
            VStack(alignment: .trailing) {
                Button {
                    loader.insert(vesselDistance: arDelegate.coordinates) {
                        arDelegate.resetScene()
                    }
                } label: {
                    ZStack {
                        Image(systemName: "square.and.arrow.down")
                            .frame(width: 40, height: 40)
                            .background(.white)
                            .foregroundColor(.black)
                            .clipShape(Circle())
                            .opacity(0.5)
                            .padding()
                        
                    }
                }
                .opacity(arDelegate.enableSave ? 1 : 0)
                .disabled(!arDelegate.enableSave)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(EdgeInsets(top: 45, leading: 8, bottom: 16, trailing: 16))
            
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
        
    }
}


