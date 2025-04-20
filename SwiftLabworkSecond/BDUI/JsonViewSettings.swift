import UIKit

extension TextInputStyleToken {
    static func fromString(_ string: String?) -> TextInputStyleToken {
        switch string {
        case "email": return .email
        case "secure": return .secure
        default: return .standard
        }
    }
}
