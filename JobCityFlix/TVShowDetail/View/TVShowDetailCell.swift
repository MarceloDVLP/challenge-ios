import UIKit
import SDWebImage


enum Colors {
    static let mediumTitleColor = UIColor.white
    static let backGroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00)
    static let titleColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.00)
    static let titleInactiveColor = UIColor(red: 0.37, green: 0.37, blue: 0.37, alpha: 1.00)
    static let lineColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
    static let activeLineColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.00)
}

protocol TVShowDetailCellDelegate: AnyObject {
    func didTapSeasonButton()
}

final class TVShowDetailCell: UICollectionViewCell {
    
    weak var delegate: TVShowDetailCellDelegate?

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mediumTitleColor
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()

    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.titleInactiveColor
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true 
        constrainImageView()
        constrainTitleLabel()
        constraintDescriptionLabel()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        descLabel.text = nil
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(_ tvShow: TVShowCodable?) {
        guard let tvShow = tvShow else { return }
        titleLabel.text = tvShow.name
        descLabel.text = tvShow.summary
        let url = URL(string: tvShow.image!.original!)
        imageView.sd_setImage(with: url)
    }
    
    private func constrainTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50)
        ])
    }
    
    private func constrainImageView() {
        constrainSubView(view: imageView, top: 0, left: 0, right: 0)
        
        imageView.addConstraint(NSLayoutConstraint(item: imageView,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: imageView,
                                                  attribute: .width,
                                                   multiplier: 1.4,
                                                  constant: 0))
    }
    
    private func constraintDescriptionLabel() {
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            descLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            descLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ tvShow: TVShowCodable?, delegate: TVShowDetailCellDelegate?) {
    }
}
