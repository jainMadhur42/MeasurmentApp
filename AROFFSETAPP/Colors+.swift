//
//  Colors+.swift
//  AROFFSETAPP
//
//  Created by Madhur on 16/10/23.
//

import SwiftUI

enum ThemeColor {
    
    case backGround
    case tint
    case deleteColor
    
    var color: Color {
        switch self {
        case .backGround:
            return Color("myColor")
        case .tint:
            return .green
        case .deleteColor:
            return .red
        }
    }
    
    var uiColor: UIColor {
        
        switch self {
        case .backGround:
            return (UIColor(named: "myColor") ?? .black)
                .withAlphaComponent(0.5)
        case .tint:
            return .green
        case .deleteColor:
            return .red
        }
    }
}

extension Color {
    static let ui = Color.UI()
    
    struct UI {
         let theme = Color("myColor")
    }
}
