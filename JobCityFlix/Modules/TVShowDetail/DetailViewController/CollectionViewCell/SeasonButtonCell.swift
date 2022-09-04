import UIKit
final class SeasonButtonCell: UICollectionViewCell {

    var didTapSeasonButton: (() -> ())?
    
    lazy var seasonButton: UIButton = {
        let button = UIButton()
        button.setupWithMainColors()
        
        let image = UIImage(named: "arrow-down")!
        button.setImage(image, for: .normal)

        button.contentHorizontalAlignment = .left
        button.alignImageToRight()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        return button
    }()
    
    lazy var totalEpisodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.titleInactiveColor
        return label
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           constrainSubView(view: seasonButton, top: 0, left: 0, width: 130, height: 30)
           
           addSubview(totalEpisodeLabel)
           totalEpisodeLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               totalEpisodeLabel.leftAnchor.constraint(equalTo: seasonButton.rightAnchor, constant: 8),
               totalEpisodeLabel.centerYAnchor.constraint(equalTo: seasonButton.centerYAnchor)
           ])
           
           seasonButton.addTarget(self, action: #selector(didTapSeasonButtonFunc), for: .touchUpInside)
       }
       
    func show(season: Int, episodes: Int) {
        let seasonTitle = "\(season)ª Temporada   "
        seasonButton.setTitle(seasonTitle, for: .normal)
        totalEpisodeLabel.text = "\(episodes) episódios"
    }
        
    @objc func didTapSeasonButtonFunc(_ sender: UIButton) {
        didTapSeasonButton?()
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
}
