
protocol ConstructorViewProtocol {
    func updateTable(with items: [AppTask])
    func showLoad()
    func hideLoad()
    func showError( message: String)
    func setEditingMode( isEditing: Bool)
    func showEmptyLine()
    func hideEmptyLine()
}
