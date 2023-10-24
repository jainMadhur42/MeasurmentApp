//
//  HowTo.swift
//  AROFFSETAPP
//
//  Created by Darshan Gummadi on 9/14/23.
//

import SwiftUI

struct HowTo: View {
    @State private var navigateToFirstScreen = false
    
    var body: some View {
        ZStack{
            ThemeColor.backGround.color.ignoresSafeArea(.all)
            VStack {
                Text("New Measurement How-To") .font(.title).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
                    .padding()
                Text("1.Locate your sensors") .font(.title3).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
                    .padding()
                Text("2.Look for Prompts") .font(.title3).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
                    .padding()
                Text("3.Take it slow") .font(.title3).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
            }
        }
    }
}

struct HowTo_Previews: PreviewProvider {
    static var previews: some View {
        HowTo()
    }
}
