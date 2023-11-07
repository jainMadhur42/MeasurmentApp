import ARKit
import SwiftUI

struct ARViewRepresentable: UIViewRepresentable {
    
    let arDelegate: ARDelegate
    
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
        ARViewRepresentable(arDelegate: ARDelegate(activeVesselId: UUID().uuidString))
    }
}
