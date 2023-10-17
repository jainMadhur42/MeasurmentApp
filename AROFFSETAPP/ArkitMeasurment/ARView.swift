//
//  ARView.swift
//  SwiftUIARKit
//
//  Created by Gualtiero Frigerio on 18/05/21.
//

import SwiftUI

struct ARView: View {
    
    var activeVesselId: UUID
    @ObservedObject var arDelegate = ARDelegate(loader: CoreDataVesselLoader())
     
    var body: some View {
        ZStack {
            ARViewRepresentable(arDelegate: arDelegate
                                , activeVesselId: activeVesselId)
            VStack {
                Spacer()
                Text(arDelegate.message)
                    .foregroundColor(Color.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 20)
                    .background(Color.secondary)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView(activeVesselId: UUID())
    }
}
