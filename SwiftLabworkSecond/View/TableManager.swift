import UIKit

protocol TableManagerDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

protocol TableManager {
    func setup(with tableView: UITableView)
    func update(with viewModels: [any ViewModel])
}

class UniversityTableManager: NSObject, TableManager {
    private var tableView: UITableView?
    private var viewModels: [any ViewModel] = []
    weak var delegate: TableManagerDelegate?
    
    func setup(with tableView: UITableView) {
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GenericCell<UniversityCellView>.self, forCellReuseIdentifier: GenericCell<UniversityCellView>.identifier)
    }
    
    func update(with viewModels: [any ViewModel]) {
        self.viewModels = viewModels
        tableView?.reloadData()
    }
}

extension UniversityTableManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenericCell<UniversityCellView>.identifier, for: indexPath) as! GenericCell<UniversityCellView>
        let viewModel = viewModels[indexPath.row] as! UniversityCellViewModel
        cell.configure(with: viewModel)
        return cell
    }
}

extension UniversityTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectItem(at: indexPath.row)
    }
}
