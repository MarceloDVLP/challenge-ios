//
//  TVShowMainHeader.swift
//  JobCityFlix
//
//  Created by Marcelo Carvalho on 28/08/22.
//

import UIKit

final class TVShowMainHeader: UICollectionReusableView {

    private lazy var imageView: UIImageView = {
        let image = UIImage(named: "re")!
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        return view
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainImageView()
        
        backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constrainImageView() {
        constrainSubView(view: imageView,
                                     top: 0,
                                     bottom: 0, left: 0,
                                     right: 0)
    }
    
    
}
