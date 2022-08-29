//
//  TVShowMainHeader.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 28/08/22.
//

import UIKit

final class TVShowMainHeader: UICollectionReusableView {

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var detailButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("Veja mais", for: .normal)
        
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(.clear, for: .highlighted)
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainImageView()
        constrainDetailButton()
        constrainTitleLabel()
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
        detailButton.circularShadow()
    }
    
    func configure(_ tvShow: TVShowCodable) {
        let url = URL(string: tvShow.image!.original!)
        imageView.sd_setImage(with: url)
        let text = "Não perca HOJE a série \(tvShow.name ?? "")!"
        titleLabel.text = text
    }
   
    private func constrainDetailButton() {
        constrainSubView(view: detailButton,
                         bottom: -50,
                         width: 120,
                         height: 40,
                         x: 0
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
        let colorBottom = UIColor.darkGray.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.8, 1.0]
        gradientLayer.frame = self.bounds
                
        imageView.layer.insertSublayer(gradientLayer, at:0)
    }
}
