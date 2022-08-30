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
        imageView.sd_imageTransition = .fade
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var qualityImageView: UIImageView = {
        let image = UIImage(named: "hd-icon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var ratingView: UIView = {
        let ratingView = UIView()
        ratingView.layer.borderWidth = 1
        ratingView.layer.borderColor = UIColor.white.cgColor
        return ratingView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mediumTitleColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.text = "12"
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mediumTitleColor
        label.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
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
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Colors.titleColor
        label.numberOfLines = 1
        label.text = "Comedy - 2014 - 60min"
        
        return label
    }()
    
    private lazy var sumaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = Colors.titleColor
        label.numberOfLines = 4
        label.text = "Murder in the First follows homicide detectives Terry English and Hildy Mulligan as they investigate two seemingly unrelated murders. The mystery deepens, however, when they find both murders have a common denominator in a Silicon Valley wunderkind."
        
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
        setGradientBackground()
        constrainTitleLabel()
        constraintQualityImage()
        constraintRatingView()
        constraintDescriptionLabel()
        constraintSubtitleLabel()
        constraintSumaryLabel()
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
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
    
    func setGradientBackground() {
        let colorTop =  UIColor.clear.cgColor
        let colorBottom = Colors.backGroundColor.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.4, 1.0]
        gradientLayer.frame = self.bounds
                
        containerView.layer.insertSublayer(gradientLayer, at:0)
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
    
    func configure(_ tvShow: TVShowCodable?) {
        guard let tvShow = tvShow else { return }
        titleLabel.text = tvShow.name
        descLabel.text = tvShow.summary
        
        if let average = tvShow.rating?.average {
            ratingLabel.text = String(average)
            ratingView.backgroundColor = color(for: average)
        } else {
            ratingLabel.text = "*"
            ratingView.backgroundColor = .lightGray
        }
                
        subtitleLabel.text = "\(tvShow.genres?.joined(separator: ",") ?? "") - \(tvShow.premiered ?? "") - \(tvShow.runtime ?? 0)min"
        
        let url = URL(string: tvShow.image!.original!)
        imageView.sd_setImage(with: url)
    }
    
    private func constrainTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150)
        ])
    }
    
    private func constraintQualityImage() {
        qualityImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(qualityImageView)
        
        NSLayoutConstraint.activate([
            qualityImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            qualityImageView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor)
        ])
    }
    
    private func constraintRatingView() {
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingView)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingLabel)
        
        ratingView.backgroundColor = .red
        
        
        NSLayoutConstraint.activate([
            ratingView.centerYAnchor.constraint(equalTo: qualityImageView.centerYAnchor),
            ratingView.leftAnchor.constraint(equalTo: qualityImageView.rightAnchor, constant: 4),
            ratingView.widthAnchor.constraint(equalToConstant: 23),
            ratingView.heightAnchor.constraint(equalToConstant: 15),
            ratingLabel.centerXAnchor.constraint(equalTo: ratingView.centerXAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor)
            
        ])
    }
    
    private func constraintSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.leftAnchor.constraint(equalTo: ratingView.rightAnchor, constant: 12),
            subtitleLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor)
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

    private func constraintSumaryLabel() {
        sumaryLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sumaryLabel)
        
        NSLayoutConstraint.activate([
            sumaryLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 16),
            sumaryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            sumaryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ tvShow: TVShowCodable?, delegate: TVShowDetailCellDelegate?) {
    }
}


extension UIFont {
    
    static func titleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .heavy)
    }
}
