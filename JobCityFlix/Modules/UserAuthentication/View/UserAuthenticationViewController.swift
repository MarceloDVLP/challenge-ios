import UIKit


final class UserAuthenticationViewController: UIViewController {
    
    deinit {
       print("saiu")
    }
    
    private lazy var userTextField: TextFieldWithPadding = {
        let userTextField = TextFieldWithPadding(frame: .zero, textPadding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 10))
        userTextField.textColor = .white
        userTextField.tintColor = .white
        userTextField.backgroundColor = Colors.backGroundColor
        userTextField.autocapitalizationType = .none
        userTextField.attributedPlaceholder = whitePlaceHolder("E-mail:")
        userTextField.keyboardType = .emailAddress
        userTextField.borderStyle = .roundedRect
        return userTextField
    }()
    
    private lazy var passwordTextField: TextFieldWithPadding = {
        let passwordTextField = TextFieldWithPadding(frame: .zero, textPadding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 10))
        passwordTextField.textColor = UIColor.white
        passwordTextField.tintColor = UIColor.white
        passwordTextField.backgroundColor = Colors.backGroundColor
        passwordTextField.keyboardType = .numberPad
        passwordTextField.isSecureTextEntry = true
        passwordTextField.attributedPlaceholder = whitePlaceHolder("PIN:")
        passwordTextField.borderStyle = .roundedRect
        return passwordTextField
    }()
    
    private lazy var signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.backgroundColor = .darkGray
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.setupWithMainColors()
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return signInButton
    }()
    
    private var recoverButton = UIButton()
    private var imageView: UIImageView!
    private var logoImageView: UIImageView!
    private var centerYConstraint: NSLayoutConstraint!
    
    var interactor: UserAuthenticationInteractor!

    func show(_ error: LoginError) {
        let alertController = UIAlertController()
        alertController.title = error.title
        alertController.message = error.message
        alertController.isSpringLoaded = true
        let action = UIAlertAction(title: "Try Again Now", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            
            self.dismiss(animated: true)
            self.userTextField.becomeFirstResponder()
        })
    }
    
    func showTvShow() {
        guard let window = view.window else { return }
        
        window.rootViewController = TabViewController()
        window.makeKeyAndVisible()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setupBackGroundImageView()
        setupLogoImageView()
        setupUserTextField()
        setupPasswordTextField()
        setupSignInButton()
        setupRecoverButton()
        constrainUserTextField()
        constrainPasswordTextField()
        constrainSignInButton()
        constrainRecoveryButton()
        addKeyBoardObservers()
        interactor.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func addKeyBoardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            centerYConstraint.constant = -keyboardHeight

            UIView.animate(withDuration: 0.2, animations: {

                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        centerYConstraint.constant = -100
        UIView.animate(withDuration: 0.2, animations: {

            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.layer.cornerRadius = 20
        recoverButton.layer.cornerRadius = 20
        signInButton.layer.borderWidth = 2
        setGradientBackground()
    }
    
    func whitePlaceHolder(_ string: String)  -> NSAttributedString {
        return NSAttributedString(string: string,
                                  attributes: [NSAttributedString.Key.foregroundColor: Colors.titleColor])
    }
    
    func constrainUserTextField() {
        view.constrainSubView(view: userTextField, width: 300, height: 40)
        
        NSLayoutConstraint.activate([
            userTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            userTextField.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor)
        ])
    }
    
    func constrainPasswordTextField() {
        view.constrainSubView(view: passwordTextField, width: 300, height: 40)
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 30),
            passwordTextField.centerXAnchor.constraint(equalTo: userTextField.centerXAnchor)
        ])
    }

    func alignCenter(view: UIView, subView: UIView, x: CGFloat = 0, y: CGFloat = 0) {
        NSLayoutConstraint.activate([
            subView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: x),
            subView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: y)
        ])
    }
    
    func constrainSignInButton() {
        view.constrainSubView(view: signInButton, width: 200, height: 40)
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signInButton.centerXAnchor.constraint(equalTo: userTextField.centerXAnchor)
        ])
    }

    func constrainRecoveryButton() {
        view.constrainSubView(view: recoverButton, width: 200, height: 40)
        NSLayoutConstraint.activate([
            recoverButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 15),
            recoverButton.centerXAnchor.constraint(equalTo: userTextField.centerXAnchor)
        ])
    }
    
    func setupUserTextField() {

    }

    func setupPasswordTextField() {
        passwordTextField = TextFieldWithPadding(frame: .zero, textPadding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 10))
        passwordTextField.textColor = UIColor.white
        passwordTextField.tintColor = UIColor.white
        passwordTextField.backgroundColor = Colors.backGroundColor
        passwordTextField.keyboardType = .numberPad
        passwordTextField.isSecureTextEntry = true
        passwordTextField.attributedPlaceholder = whitePlaceHolder("PIN:")
        passwordTextField.borderStyle = .roundedRect
    }

    func setupSignInButton() {
        signInButton.backgroundColor = .darkGray
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.setupWithMainColors()
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    @objc func didTapSignIn() {
        interactor.didTapSignIn(userTextField.text, pin: passwordTextField.text)
    }
    	
    func setupRecoverButton() {
        recoverButton.backgroundColor = .clear
        recoverButton.layer.borderColor = UIColor.white.cgColor
        let attributedString = NSAttributedString(string: "Register", attributes:
                                                    [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                    .foregroundColor: UIColor.white])

        let highlightedString = NSAttributedString(string: "Register", attributes:
                                                    [.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                    .foregroundColor: UIColor.clear])

        recoverButton.setAttributedTitle(attributedString, for: .normal)
        recoverButton.setAttributedTitle(highlightedString, for: .highlighted)

    }
        									
    func setupBackGroundImageView() {
        self.imageView = UIImageView(image: UIImage(named: "bg")!)
        imageView.contentMode = .scaleAspectFill
        view.constrainSubView(view: imageView, top: 0, left: 0, right: 0, height: UIScreen.main.bounds.height-250)
        
    }
    
    func setGradientBackground() {
        let name = "gradient_layer"
        let layer = imageView.layer.sublayers?.contains(where: { $0.name == name })
        
        guard layer == nil else { return }
        
        let colorTop =  UIColor.clear.cgColor
        let colorBottom = UIColor.black.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.name = name
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.frame = imageView.bounds

        imageView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func setupLogoImageView() {
        logoImageView = UIImageView(image: UIImage(named: "login-logo")!)
        logoImageView.contentMode = .scaleAspectFit
        view.constrainSubView(view: logoImageView, width: 300, height: 200)
        
        self.centerYConstraint = logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYConstraint
        ])
    }
}


