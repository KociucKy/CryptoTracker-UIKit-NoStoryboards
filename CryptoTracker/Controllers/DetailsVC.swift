import UIKit

class DetailsVC: UIViewController {
    //MARK: - Properties
    var name = ""

    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    
    //MARK: - Methods
    func configureVC(){
        title = name
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = false
    }
}
