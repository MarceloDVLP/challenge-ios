import UIKit


protocol UserAuthenticationViewDelegate: AnyObject {
    func didTapCancel()
    func didTapConfirm(_ user: User)
    
    func didTapRegister()
    func didTapSignIn(_ userName: String?, _ pin: String?)
    func didTapSignInFaceID()
}

final class UserAuthenticationView: UIView {
    
    weak var delegate: UserAuthenticationViewDelegate?
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bg")!)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: UIImage(named: "login-logo")!)
        logoImageView.contentMode = .scaleAspectFit

        return logoImageView
    }()
    
    private lazy var registerView: UserAuthenticationRegisterView = {
        let registerView = UserAuthenticationRegisterView()
        registerView.delegate = self
        return registerView
    }()

    private lazy var loginView: UserAuthenticationLoginView = {
        let loginView = UserAuthenticationLoginView()
        loginView.delegate = self
        return loginView
    }()
    
    private lazy var containerView: UIView = {
        return UIView()
    }()
    
    private var containerViewBottomConstant: NSLayoutConstraint?
    
    init() {
        super.init(frame: .zero)
        constraintBackgroundImageView()
        constraintContainerView()
        constraintLoginView()
        constraintRegisterView()
        constraintLogoImageView()
        addKeyBoardObservers()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    @objc private func didTapView() {
        endEditing(true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
    }
    
    private func constraintBackgroundImageView() {
        constrainSubView(view: backgroundImageView, top: 0, left: 0, right: 0, height: UIScreen.main.bounds.height-250)
    }
    
    private func constraintContainerView() {
        constrainSubView(view: containerView, width: 300, height: 400)

        let constraint = containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        self.containerViewBottomConstant = constraint

        NSLayoutConstraint.activate([
            constraint,
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func constraintLoginView() {
        containerView.constrainSubView(view: loginView, top: 0, bottom: 0, left: 0, right: 0)
    }
    
    private func constraintRegisterView() {
        registerView.alpha = 0
        containerView.constrainSubView(view: registerView, top: 0, bottom: 0, left: 0, right: 0)
    }
    
    private func setGradientBackground() {
        backgroundColor = UIColor.black
        let colorTop =  UIColor.black.withAlphaComponent(0.3).cgColor
        let colorBottom = UIColor.black.cgColor
        backgroundImageView.gradientLayer(colorTop: colorTop, colorBottom: colorBottom)
    }
    
    private func constraintLogoImageView() {
        constrainSubView(view: logoImageView, width: 300, height: 200)
                
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
        ])
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserAuthenticationView {
    
    private func addKeyBoardObservers() {
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
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            containerViewBottomConstant?.constant = -keyboardHeight

            UIView.animate(withDuration: 0.1, animations: {

                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        containerViewBottomConstant?.constant = -100
        UIView.animate(withDuration: 0.1, animations: {

            self.layoutIfNeeded()
        }, completion: nil)
    }
}

//MARK: Public Inputs
extension UserAuthenticationView {

    public func showLogin() {
        registerView.alpha = 0
        loginView.alpha = 1
    }
    
    public func showRegister() {
        registerView.alpha = 1
        loginView.alpha = 0
    }
}

extension UserAuthenticationView: UserAuthenticationLoginViewDelegate {

    func didTapRegister() {
        delegate?.didTapRegister()
    }
    
    func didTapSignIn(_ userName: String?, _ pin: String?) {
        delegate?.didTapSignIn(userName, pin)
    }
    
    func didTapSignInFaceID() {
        delegate?.didTapSignInFaceID()
    }
}

extension UserAuthenticationView: UserAuthenticationRegisterViewDelegate {

    func didTapCancel() {
        delegate?.didTapCancel()
    }
    
    func didTapConfirm(_ user: User) {
        delegate?.didTapConfirm(user)
    }
}

