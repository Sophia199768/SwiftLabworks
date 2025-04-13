import UIKit

class UniversityListController: UIViewController, TableManagerDelegate {
    private let viewModel: UniversityViewModel
    private let router: Router
    private var tableManager: TableManager
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let refreshControl = UIRefreshControl()
    
    private var mainStackView: StackView!
    private var titleLabel: Label!
    
    init(viewModel: UniversityViewModel, router: Router, tableManager: TableManager = UniversityTableManager()) {
        self.viewModel = viewModel
        self.router = router
        self.tableManager = tableManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        tableManager.setup(with: tableView)
        tableManager.delegate = self
        viewModel.loadUniversities()
    }
    
    private func setupUI() {
        view.backgroundColor = Color.background
  
    
        titleLabel = Label(viewModel: LabelViewModel(
            style: .head,
            text: "List of Universities",
            isHidden: false
        ))
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView = StackView(
            axis: .vertical,
            spacing: Space.m,
            arrangedSubviews: [titleLabel, tableView]
        )
        
        view.addSubview(mainStackView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Space.s),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Space.s),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Space.s),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Space.s),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func refreshData() {
        viewModel.resetAndLoadUniversities()
    }
    
    private func bindViewModel() {
        viewModel.onUniversitiesUpdated = { [weak self] in
            guard let self = self else { return }
            let cellViewModels = self.viewModel.cellViewModels
            self.tableManager.update(with: cellViewModels)
            self.refreshControl.endRefreshing()
        }
        
        viewModel.onLoadingStateChanged = { [weak self] isLoading in
            isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
        
        viewModel.onError = { [weak self] errorMessage in
            self?.refreshControl.endRefreshing()
            let errorLabel = Label(viewModel: LabelViewModel(
                style: .error,
                text: errorMessage,
                isHidden: false
            ))
            self?.router.showAlert(
                title: "Error",
                message: errorMessage,
                from: self!
                
            )
        }
    }
    
    func didSelectItem(at index: Int) {
        print("\(index)")
    }
}
