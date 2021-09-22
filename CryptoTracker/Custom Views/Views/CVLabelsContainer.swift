import UIKit

class CVLabelsContainer: UIView {
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        backgroundColor = .systemPink
        translatesAutoresizingMaskIntoConstraints = false
    }
}
