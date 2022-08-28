import UIKit

extension UIView {
    
    func constrainSubView(view: UIView,
                          top: CGFloat? = nil,
                          bottom: CGFloat? = nil,
                          left: CGFloat? = nil,
                          right: CGFloat? = nil,
                          width: CGFloat? = nil,
                          height: CGFloat? = nil
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
            constraints.append(view.widthAnchor.constraint(equalTo: widthAnchor, constant: width))
        }

        if let height = height {
            constraints.append(view.heightAnchor.constraint(equalTo: heightAnchor, constant: height))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
}
