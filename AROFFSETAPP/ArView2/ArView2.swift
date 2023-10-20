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
            VStack(alignment: .leading, spacing: 12) {
                Text(arDelegate.distance)
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


