//
//  HowTo.swift
//  AROFFSETAPP
//
//  Created by Darshan Gummadi on 9/14/23.
//

import SwiftUI

struct HowTo: View {
    @State private var navigateToFirstScreen = false
    
    var imageInfos: [ImageInfo] = [ImageInfo(imageName: "charleyrivers"
                                         , name: "New Measurement How-To")
    , ImageInfo(imageName: "chilkoottrail"
               , name: "1.Locate your sensors")
    , ImageInfo(imageName: "chincoteague"
               , name: "2.Look for Prompts")
    , ImageInfo(imageName: "hiddenlake"
               , name: "3.Take it slow")]
    
    var body: some View {
        ZStack{
            ThemeColor.backGround.color.ignoresSafeArea(.all)
            PageView(pages: imageInfos.map { FeatureCard(imageInfo: $0) })
                                .aspectRatio(3 / 2, contentMode: .fit)
                                .listRowInsets(EdgeInsets())
//            VStack {
//                
//                Text("New Measurement How-To")
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//                    .padding()
//                
//                Text("1.Locate your sensors")
//                    .font(.title3)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//                    .padding()
//                Text("2.Look for Prompts")
//                    .font(.title3)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//                    .padding()
//                Text("3.Take it slow")
//                    .font(.title3)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//            }
        }
    }
}

struct HowTo_Previews: PreviewProvider {
    static var previews: some View {
        HowTo()
    }
}
