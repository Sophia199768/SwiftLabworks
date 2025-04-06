
// View для главной странички
protocol MainViewProtocol {
    func updateTable(with items: [JobSearchEntry])
    func showLoad()
    func hideLoad()
    func showError( message: String)
    func setEditingMode( isEditing: Bool)
    func showEmptyLine()
    func hideEmptyLine()
}
