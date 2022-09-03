import UIKit

extension UIButton {

    func setupWithMainColors() {
        setTitleColor(Colors.titleColor, for: .normal)
        setTitleColor(Colors.titleInactiveColor, for: .highlighted)
    }
    
    func alignImageToRight() {
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            semanticContentAttribute = .forceLeftToRight
        }
        else {
            semanticContentAttribute = .forceRightToLeft
        }
    }
    
    func filledStyle(title: String, with radius: CGFloat = 20) {
        backgroundColor = .darkGray
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = radius
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        setTitleColor(.lightGray, for: .highlighted)
    }

    func transparentStyle(title: String, with radius: CGFloat = 20) {
        backgroundColor = .clear
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = radius
        layer.borderWidth = 2

        let attributedString = NSAttributedString(string: title, attributes:
                                                    [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                    .foregroundColor: UIColor.white])

        let highlightedString = NSAttributedString(string: title, attributes:
                                                    [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                    .foregroundColor: UIColor.lightGray])

        setAttributedTitle(attributedString, for: .normal)
        setAttributedTitle(highlightedString, for: .highlighted)
    }
}
