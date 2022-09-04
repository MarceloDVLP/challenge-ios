import UIKit
import SDWebImage

final class TVShowListCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        view.contentMode = .scaleAspectFill
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingHead
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.textColor = Colors.titleColor
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainImageView()
        constrainTitleLabel()
        contentView.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circularShadow()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true

    }
    
    override func prepareForReuse() {
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
    }
        
    func configure(_ tvShow: TVShowCodable) {
        titleLabel.text = tvShow.name
        if let url = tvShow.image?.medium {
            loadImageWith(url)
        }        
    }
    
    private func loadImageWith(_ url: URL) {
        imageView.sd_imageTransition = .fade
        imageView.sd_setImage(with: url, completed: { [weak self] _, error, _, _  in
            
            if error == nil {
                self?.titleLabel.isHidden = true
            } else {
                self?.titleLabel.isHidden = false
            }
        })
    }
    
    private func constrainImageView() {
        contentView.constrainSubView(view: imageView,
                                     top: 0,
                                     bottom: 0,
                                     left: 0,
                                     right: 0)
    }

    private func constrainTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 4),
            titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -4),
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
