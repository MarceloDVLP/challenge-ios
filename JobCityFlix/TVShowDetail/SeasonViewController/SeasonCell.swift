import UIKit

final class SeasonCell: UICollectionViewCell {
    
    private lazy var seasonLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainSubView(view: seasonLabel, top: 0, left: 0, right: 0)
    }
    
    public func configure(season: String, isSelected: Bool) {
        seasonLabel.text = season
        
        if isSelected {
            seasonLabel.font = UIFont.boldSystemFont(ofSize: 20)
            seasonLabel.textColor = Colors.mediumTitleColor
        } else {
            seasonLabel.font = UIFont.systemFont(ofSize: 17)
            seasonLabel.textColor = .lightGray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
