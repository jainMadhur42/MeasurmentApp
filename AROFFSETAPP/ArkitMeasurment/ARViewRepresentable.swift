//
//  ARViewRepresentable.swift
//  SwiftUIARKit
//
//  Created by Gualtiero Frigerio on 18/05/21.
//

import ARKit
import SwiftUI

struct ARViewRepresentable: UIViewRepresentable {
    let arDelegate:ARDelegate
    var activeVesselId: UUID
    
    func makeUIView(context: Context) -> some UIView {
        let arView = ARSCNView(frame: .zero)
        arView.autoenablesDefaultLighting = true
        arDelegate.setARView(arView, activeVesselId: activeVesselId)
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct ARViewRepresentable_Previews: PreviewProvider {
    
    static var previews: some View {
        ARViewRepresentable(arDelegate: ARDelegate(loader: LocalVesselLoader()), activeVesselId: UUID())
    }
}
