import UIKit

final class TVShowEpisodeListView: UIView {

    var didTapSeasonButton: (() -> ())?
    
    lazy var seasonButton: UIButton = {
        let button = UIButton()
        button.setupWithMainColors()
        
        let image = UIImage(named: "arrow-down")!
        button.setImage(image, for: .normal)

        button.contentHorizontalAlignment = .left
        button.alignImageToRight()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.setTitle("2ª Temporada  ", for: .normal)
        return button
    }()
    
    lazy var totalEpisodeLabel: UILabel = {
        let label = UILabel()
        label.text = "19 episódios"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.titleInactiveColor
        return label
    }()
    
    var didSelectTVShow: ((TVShowCodable) ->())?
    
    public lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear

        return collection
    }()
    
    var episodes: [Episode] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainSubView(view: seasonButton, top: 0, left: 0, width: 130, height: 30)
        
        addSubview(totalEpisodeLabel)
        totalEpisodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalEpisodeLabel.leftAnchor.constraint(equalTo: seasonButton.rightAnchor, constant: 8),
            totalEpisodeLabel.centerYAnchor.constraint(equalTo: seasonButton.centerYAnchor)
        ])
        
        constrainCollectionView()
        registerCell()
        seasonButton.addTarget(self, action: #selector(didTapSeasonButtonFunc), for: .touchUpInside)

    }
    
    func show(_ episodes: [Episode]) {
        self.episodes = episodes
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constrainCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc func didTapSeasonButtonFunc(_ sender: UIButton) {
        didTapSeasonButton?()
    }
    
    private func registerCell() {
        collectionView.register(TVShowEpisodeCell.self,
                                forCellWithReuseIdentifier: "TVShowEpisodeCell")
    }
}

extension TVShowEpisodeListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowEpisodeCell", for: indexPath) as? TVShowEpisodeCell {
            cell.configure(episodes[indexPath.item])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TVShowMainHeader", for: indexPath) as! TVShowMainHeader
//
//        cell.configure(items.first)
//
//        return cell
//    }
        
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//    }
}

extension TVShowEpisodeListView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapSeasonButton?()
    }
}

extension TVShowEpisodeListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//        let height = collectionView.frame.height*0.6
//
//        return CGSize(width: collectionView.frame.width, height: height)
//    }
}



extension UIButton {
    
    func setupWithMainColors() {
        setTitleColor(Colors.mediumTitleColor, for: .normal)
        setTitleColor(Colors.titleInactiveColor, for: .highlighted)
    }
    
    func alignImageToRight() {
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            semanticContentAttribute = .forceLeftToRight
        }
        else {
            semanticContentAttribute = .forceRightToLeft
        }
    }
}


final class SeasonListViewController: UIViewController {
    
    var seasons: [String]
    var selectedIndex: Int
    
    public lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear

        return collection
    }()

    
    init(seasons: [String], selectedIndex: Int) {
        self.seasons = seasons
        self.selectedIndex = selectedIndex
        super.init(nibName: nil, bundle: nil)
        setupBlurBackGround()
        
        view.constrainSubView(view: collectionView, top: 0, bottom: 0, left: 0, right: 0)
    
        registerCell()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBlurBackGround() {
        
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.constrainSubView(view: blurView, top: 0, bottom: 0, left: 0, right: 0)
    }
    
    private func registerCell() {
        collectionView.register(SeasonCell.self, forCellWithReuseIdentifier: "SeasonCell")
    }
    
    public func configure(_ seasons: [String], _ selectedIndex: Int) {
        self.seasons = seasons
        collectionView.reloadData()
    }
}

extension SeasonListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCell", for: indexPath) as? SeasonCell {
            cell.configure(season: seasons[indexPath.item], isSelected: indexPath.item == selectedIndex)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let items = collectionView.visibleCells.count
        let height = collectionView.frame.height/3-(30*CGFloat(items))/2
        return UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
    }
}

extension SeasonListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true)
    }
}

extension SeasonListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}

final class SeasonCell: UICollectionViewCell {
    
    private lazy var seasonLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constrainSubView(view: seasonLabel, top: 0, left: 0, right: 0)
    }
    
    public func configure(season: String, isSelected: Bool) {
        seasonLabel.text = season
        
        if isSelected {
            seasonLabel.font = UIFont.boldSystemFont(ofSize: 20)
            seasonLabel.textColor = Colors.mediumTitleColor
        } else {
            seasonLabel.font = UIFont.systemFont(ofSize: 17)
            seasonLabel.textColor = .lightGray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
