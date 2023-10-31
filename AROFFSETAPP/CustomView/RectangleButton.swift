//
//  RectangleButton.swift
//  AROFFSETAPP
//
//  Created by Darshan on 15/10/23.
//

import SwiftUI

struct RectangleButton: View {
    
    var action: () -> Void
    var text: String
    var systemImage: String
    
    @ViewBuilder var body: some View {
        Button {
            self.action()
        } label: {
            HStack {
                Text(text)
                    .fontWeight(.bold)
                    .padding()
                    .cornerRadius(10)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(.white)
                Image(systemName: systemImage)
                    .foregroundColor(ThemeColor.tint.color)
                    .padding(.all)
            }
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(ThemeColor.tint.color, lineWidth: 2)
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .fixedSize(horizontal: false, vertical: true)
    }
}
