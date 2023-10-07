//
//  LoadMeasurement.swift
//  AROFFSETAPP
//
//  Created by Darshan Gummadi on 9/13/23.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                parent.didFindCode(stringValue)
            }
        }
    }

    var didFindCode: (String) -> Void

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIViewController {
        let viewController = UIViewController()
        let session = AVCaptureSession()

        guard let device = AVCaptureDevice.default(for: .video) else { return viewController }

        do {
            let input = try AVCaptureDeviceInput(device: device)
            session.addInput(input)
        } catch {
            return viewController
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = UIScreen.main.bounds
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)

        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(rect: UIScreen.main.bounds)
        path.append(UIBezierPath(rect: CGRect(x: 50, y: 50, width: 200, height: 200)))
        maskLayer.path = path.cgPath
        maskLayer.fillRule = .evenOdd
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.opacity = 0.5

        previewLayer.mask = maskLayer
        viewController.view.layer.addSublayer(previewLayer)

        let output = AVCaptureMetadataOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)

            output.setMetadataObjectsDelegate(context.coordinator, queue: .main)
            output.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417]
        } else {
            return viewController
        }

        session.startRunning()

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CameraView>) { }
}

struct LoadMeasurement: View {
    @State private var scannedCode: String?

    var body: some View {
        VStack {
            if let scannedCode = scannedCode {
                Text("Scanned code: \(scannedCode)")
            } else {
                CameraView { code in
                    self.scannedCode = code
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}


struct LoadMeasurement_Previews: PreviewProvider {
    static var previews: some View {
        LoadMeasurement()
    }
}
