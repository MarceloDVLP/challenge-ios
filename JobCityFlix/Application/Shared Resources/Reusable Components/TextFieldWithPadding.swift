import UIKit

class TextFieldWithPadding: UITextField {
    
    static var size: CGSize { return CGSize(width: 300, height: 40)}
    
    var textPadding: UIEdgeInsets
       
    init(frame: CGRect, textPadding: UIEdgeInsets, placeHolder: String) {
        self.textPadding = textPadding
        super.init(frame: frame)
        textColor = UIColor.white
        tintColor = UIColor.white
        backgroundColor = Colors.backGroundColor
        attributedPlaceholder = whitePlaceHolder(placeHolder)
        borderStyle = .roundedRect
    }
    
    func whitePlaceHolder(_ string: String)  -> NSAttributedString {
        return NSAttributedString(string: string,
                                  attributes: [NSAttributedString.Key.foregroundColor: Colors.titleColor])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
