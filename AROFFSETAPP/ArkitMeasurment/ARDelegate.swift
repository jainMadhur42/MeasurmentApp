//
//  ARDelgeate.swift
//  SwiftUIARKit
//
//  Created by Gualtiero Frigerio on 18/05/21.
//

import Foundation
import ARKit
import UIKit

class ARDelegate: NSObject, ARSCNViewDelegate, ObservableObject {
    
    @Published var presentMeasurtment: Bool = false
    @Published var message:String = "starting AR"
    @Published var distance: LocalVesselDistance = LocalVesselDistance(x1: 0.0
                                                                       , x2: 0.0
                                                                       , y1: 0.0
                                                                       , y2: 0.0
                                                                       , z1: 0.0
                                                                       , z2: 0.0
                                                                       , distance: 0.0
                                                                       , vesselId: UUID())
    
    
    func setARView(_ arView: ARSCNView) {
        self.arView = arView
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        arView.session.run(configuration)
        
        arView.delegate = self
        arView.scene = SCNScene()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnARView))
        arView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panOnARView))
        arView.addGestureRecognizer(panGesture)
    }
    
    @objc func panOnARView(sender: UIPanGestureRecognizer) {
        guard let arView = arView else { return }
        let location = sender.location(in: arView)
        switch sender.state {
        case .began:
            if let node = nodeAtLocation(location) {
                trackedNode = node
            }
        case .changed:
            if let node = trackedNode {
                if let result = raycastResult(fromLocation: location) {
                    moveNode(node, raycastResult:result)
                }
            }
        default:
            ()
        }
        
    }
    
    @objc func tapOnARView(sender: UITapGestureRecognizer) {
        guard let arView = arView else { return }
        let location = sender.location(in: arView)
        if let node = nodeAtLocation(location) {
            removeCircle(node: node)
        }
        else if let result = raycastResult(fromLocation: location) {
            addCircle(raycastResult: result)
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

    private var arView: ARSCNView?
    private var circles:[SCNNode] = []
    private var trackedNode:SCNNode?
    @Published var activeVesselId: String
    
    init(activeVesselId: String) {
        self.activeVesselId = activeVesselId
    }
    
    private func addCircle(raycastResult: ARRaycastResult) {
        let circleNode = GeometryUtils.createCircle(fromRaycastResult: raycastResult)
        if circles.count >= 2 {
            for circle in circles {
                circle.removeFromParentNode()
            }
            circles.removeAll()
        }
        
        arView?.scene.rootNode.addChildNode(circleNode)
        circles.append(circleNode)
        
        nodesUpdated()
    }
    
    
    
    private func moveNode(_ node:SCNNode, raycastResult:ARRaycastResult) {
        node.simdWorldTransform = raycastResult.worldTransform
        nodesUpdated()
    }
    
    private func nodeAtLocation(_ location:CGPoint) -> SCNNode? {
        guard let arView = arView else { return nil }
        let result = arView.hitTest(location, options: nil)
        return result.first?.node
    }
    
    private func nodesUpdated() {
        if circles.count == 2 {
            let firstNode = circles[0]
            let secondNode = circles[1]
            
            let distance = GeometryUtils.calculateDistance(firstNode: firstNode, secondNode: secondNode)
            print("distance = \(distance)")
            message = "distance " + String(format: "%.2f cm", distance)
            presentMeasurtment.toggle()
           
            self.distance = LocalVesselDistance(x1: firstNode.position.x
                                                          , x2: secondNode.position.x
                                                          , y1: firstNode.position.y
                                                          , y2: secondNode.position.y
                                                          , z1: firstNode.position.z
                                                          , z2: secondNode.position.z
                                                          , distance: distance
                                                          , vesselId: UUID(uuidString:  activeVesselId)!)

        }
        else {
            message = "add second point"
        }
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
        presentMeasurtment.toggle()
        circles.removeAll(where: { $0 == node })
    }
}
