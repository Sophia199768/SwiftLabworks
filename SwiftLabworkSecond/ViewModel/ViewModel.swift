public struct LabelViewModel {
    public let style: LabelStyle
    public let text: String?
    public let isHidden: Bool
    
    public init(style: LabelStyle, text: String?, isHidden: Bool = false) {
        self.style = style
        self.text = text
        self.isHidden = isHidden
    }
}

public struct ButtonViewModel {
    public let style: ButtonStyle
    public let title: String
    
    public init(style: ButtonStyle, title: String) {
        self.style = style
        self.title = title
    }
}

public struct TextInputViewModel {
    public let style: TextInputStyle
    public let placeholder: String
    public let text: String?
    
    public init(style: TextInputStyle, placeholder: String, text: String? = nil) {
        self.style = style
        self.placeholder = placeholder
        self.text = text
    }
}
