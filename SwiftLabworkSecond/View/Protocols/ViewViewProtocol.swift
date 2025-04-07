
// View для странички просмотра информации о пользователе
protocol ViewViewProtocol {
    func updateTable(with items: [View])
    func showLoad()
    func hideLoad()
    func showError( message: String)
    func setEditingMode( isEditing: Bool)
}

