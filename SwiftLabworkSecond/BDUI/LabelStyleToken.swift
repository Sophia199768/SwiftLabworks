import UIKit

extension LabelStyleToken {
    static func fromString(_ string: String?) -> LabelStyleToken {
        switch string {
        case "head": return .head
        case "error": return .error
        default: return .body
        }
    }
}
