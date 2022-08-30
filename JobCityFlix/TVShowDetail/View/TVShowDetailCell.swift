import UIKit
import SDWebImage


enum Colors {
    static let mediumTitleColor = UIColor.white
    static let backGroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00)
    static let titleColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.00)
    static let titleInactiveColor = UIColor(red: 0.37, green: 0.37, blue: 0.37, alpha: 1.00)
    static let lineColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
    static let activeLineColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.00)
}

final class TVShowDetailCell: UICollectionViewCell {
    
    let episodeList = TVShowEpisodeListView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ tvShow: TVShowCodable?, _ episodes: [Episode]) {
        episodeList.show(episodes)
    }
        
    private func setupMenu() {
        let menuView = TVShowDetailMenuView()
        constrainSubView(view: menuView, top: 100, left: 10, right: 0, height: 30)

        constrainSubView(view: episodeList, bottom: 0, left: 20, right: 0)
        NSLayoutConstraint.activate([
            episodeList.topAnchor.constraint(equalTo: menuView.bottomAnchor, constant: 20)
        ])
    }
}


extension UIView {
    
    func constraintRelated(in view: UIView, top: CGFloat? = nil) {

        var constraints: [NSLayoutConstraint] = []
        
        if let top = top {
            constraints.append(view.topAnchor.constraint(equalTo: topAnchor, constant: top))
        }

        NSLayoutConstraint.activate(constraints)
    }
}
