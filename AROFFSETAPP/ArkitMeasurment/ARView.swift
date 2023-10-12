//
//  ARView.swift
//  SwiftUIARKit
//
//  Created by Gualtiero Frigerio on 18/05/21.
//

import SwiftUI

struct ARView: View {
    
    @AppStorage(Constants.activeVessel) private var activeVesselInfo = UUID().uuidString
    @ObservedObject var arDelegate = ARDelegate(loader: CoreDataVesselLoader())
     
    var body: some View {
        ZStack {
            ARViewRepresentable(arDelegate: arDelegate
                                , activeVesselId: UUID(uuidString: activeVesselInfo)!)
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
        ARView()
    }
}
