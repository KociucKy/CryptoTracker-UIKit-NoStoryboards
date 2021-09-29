import UIKit

class CryptoListVC: UIViewController {
    //MARK: - Properties
    var cryptoTableView: UITableView!
    var cryptoObjects: [Crypto]     = []
    var filteredCryptos: [Crypto]   = []
    var isSearching                 = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        getCryptos()
        configureSearchController()
    }
    
    
    //MARK: - Methods
    func configureVC(){
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    func configureTableView(){
        cryptoTableView = UITableView()
        cryptoTableView.dataSource = self
        cryptoTableView.delegate = self
        
        view.addSubview(cryptoTableView)
        cryptoTableView.register(CVCryptoCell.self, forCellReuseIdentifier: CVCryptoCell.reuseID)
        cryptoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cryptoTableView.topAnchor.constraint(equalTo: view.topAnchor),
            cryptoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cryptoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cryptoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func getCryptos(){
        NetworkManager.shared.getCurrencies {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let cryptos):
                self.cryptoObjects.append(contentsOf: cryptos)
                DispatchQueue.main.async { self.cryptoTableView.reloadData() }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentCVAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }
    
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.delegate                     = self
        searchController.searchBar.placeholder                  = "Search for a crypto"
        navigationItem.searchController                         = searchController
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.hidesSearchBarWhenScrolling              = false
    }
}


//MARK: - UITableView DataSource and Delegate
extension CryptoListVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let activeArray = isSearching ? filteredCryptos : cryptoObjects
        return activeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell        = cryptoTableView.dequeueReusableCell(withIdentifier: CVCryptoCell.reuseID, for: indexPath) as! CVCryptoCell
        let activeArray = isSearching ? filteredCryptos : cryptoObjects
        
        cell.set(crypto: activeArray[indexPath.row])
        return cell
    }
}


//MARK: - UISearchController Methods
extension CryptoListVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredCryptos = cryptoObjects.filter{ $0.name.lowercased().contains(filter.lowercased())}
        cryptoTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        cryptoTableView.reloadData()
    }
}
