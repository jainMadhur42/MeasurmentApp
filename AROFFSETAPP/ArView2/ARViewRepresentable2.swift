//
//  ARViewRepresentable2.swift
//  AROFFSETAPP
//
//  Created by Madhur on 20/10/23.
//


import ARKit
import SwiftUI

struct ARViewRepresentable2: UIViewRepresentable {
    
    let arDelegate:ARDelegate2
    
    func makeUIView(context: Context) -> some UIView {
        let arView = ARSCNView(frame: .zero)
        arView.autoenablesDefaultLighting = true
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        arDelegate.setARView(arView)
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct ARViewRepresentable2_Previews: PreviewProvider {
    
    static var previews: some View {
        ARViewRepresentable2(arDelegate: ARDelegate2(activeVesselId: UUID().uuidString))
    }
}
