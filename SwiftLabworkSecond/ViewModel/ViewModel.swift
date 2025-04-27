
public struct LabelViewModel {
    public let style: LabelStyleToken
    public let text: String?
    public let isHidden: Bool
    let styleString: String?
    
    public init(style: LabelStyleToken, text: String?, isHidden: Bool = false, styleString: String? = nil) {
        self.style = style
        self.text = text
        self.isHidden = isHidden
        self.styleString = styleString
    }
}

public struct ButtonViewModel {
    public let style: ButtonStyleToken
    public let title: String
    public let action: BDUIViewModel.Content.Action?
    
    public init(style: ButtonStyleToken, title: String, action: BDUIViewModel.Content.Action? = nil) {
        self.style = style
        self.title = title
        self.action = action
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
