import UIKit


enum SpaceToken: String {
    case xs
    case s
    case m
    case l

    var value: CGFloat {
        switch self {
        case .xs: return Space.xs
        case .s: return Space.s
        case .m: return Space.m
        case .l: return Space.l
        }
    }
}
