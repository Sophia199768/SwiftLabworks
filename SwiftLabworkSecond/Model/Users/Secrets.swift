import Foundation

struct Secrets {
    static var login: String {
        getValue(for: "LOGIN")
    }

    static var password: String {
        getValue(for: "PASSWORD")
    }

    private static func getValue(for key: String) -> String {
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: String],
            let value = plist[key]
        else {
            fatalError("Missing or invalid key: \(key)")
        }
        return value
    }
}

