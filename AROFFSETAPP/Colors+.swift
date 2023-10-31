import SwiftUI

enum ThemeColor {
    
    case backGround
    case tint
    case deleteColor
    case shareColor
    
    var color: Color {
        switch self {
        case .backGround:
            return Color("myColor")
        case .tint:
            return .green
        case .deleteColor:
            return .red
        case .shareColor:
            return .green
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
        case .shareColor:
            return .green
        }
    }
}

extension Color {
    static let ui = Color.UI()
    
    struct UI {
         let theme = Color("myColor")
    }
}
