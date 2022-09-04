import UIKit
import SDWebImage

final class TVShowMainHeader: UICollectionReusableView {

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.sd_imageTransition = .fade
        return view
    }()
    
    private lazy var detailButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("Veja mais", for: .normal)
        
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)

        button.backgroundColor = .white
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle(" + Adicionar", for: .normal)
        
        button.setupWithMainColors()

        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainImageView()
        constrainDetailButton()
        constrainTitleLabel()
        constrainFavoriteButton()
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
        
        detailButton.layer.cornerRadius = 8
        favoriteButton.layer.cornerRadius = 8
    }
    
    func configure(_ tvShow: TVShowCodable?) {
        guard let tvShow = tvShow else {
            return
        }

        if let url = tvShow.image?.original {
            imageView.sd_setImage(with: url)
        }
        
        let text = "Não perca HOJE a série \(tvShow.name ?? "")!"
        titleLabel.text = text
    }
   
    private func constrainDetailButton() {
        constrainSubView(view: detailButton,
                         bottom: -50,
                         width: 120,
                         height: 44,
                         x: -70
        )
    }
    
    private func constrainFavoriteButton() {
        constrainSubView(view: favoriteButton,
                         bottom: -50,
                         width: 120,
                         height: 44,
                         x: 70
        )
    }
    
    private func constrainImageView() {
        constrainSubView(view: imageView,
                                     top: 0,
                                     bottom: 0, left: 0,
                                     right: 0)
    }
    
    private func constrainTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: detailButton.topAnchor, constant: -20),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 27),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -27)
        ])
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor.clear.cgColor
        let colorBottom = Colors.backGroundColor.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.8, 1.0]
        gradientLayer.frame = self.bounds
                
        imageView.layer.insertSublayer(gradientLayer, at:0)
    }
}
