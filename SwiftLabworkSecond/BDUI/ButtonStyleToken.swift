import UIKit

extension ButtonStyleToken {
    static func fromString(_ string: String?) -> ButtonStyleToken {
        switch string {
        case "greenType": return .greenType
        case "redType": return .redType
        default: return .indigoType
        }
    }
}
