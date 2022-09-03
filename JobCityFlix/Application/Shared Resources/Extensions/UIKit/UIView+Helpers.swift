import UIKit

extension UIView {
    
    func constrainSubView(view: UIView,
                          top: CGFloat? = nil,
                          bottom: CGFloat? = nil,
                          left: CGFloat? = nil,
                          right: CGFloat? = nil,
                          width: CGFloat? = nil,
                          height: CGFloat? = nil,
                          x: CGFloat? = nil,
                          y: CGFloat? = nil
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        var constraints: [NSLayoutConstraint] = []
        
        if let top = top {
            constraints.append(view.topAnchor.constraint(equalTo: topAnchor, constant: top))
        }

        if let left = left {
            constraints.append(view.leftAnchor.constraint(equalTo: leftAnchor, constant: left))
        }

        if let right = right {
            constraints.append(view.rightAnchor.constraint(equalTo: rightAnchor, constant: right))
        }

        if let bottom = bottom {
            constraints.append(view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottom))
        }

        if let width = width {
            constraints.append(view.widthAnchor.constraint(equalToConstant: width))
        }

        if let height = height {
            constraints.append(view.heightAnchor.constraint(equalToConstant: height))
        }
        
        if let x = x {
            constraints.append(view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: x))
        }

        if let y = y {
            constraints.append(view.centerYAnchor.constraint(equalTo: centerYAnchor, constant: y))
        }

        NSLayoutConstraint.activate(constraints)
    }
    
    func circularShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.masksToBounds = false
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.8
        layer.cornerRadius = 8
        layer.frame = frame
    }
    

    func addActivityIndicatorView() {
        let indicator = UIActivityIndicatorView()
        indicator.center = center
        indicator.color = .white
        indicator.style = .large
        addSubview(indicator)
    }
    
    func removeActivityIndicatorView() {
        let loadingView = subviews.first(where: { type(of: $0.self) == UIActivityIndicatorView.self })        
        loadingView?.removeFromSuperview()
    }
    
    func gradientLayer(colorTop: CGColor, colorBottom: CGColor) {
        let name = "gradient_layer"
        let layer = layer.sublayers?.contains(where: { $0.name == name })
        
        guard layer == nil else { return }
        
//        let colorTop =  UIColor.black.withAlphaComponent(0.3).cgColor
//        let colorBottom = UIColor.black.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.name = name
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = bounds

        self.layer.insertSublayer(gradientLayer, at:0)
    }
}

