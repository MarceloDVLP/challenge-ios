import UIKit
import SDWebImage

final class TVShowListCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "re")!
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainImageView()
        contentView.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circularShadow()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ tvShow: TVShowCodable) {
        let url = URL(string: tvShow.image!.medium!)
        imageView.sd_imageTransition = .fade
        imageView.sd_setImage(with: url)
    }
    
    override func prepareForReuse() {
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
    }
    
    private func constrainImageView() {
        contentView.constrainSubView(view: imageView,
                                     top: 0,
                                     bottom: 0, left: 0,
                                     right: 0)
    }
    

}
