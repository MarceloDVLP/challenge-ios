import UIKit

extension UIButton {

    func setupWithMainColors() {
        setTitleColor(Colors.titleColor, for: .normal)
        setTitleColor(Colors.titleInactiveColor, for: .highlighted)
    }
}
