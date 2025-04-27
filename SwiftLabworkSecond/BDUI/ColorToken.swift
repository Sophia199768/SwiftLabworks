import UIKit

enum ColorToken: String {
    case white
    case perfectBlue
    case background
    case error

    var color: UIColor {
        switch self {
        case .white: return .white
        case .perfectBlue: return Color.perfectBlue
        case .background: return Color.background
        case .error: return Color.error
        }
    }
}
