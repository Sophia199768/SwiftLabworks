import UIKit

class UniversityListController: UIViewController {
    private var networkService: UniversityNetworkService!
    private var universities: [UniversityEntry] = []
    private var currentPage = 0
    private var isLoading = false
    

    override func loadView() {
        networkService = UniversityNetworkService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupTableView()
        // setupActivityIndicator()
        loadUniversities()
    }
    
    private func loadUniversities() {
        guard !isLoading else { return }
        isLoading = true
        
        // При загрузке на экране отобразить индикатор загрузки или любое другое отображение информации о наличии процесса
        // Написала пока с комментариями, так как пока нет view, а потом в пятой лабе добавлю
        //activityIndicator.startAnimating()
        
        networkService.getUniversities(country: "United States", page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
              //  self.activityIndicator.stopAnimating()
                
                switch result {
                case .success(let newUniversities):
                    self.universities.append(contentsOf: newUniversities)
                    self.currentPage += 1
                    //self.tableView.reloadData()
                    print("Loaded universities: \(self.universities.count)")
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadNextPage() {
        loadUniversities()
    }
}
