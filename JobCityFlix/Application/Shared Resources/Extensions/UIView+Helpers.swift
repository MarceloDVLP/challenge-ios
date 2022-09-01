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
    
    
    func addGradientLayer() -> CAGradientLayer {
        
//        var gradientColorOne : CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
//        var gradientColorTwo : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor

        let gradientColorOne = UIColor.lightGray.cgColor
        let gradientColorTwo = UIColor.lightGray.cgColor //UIColor(red: 206/255, green: 10/255, blue: 10/255, alpha: 0.2).cgColor
                                    
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        self.layer.addSublayer(gradientLayer)
        
        return gradientLayer
    }
    
    func addAnimation() -> CABasicAnimation {
       
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 0.9
        return animation
    }
    
    func startAnimatingShimmer() {
        
        let gradientLayer = addGradientLayer()
        let animation = addAnimation()
       
        gradientLayer.add(animation, forKey: animation.keyPath)
    }


    func startShimmeringEffect() {
                                    let light = UIColor.white.cgColor
                                    let alpha = UIColor(red: 206/255, green: 10/255, blue: 10/255, alpha: 0.7).cgColor
                                    let gradient = CAGradientLayer()
                                    gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3 * self.bounds.size.width, height: self.bounds.size.height)
                                    gradient.colors = [light, alpha, light]
                                    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
                                    gradient.endPoint = CGPoint(x: 1.0,y: 0.525)
                                    gradient.locations = [0.35, 0.50, 0.65]
                                    self.layer.mask = gradient
                                    let animation = CABasicAnimation(keyPath: "locations")
                                    animation.fromValue = [0.0, 0.1, 0.2]
                                    animation.toValue = [0.8, 0.9,1.0]
                                    animation.duration = 1.5
                                    animation.repeatCount = HUGE
                                    gradient.add(animation, forKey: "shimmer")
                                    }

                                    func stopShimmeringEffect() {
                                    self.layer.mask = nil
                                    }

}

extension UIViewController {

    func setupNavigationImage(_ name :String) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        let logoContainer = UIView(frame: frame)
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFit

        let image = UIImage(named: name)
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
    }
    
    func showNavigationFor(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)

        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
