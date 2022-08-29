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
}
