/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view that shows a featured landmark.
*/

import SwiftUI

struct ImageInfo {
    var featureImage: Image? {
        Image(imageName)
    }
    var imageName: String
    var name: String
}

struct FeatureCard: View {
    var imageInfo: ImageInfo

    var body: some View {
        imageInfo.featureImage?
            .resizable()
            .aspectRatio(3 / 2, contentMode: .fit)
            .overlay {
                TextOverlay(imageInfo: imageInfo)
            }
    }
}

struct TextOverlay: View {
    var imageInfo: ImageInfo

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(imageInfo.name)
                    .font(.title)
                    .bold()
            }
            .padding()
        }
        .foregroundStyle(.white)
    }
}


