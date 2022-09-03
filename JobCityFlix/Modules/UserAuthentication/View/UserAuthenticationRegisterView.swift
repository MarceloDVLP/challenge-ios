import UIKit

struct User {
    let name: String?
    let email: String?
    let pin: String?
}

protocol UserAuthenticationRegisterViewDelegate: AnyObject {
    func didTapCancel()
    func didTapConfirm(_ user: User)
}

final class UserAuthenticationRegisterView: UIView {
    
    weak var delegate: UserAuthenticationRegisterViewDelegate?
    
    private lazy var userTextField: TextFieldWithPadding = {
        let userTextField = TextFieldWithPadding(frame: .zero,
                                                 textPadding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 10),
                                                 placeHolder: "Name:")
        userTextField.autocapitalizationType = .none
        userTextField.autocorrectionType = .no
        userTextField.tag = 1
        return userTextField
    }()
    
    private lazy var emailTextField: TextFieldWithPadding = {
        let emailTextField = TextFieldWithPadding(frame: .zero,
                                                  textPadding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 10),
                                                  placeHolder: "E-mail:")
        emailTextField.autocorrectionType = .no
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        userTextField.tag = 2
        return emailTextField
    }()
    
    private lazy var pinTextField: TextFieldWithPadding = {
        let pinTextField = TextFieldWithPadding(frame: .zero,
                                                textPadding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 10),
                                                placeHolder: "Pin:")
        pinTextField.keyboardType = .numberPad
        pinTextField.isSecureTextEntry = true
        userTextField.tag = 3
        return pinTextField
    }()
    
    private lazy var signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.filledStyle(title: "Confirm")
        signInButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        return signInButton
    }()
    
    private lazy var cancelButton: UIButton = {
        let signInButton = UIButton()
        signInButton.transparentStyle(title: "Cancel")
        signInButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        return signInButton
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        constrainStackView()
        constrainTextFields()
        constrainButtons()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constrainStackView() {
        constrainSubView(view: stackView, top: 0, left: 0, right: 0)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            buttonStackView.widthAnchor.constraint(equalToConstant: 200),
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        buttonStackView.addArrangedSubview(signInButton)
        buttonStackView.addArrangedSubview(cancelButton)
    }
    
    func constrainTextFields() {
        let textFields = [userTextField, emailTextField, pinTextField]
        
        var constraints: [NSLayoutConstraint] = []
        for textField in textFields {
            constraints.append(textField.heightAnchor.constraint(equalToConstant: TextFieldWithPadding.size.height))
            stackView.addArrangedSubview(textField)
        }
        
        NSLayoutConstraint.activate(constraints)
    }

    func constrainButtons() {
        let buttons = [signInButton, cancelButton]
        
        var constraints: [NSLayoutConstraint] = []
        for button in buttons {
            constraints.append(button.heightAnchor.constraint(equalToConstant: TextFieldWithPadding.size.height))
                               
            
            buttonStackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func didTapConfirm() {
        let user = User(name: userTextField.text,
                        email: emailTextField.text,
                        pin: pinTextField.text)
        
        delegate?.didTapConfirm(user)
    }
    
    @objc func didTapCancel() {
        delegate?.didTapCancel()
    }
}
