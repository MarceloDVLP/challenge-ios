import Foundation
import UIKit


final class PersonDetailCell: UICollectionViewCell {
    
    var didTapTVShow: ((TVShowCodable)->())?

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_imageTransition = .fade
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mediumTitleColor
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        label.numberOfLines = 2
        return label
    }()

    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.titleFont()
        label.textColor = Colors.titleColor
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = Colors.titleColor
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        return UIView()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        constrainImageView()
        constrainSubView(view: containerView, top: 0, bottom: 0, left: 0, right: 0)
        constrainTitleLabel()
        constraintSubtitleLabel()
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
        setGradientBackground()
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor.clear.cgColor
        let colorBottom = Colors.backGroundColor.cgColor
        
        containerView.gradientLayer(colorTop: colorTop, colorBottom: colorBottom)
    }
    
    func color(for rating: Double) -> UIColor {
        if rating <= 5 {
            return UIColor.red
        } else if rating <= 6.5 {
            return UIColor.blue
        } else if rating <= 8 {
            return UIColor.systemBlue
        } else {
            return UIColor.green
        }
    }
    
    func configure(_ person: Person?) {
        guard let person = person else { return }
        titleLabel.text = person.name
        subtitleLabel.text = "Birthday: \(person.birthday ?? "")"
        descLabel.text = "TV Shows:"
        
        if let url = person.image?.original {
            imageView.sd_setImage(with: url)
        } else {
            imageView.image = nil
        }
    }
    
    private func constrainTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
        ])
        
    }
    
    private func constraintSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
    }
    
    private func constrainImageView() {
        contentView.constrainSubView(view: imageView, top: 0, left: 0, right: 0)
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
            descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            descLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
