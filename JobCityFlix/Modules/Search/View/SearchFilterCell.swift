import UIKit

final class SearchFilterCell: UICollectionViewCell {
    
    var didTapFilterButton: (() -> ())?
    
    lazy var seasonButton: UIButton = {
        let button = UIButton()
        button.setupWithMainColors()
        
        let image = UIImage(named: "arrow-down")!
        button.setImage(image, for: .normal)

        button.contentHorizontalAlignment = .left
        button.alignImageToRight()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        return button
    }()
    
    lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.titleColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainSubView(view: seasonButton, top: 0, left: 0, width: 80, height: 30)
       
        addSubview(filterLabel)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            filterLabel.leftAnchor.constraint(equalTo: seasonButton.rightAnchor, constant: 0),
            filterLabel.centerYAnchor.constraint(equalTo: seasonButton.centerYAnchor)
        ])
       
        seasonButton.addTarget(self, action: #selector(didTapSeasonButtonFunc), for: .touchUpInside)
        seasonButton.setTitle("Filters  ", for: .normal)
        filterLabel.text = "TV Shows"
    }
       
    public func configure(_ filter: String) {
        filterLabel.text = filter
    }
        
    @objc func didTapSeasonButtonFunc(_ sender: UIButton) {
        didTapFilterButton?()
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
}
