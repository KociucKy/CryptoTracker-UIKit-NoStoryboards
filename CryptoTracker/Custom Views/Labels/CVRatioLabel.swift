import UIKit

class CVRatioLabel: UILabel {
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    
    private func configure(){
        textColor                   = .systemGreen
        font                        = UIFont.preferredFont(forTextStyle: .headline)
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        translatesAutoresizingMaskIntoConstraints = false
    }
}
