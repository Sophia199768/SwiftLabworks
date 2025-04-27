
public struct LabelViewModel {
    public let style: LabelStyleToken
    public let text: String?
    public let isHidden: Bool
    
    public init(style: LabelStyleToken, text: String?, isHidden: Bool = false) {
        self.style = style
        self.text = text
        self.isHidden = isHidden
    }
}

public struct ButtonViewModel {
    public let style: ButtonStyleToken
    public let title: String
    
    public init(style: ButtonStyleToken, title: String) {
        self.style = style
        self.title = title
    }
}

public struct TextInputViewModel {
    public let style: TextInputStyleToken
    public let placeholder: String
    public let text: String?
    
    public init(style: TextInputStyleToken, placeholder: String, text: String? = nil) {
        self.style = style
        self.placeholder = placeholder
        self.text = text
    }
}
