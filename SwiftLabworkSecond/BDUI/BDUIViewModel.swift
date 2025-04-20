
public struct BDUIViewModel: Codable {
    public let type: String
    public let content: Content
    public let subviews: [BDUIViewModel]?

    public struct Content: Codable {
        let style: String?
        let backgroundColor: String?
        let spacing: String?
        let text: String?
        let placeholder: String?
        let action: Action?
        let _isHidden: Bool?

        public struct Action: Codable {
            let type: String
            let context: String
        }

        public init(
            style: String? = nil,
            backgroundColor: String? = nil,
            spacing: String? = nil,
            text: String? = nil,
            placeholder: String? = nil,
            action: Action? = nil,
            isHidden: Bool? = nil
        ) {
            self.style = style
            self.backgroundColor = backgroundColor
            self.spacing = spacing
            self.text = text
            self.placeholder = placeholder
            self.action = action
            self._isHidden = isHidden
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            style = try container.decodeIfPresent(String.self, forKey: .style)
            backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
            spacing = try container.decodeIfPresent(String.self, forKey: .spacing)
            text = try container.decodeIfPresent(String.self, forKey: .text)
            placeholder = try container.decodeIfPresent(String.self, forKey: .placeholder)
            action = try container.decodeIfPresent(Action.self, forKey: .action)
            _isHidden = try container.decodeIfPresent(Bool.self, forKey: ._isHidden)
        }

        enum CodingKeys: String, CodingKey {
            case style, backgroundColor, spacing, text, placeholder, action
            case _isHidden = "isHidden"
        }
    }
}

extension BDUIViewModel.Content {
    var isHidden: Bool? {
        get {
            _isHidden
        }
    }
}
