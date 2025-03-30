import UIKit

// Контроллер для входа
protocol LoginControllerProtocol {
    // Отслеживает измение поля email
    func emailTextChanged(_ textField: UITextField)
    // Отслеживает нажатие на кнопку login
    func loginButtonTapped()
}
