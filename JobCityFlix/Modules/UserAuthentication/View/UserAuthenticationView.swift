import UIKit

final class UserAuthenticationView: UIView {
    
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
        return registerView
    }()

    private lazy var loginView: UserAuthenticationLoginView = {
        let loginView = UserAuthenticationLoginView()
        return loginView
    }()
    
    private lazy var containerView: UIView = {
        return UIView()
    }()
    
    private var centerYConstraint: NSLayoutConstraint?
    
    init() {
        super.init(frame: .zero)
        constraintBackgroundImageView()
        constraintContainerView()
        constraintLoginView()
        constraintLogoImageView()
        backgroundColor = UIColor.black
        addKeyBoardObservers()
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
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),

        ])
    }
    
    private func constraintLoginView() {
        containerView.constrainSubView(view: loginView, top: 0, bottom: 0, left: 0, right: 0)
    }
    
    private func setGradientBackground() {
        let name = "gradient_layer"
        let layer = backgroundImageView.layer.sublayers?.contains(where: { $0.name == name })
        
        guard layer == nil else { return }
        
        let colorTop =  UIColor.black.withAlphaComponent(0.3).cgColor
        let colorBottom = UIColor.black.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.name = name
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = backgroundImageView.bounds

        backgroundImageView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func constraintLogoImageView() {
        constrainSubView(view: logoImageView, width: 300, height: 200)
        
        let centerYConstraint = logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100)
        self.centerYConstraint = centerYConstraint
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerYConstraint
        ])
    }
    
    private func showLoginView() {
        
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            centerYConstraint?.constant = -keyboardHeight

            UIView.animate(withDuration: 0.2, animations: {

                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        centerYConstraint?.constant = -100
        UIView.animate(withDuration: 0.2, animations: {

            self.layoutIfNeeded()
        }, completion: nil)
    }
}
