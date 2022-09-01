import UIKit

final class TVShowEPisodeDetailViewController: UIViewController {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = Colors.backGroundColor
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_imageTransition = .fade(duration: 0.2)
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private lazy var qualityImageView: UIImageView = {
        let image = UIImage(named: "hd-icon")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var clockImageView: UIImageView = {
        let image = UIImage(named: "clock")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mediumTitleColor
        label.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        label.numberOfLines = 2
        return label
    }()

    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.titleInactiveColor
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Colors.titleColor
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var sumaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = Colors.titleColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("X", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        return button
    }()
            
    let scrollView = UIScrollView()
    let contentSumaryView = UIView()

    public init(episode: Episode) {
        super.init(nibName: nil, bundle: nil)
        constrainSubviews()
        scrollView.isDirectionalLockEnabled = true 
        configure(episode)
    }
    
    private func constrainSubviews() {
        constrainContainerView()
        constrainImageView()
        constrainTitleLabel()
        constraintQualityImage()
        constraintClockImageView()
        constraintDescriptionLabel()
        constraintSubtitleLabel()
        constraintSumaryLabel()
        constrainCloseButton()
        
        containerView.constrainSubView(view: scrollView, bottom: 0, left: 0, right: 0)
        scrollView.constrainSubView(view: contentSumaryView, top: 0, bottom:0, left: 0, right: 0)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: qualityImageView.bottomAnchor, constant: 10),
            contentSumaryView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        scrollView.alwaysBounceVertical = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.layer.cornerRadius = 10
        closeButton.layer.cornerRadius = closeButton.frame.height/2
        setupContainverViewGradient()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 0.1, animations: {
            self.setupTranslucentBackground()
        })

    }
    
    func constrainContainerView() {
        containerView.backgroundColor = Colors.backGroundColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 350),
            containerView.heightAnchor.constraint(equalToConstant: 500),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupTranslucentBackground() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    func setupContainverViewGradient() {
        let colorTop =  UIColor.clear.cgColor
        let colorBottom = Colors.backGroundColor.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.frame = imageView.bounds
                
        imageView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func color(for rating: Double) -> UIColor {
        if rating <= 5 {
            return UIColor.red
        } else if rating <= 6.5 {
            return UIColor.blue
        } else if rating <= 8 {
            return UIColor.systemBlue
        } else {
            return UIColor.green
        }
    }
    
    func configure(_ episode: Episode) {
        titleLabel.text = "\(episode.name ?? "") - S0\(episode.season ?? 0) - E0\(episode.number ?? 0)"
        subtitleLabel.text = "\(episode.airtime ?? "")  -  \(episode.runtime ?? 0)min"
        
        if let image = episode.image?.original {
            let url = URL(string: image)
            imageView.sd_setImage(with: url)
        }        

        sumaryLabel.text = episode.summary?.htmlToString
        setupScrollViewHeight(episode.summary!.htmlToString)
    }
    
    func setupScrollViewHeight(_ summary: String) {
        let height = summary.height(constraintedWidth: containerView.frame.width,
                                    font: UIFont.systemFont(ofSize: 15, weight: .regular)) + 30
        view.layoutIfNeeded()
        NSLayoutConstraint.activate([
            contentSumaryView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func getYear(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let date = dateFormatter.date(from: date)!
        
        let dateFormatterYear = DateFormatter()
        dateFormatterYear.dateFormat = "yyyy"
        return dateFormatterYear.string(from: date)
    }
    
    private func constrainTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 27),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -27),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -40)
        ])
    }
    
    private func constraintQualityImage() {
        qualityImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(qualityImageView)
        
        NSLayoutConstraint.activate([
            qualityImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            qualityImageView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor)
        ])
    }
    
    private func constraintClockImageView() {
        clockImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(clockImageView)
        
        NSLayoutConstraint.activate([
            clockImageView.centerYAnchor.constraint(equalTo: qualityImageView.centerYAnchor),
            clockImageView.leftAnchor.constraint(equalTo: qualityImageView.rightAnchor, constant: 4),
            clockImageView.widthAnchor.constraint(equalToConstant: 15),
            clockImageView.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
    
    private func constraintSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            subtitleLabel.leftAnchor.constraint(equalTo: clockImageView.rightAnchor, constant: 12),
            subtitleLabel.centerYAnchor.constraint(equalTo: clockImageView.centerYAnchor)
        ])
    }
    
    private func constrainImageView() {
        containerView.constrainSubView(view: imageView, top: 0, left: 0, right: 0, height: 230)
        imageView.clipsToBounds = true
    }
    
    private func constraintDescriptionLabel() {
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: qualityImageView.bottomAnchor, constant: 16),
            descLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            descLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8)
        ])
    }

    private func constraintSumaryLabel() {
        contentSumaryView.constrainSubView(view: sumaryLabel, top: 0, left: 27, right: -27)
    }

    private func constrainCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
        ])
    }
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





extension String {
    
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()

        return label.frame.height
    }
}
