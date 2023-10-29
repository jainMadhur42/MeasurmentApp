//
//  ARDelgeate2.swift
//  SwiftUIARKit
//
//  Created by Gualtiero Frigerio on 18/05/21.
//

import Foundation
import ARKit
import UIKit

class ARDelegate2: NSObject, ARSCNViewDelegate, ObservableObject {
    
    @Published var enableSave = false
    @Published var presentMeasurment: Bool = false
    @Published var message:String = "starting AR"
    @Published var x: String = "x: 0.0"
    @Published var y: String = "y: 0.0"
    @Published var z: String = "z: 0.0"
    @Published var formattedDistance: String = "Distance: 0.0"
    var distance: Float = 0.0
    @Published var coordinates: LocalVesselDistance = LocalVesselDistance(x1: 0.0
                                                                       , x2: 0.0
                                                                       , y1: 0.0
                                                                       , y2: 0.0
                                                                       , z1: 0.0
                                                                       , z2: 0.0
                                                                       , distance: 0.0
                                                                       , vesselId: UUID())
    
    func setARView(_ arView: ARSCNView) {
        self.arView = arView
        
        configuration.planeDetection = .horizontal
        arView.session.run(configuration, options: [])
        
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        arView.autoenablesDefaultLighting = true
        arView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        arView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        guard let arView = arView else { return }
        
        if startingPositionNode != nil && endingPositionNode != nil {
            startingPositionNode?.removeFromParentNode()
            endingPositionNode?.removeFromParentNode()
            startingPositionNode = nil
            endingPositionNode = nil
            coordinates = LocalVesselDistance(x1: 0.0
                                              , x2: 0.0
                                              , y1: 0.0
                                              , y2: 0.0
                                              , z1: 0.0
                                              , z2: 0.0
                                              , distance: 0.0
                                              , vesselId: UUID())

        } else if startingPositionNode != nil && endingPositionNode == nil {
            let sphere = SCNNode(geometry: SCNSphere(radius: 0.002))
            sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            Service.addChildNode(sphere, toNode: arView.scene.rootNode, inView: arView, cameraRelativePosition: cameraRelativePosition)
            endingPositionNode = sphere
        } else if startingPositionNode == nil && endingPositionNode == nil {
            let sphere = SCNNode(geometry: SCNSphere(radius: 0.002))
            sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
            Service.addChildNode(sphere, toNode: arView.scene.rootNode, inView: arView, cameraRelativePosition: cameraRelativePosition)
            startingPositionNode = sphere
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("camera did change \(camera.trackingState)")
        switch camera.trackingState {
        case .limited(_):
            message = "tracking limited"
        case .normal:
            message =  "tracking ready"
        case .notAvailable:
            message = "cannot track"
        }
    }
    
    // MARK: - Private
    let configuration = ARWorldTrackingConfiguration()
    let cameraRelativePosition = SCNVector3(0,0,-0.1)
    var startingPositionNode: SCNNode?
    var endingPositionNode: SCNNode?
    private var arView: ARSCNView?
    private var circles:[SCNNode] = []
    private var trackedNode:SCNNode?
    @Published var activeVesselId: String
    
    init(activeVesselId: String) {
        self.activeVesselId = activeVesselId
    }
    
    private func raycastResult(fromLocation location: CGPoint) -> ARRaycastResult? {
        guard let arView = arView,
              let query = arView.raycastQuery(from: location,
                                        allowing: .existingPlaneGeometry,
                                        alignment: .horizontal) else { return nil }
        let results = arView.session.raycast(query)
        return results.first
    }
    
    func removeCircle(node:SCNNode) {
        node.removeFromParentNode()
        presentMeasurment.toggle()
        circles.removeAll(where: { $0 == node })
    }
    
    func resetScene() {
        guard let arView = arView else { return }
        arView.session.pause()
        enableSave = false
        startingPositionNode = nil
        endingPositionNode = nil
        
        arView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "node" {
                node.removeFromParentNode()
            }
        }
        coordinates = LocalVesselDistance(x1: 0.0
                                          , x2: 0.0
                                          , y1: 0.0
                                          , y2: 0.0
                                          , z1: 0.0
                                          , z2: 0.0
                                          , distance: 0.0
                                          , vesselId: UUID())
        arView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    }
    
    func removeNode(named: String) {
        guard let arView = arView else { return }
        arView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == named {
                node.removeFromParentNode()
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
      
      guard let arView = arView else {
          
          return
      }
         
        if self.startingPositionNode != nil && self.endingPositionNode != nil {
            
            DispatchQueue.main.async { [weak self] in
                
                guard let self = self else { return }
                self.enableSave.toggle()
                self.coordinates = LocalVesselDistance(x1: self.startingPositionNode!.position.x
                                                       , x2: self.endingPositionNode!.position.x
                                                       , y1: self.startingPositionNode!.position.y
                                                       , y2: self.endingPositionNode!.position.y
                                                       , z1: self.startingPositionNode!.position.z
                                                       , z2: self.endingPositionNode!.position.z
                                                       , distance: self.distance
                                                       , vesselId: UUID(uuidString:  self.activeVesselId)!)
            }
            return
        }
      
        guard let xDistance = Service.distance3(fromStartingPositionNode: startingPositionNode, onView: arView, cameraRelativePosition: cameraRelativePosition)?.x else {return}
        guard let yDistance = Service.distance3(fromStartingPositionNode: startingPositionNode, onView: arView, cameraRelativePosition: cameraRelativePosition)?.y else {return}
        guard let zDistance = Service.distance3(fromStartingPositionNode: startingPositionNode, onView: arView, cameraRelativePosition: cameraRelativePosition)?.z else {return}
      
        DispatchQueue.main.async {
          
            self.x = String(format: "x: %.2f", xDistance) + "m"
            self.y = String(format: "y: %.2f", yDistance) + "m"
            self.z = String(format: "z: %.2f", zDistance) + "m"
            self.distance = Service.distance(x: xDistance, y: yDistance, z: zDistance)
            self.formattedDistance = String(format: "Distance: %.2f", self.distance) + "m"
        }
    }
    
}
