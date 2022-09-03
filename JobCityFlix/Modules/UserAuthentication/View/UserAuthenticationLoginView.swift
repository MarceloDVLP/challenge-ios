import UIKit


protocol UserAuthenticationLoginViewDelegate: AnyObject {
    func didTapRegister()
    func didTapSignIn(_ userName: String?, _ pin: String?)
    func didTapSignInFaceID()
}

final class UserAuthenticationLoginView: UIView {

    weak var delegate: UserAuthenticationLoginViewDelegate?

    private lazy var userTextField: TextFieldWithPadding = {
        let userTextField = TextFieldWithPadding(frame: .zero, textPadding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 10), placeHolder: "E-mail:")
        userTextField.autocorrectionType = .no
        userTextField.autocapitalizationType = .none

        return userTextField
    }()
    
    private lazy var pinTextField: TextFieldWithPadding = {
        let pinTextField = TextFieldWithPadding(frame: .zero, textPadding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 10), placeHolder: "PIN:")
        pinTextField.keyboardType = .numberPad
        pinTextField.isSecureTextEntry = true
        return pinTextField
    }()
    
    private lazy var signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.filledStyle(title: "Sign In")
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return signInButton
    }()

    private lazy var signInFaceIDButton: UIButton = {
        let registerButton = UIButton()
        registerButton.transparentStyle(title: "Sign In FaceID")
        registerButton.addTarget(self, action: #selector(didTapSignInFaceID), for: .touchUpInside)
        return registerButton
    }()
    
    private lazy var registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.transparentStyle(title: "Register")
        registerButton.layer.borderWidth = 0
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        return registerButton
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
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
        constrainSubView(view: textFieldStackView, top: 0, left: 0, right: 0)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 30),
            buttonStackView.widthAnchor.constraint(equalToConstant: 200),
            buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func constrainTextFields() {
        let textFields = [userTextField, pinTextField]
        var constraints: [NSLayoutConstraint] = []
        for textField in textFields {
            constraints.append(textField.heightAnchor.constraint(equalToConstant: TextFieldWithPadding.size.height))
            textFieldStackView.addArrangedSubview(textField)
        }
        NSLayoutConstraint.activate(constraints)
    }

    func constrainButtons() {
        let buttons = [signInButton, signInFaceIDButton, registerButton]
        var constraints: [NSLayoutConstraint] = []
        for button in buttons {
            constraints.append(button.heightAnchor.constraint(equalToConstant: TextFieldWithPadding.size.height))
            buttonStackView.addArrangedSubview(button)
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func didTapSignIn() {
        delegate?.didTapSignIn(userTextField.text, pinTextField.text)
    }

    @objc func didTapSignInFaceID() {
        delegate?.didTapSignInFaceID()
    }
    
    @objc func didTapRegister() {
        delegate?.didTapRegister()
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}
