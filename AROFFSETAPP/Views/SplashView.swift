//
//  SplashView.swift
//  AROFFSETAPP
//
//  Created by Madhur on 15/10/23.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive = true
    var vesselDistanceLoader: VesselDistanceLoader
    var vesselInfoLoader: VesselInfoLoader
    
    var body: some View {
        ZStack {
            Rectangle()
                .background(ThemeColor.backGround.theme)
                .ignoresSafeArea(.all)
            if isActive {
                ZStack {
                    VStack(spacing: 8) {
                        Text("Crowdsourced Bathymetry")
                           .font(.title)
                           .fontWeight(.bold)
                           .foregroundColor(.white)
                           .multilineTextAlignment(.center)
                          
                        Text("Vessel Offset Measurement Tool")
                           .font(.title)
                           .fontWeight(.bold)
                           .foregroundColor(.white)
                           .multilineTextAlignment(.center)
                    }
                }
            }
            else {
                MainView(vesselInfoLoader: vesselInfoLoader, vesselDistanceLoader: vesselDistanceLoader)
           }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5
                                          , execute: {
                isActive.toggle()
            })
        }
    }
    
   
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(vesselDistanceLoader: LocalVesselLoader(), vesselInfoLoader: LocalVesselLoader())
    }
}
