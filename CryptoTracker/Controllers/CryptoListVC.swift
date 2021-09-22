import UIKit

class CryptoListVC: UIViewController {
    //MARK: - Properties
    var cryptoTableView: UITableView!
    var cryptoNames = ["BitCoin", "Etherium", "DogeCoin", "LiteCoin"]
    var cryptoShortNames = ["BTC", "ETH", "DOGE", "LTC"]
    var cryptoObjects: [Crypto] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        getCryptos()
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
}


//MARK: - UITableView DataSource and Delegate
extension CryptoListVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cryptoTableView.dequeueReusableCell(withIdentifier: CVCryptoCell.reuseID, for: indexPath) as! CVCryptoCell
        cell.set(crypto: cryptoObjects[indexPath.row])
        return cell
    }
    
    
}
