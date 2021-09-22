import UIKit

class CVCryptoCell: UITableViewCell {
    //MARK: - Properties
    static let reuseID = "CryptoCell"
    let nameLabel = CVTitleLabel(textAlignment: .left, fontSize: 20)
    let shortNameLabel = CVBodyLabel(textAlignment: .left)
    let ratioLabel = CVRatioLabel(textAlignment: .right)
    let labelsContainer = CVLabelsContainer(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(crypto: Crypto){
        let cryptoPriceAsFloat = Float(crypto.price) ?? 0.00
        let cryptoPrice = String(format: "%.2f", cryptoPriceAsFloat)
        
        nameLabel.text = crypto.name
        shortNameLabel.text = crypto.currency
        ratioLabel.text = "$\(cryptoPrice)"
    }
    
    private func configureCell(){
        labelsContainer.addSubview(nameLabel)
        labelsContainer.addSubview(shortNameLabel)
        addSubview(labelsContainer)
        addSubview(ratioLabel)
        
        setContainerConstraints()
        setRatioLabelConstraints()
        setLabelsConstraints()
    }
    
    
    func setContainerConstraints(){
        NSLayoutConstraint.activate([
            labelsContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            labelsContainer.heightAnchor.constraint(equalToConstant: 50),
            labelsContainer.trailingAnchor.constraint(equalTo: ratioLabel.leadingAnchor)
        ])
    }
    
    
    func setRatioLabelConstraints(){
        NSLayoutConstraint.activate([
            ratioLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ratioLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            ratioLabel.heightAnchor.constraint(equalToConstant: 50),
            ratioLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    func setLabelsConstraints(){
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: labelsContainer.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            shortNameLabel.leadingAnchor.constraint(equalTo: labelsContainer.leadingAnchor),
            shortNameLabel.bottomAnchor.constraint(equalTo: labelsContainer.bottomAnchor),
            shortNameLabel.trailingAnchor.constraint(equalTo: labelsContainer.trailingAnchor),
            shortNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
}
