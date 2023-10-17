//
//  Colors+.swift
//  AROFFSETAPP
//
//  Created by Madhur on 16/10/23.
//

import SwiftUI

enum ThemeColor {
    
    case backGround
    
    var theme: Color {
        switch self {
        case .backGround:
            return Color("myColor")
        }
    }
}

extension Color {
    static let ui = Color.UI()
    
    struct UI {
         let theme = Color("myColor")
    }
}
