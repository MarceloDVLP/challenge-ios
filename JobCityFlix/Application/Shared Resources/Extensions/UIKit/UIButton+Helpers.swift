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
}
