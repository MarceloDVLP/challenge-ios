import UIKit

final class TVShowEpisodeCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mediumTitleColor
        label.font = UIFont.boldSystemFont(ofSize: 14)
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

    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label

    }()

    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "download-icon")!
        button.setImage(image, for: .normal)
        button.setupWithMainColors()
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainImageView()
        constrainTitleLabel()
        constraintDescriptionLabel()
        constrainDownloadButton()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        durationLabel.text = nil
        descLabel.text = nil
        imageView.sd_cancelCurrentImageLoad()
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = 10        
    }
    
    func configure(_ episode: Episode) {
        titleLabel.text = "\(episode.number ?? 0). \(episode.name ?? "")"
        durationLabel.text = "\(episode.runtime ?? 0) min"
        descLabel.text = episode.summary
        let url = URL(string: episode.image!.medium!)
        imageView.sd_setImage(with: url)
    }
    
    private func constrainTitleLabel() {
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(downloadButton)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: downloadButton.leftAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    private func constrainImageView() {
        constrainSubView(view: imageView, top: 0, left: 0, width: 150)
        
        imageView.addConstraint(NSLayoutConstraint(item: imageView,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: imageView,
                                                  attribute: .width,
                                                  multiplier: 9.0 / 16.0,
                                                  constant: 0))
    }
    
    private func constraintDescriptionLabel() {
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            descLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            descLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
    }
    
    private func constrainDownloadButton() {
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(downloadButton)
        
        NSLayoutConstraint.activate([
            downloadButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            downloadButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            downloadButton.heightAnchor.constraint(equalToConstant: 30),
            downloadButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct TVShowEpisode {
    
}
