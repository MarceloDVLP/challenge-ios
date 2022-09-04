import UIKit
import SDWebImage

final class SearchPersonCell: UICollectionViewCell {
    
    let sizeImage: CGFloat = 100
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = Colors.titleInactiveColor
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        return nameLabel
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var containerImageView: UIView = {
        let containerImageView = UIView()
        containerImageView.backgroundColor = .darkGray
        containerImageView.layer.cornerRadius = sizeImage/2
        containerImageView.clipsToBounds = true

        return containerImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainImageView()
        constrainNameLabel()
    }
    
    public func configure(name: String, url: URL?) {
        nameLabel.text = name
        
        if let url = url {
            imageView.sd_setImage(with: url)
        }
    }
    
    private func constrainImageView() {
        contentView.constrainSubView(view: containerImageView, width: sizeImage, height: sizeImage)
        NSLayoutConstraint.activate([
            containerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        containerImageView.constrainSubView(view: imageView, width: 100, height: 150)
    }
    
    private func constrainNameLabel() {
        contentView.constrainSubView(view: nameLabel, left: 8, right: -8)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerImageView.bottomAnchor, constant: 4),
            nameLabel.centerXAnchor.constraint(equalTo: containerImageView.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}
