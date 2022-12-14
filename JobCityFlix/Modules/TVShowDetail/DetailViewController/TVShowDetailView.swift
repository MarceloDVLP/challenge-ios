import UIKit

protocol TVShowDetailViewDelegate: AnyObject {
    func didTapSeasonButton()
    func didTapEpisode(_ episode: Episode)
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView)
    func didTapFavorite()
}

enum TVShowDetailSection: Int, CaseIterable {
    case detail = 0
    case menu = 1
    case season = 2
    case episodes = 3
    case about = 4
}

final class TVShowDetailView: UIView {
    
    weak var delegate: TVShowDetailViewDelegate?
    var isFavorited: Bool = false
    
    public lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    var episodes: [[Episode]] = [[]]
    var seasons: [String] = []
    var selectedSeason = 0
    var tvShow: TVShowModel?
    var selectedMenu = TVShowDetailMenu.episodes
    
    init() {
        super.init(frame: .zero)
        constrainCollectionView()
        registerCell()
        backgroundColor = Colors.backGroundColor
        collectionView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constrainCollectionView() {
        constrainSubView(view: collectionView, top: -100, bottom: 0, left: 0, right: 0)
    }
    
    private func registerCell() {
        collectionView.register(TVShowEpisodeCell.self, forCellWithReuseIdentifier: "TVShowEpisodeCell")
        collectionView.register(TVShowDetailNavigationMenuCell.self, forCellWithReuseIdentifier: "TVShowDetailNavigationMenuCell")
        collectionView.register(TVShowDetailCell.self, forCellWithReuseIdentifier: "TVShowDetailCell")
        collectionView.register(SeasonButtonCell.self, forCellWithReuseIdentifier: "SeasonButtonCell")
        collectionView.register(TVShowAboutCell.self, forCellWithReuseIdentifier: "TVShowAboutCell")
    }
    
    public func show(_ episodes: [[Episode]],  _ seasons: [String]) {
        self.episodes = episodes
        self.seasons = seasons
        collectionView.reloadData()
    }
    
    public func show(_ seasonIndex: Int) {
        self.selectedSeason = seasonIndex
        collectionView.reloadData()
    }
    
    public func show(_ detail: TVShowModel, _ isFavorited: Bool) {
        self.tvShow = detail
        self.isFavorited = isFavorited
        collectionView.reloadData()
    }
    
    
    func numberOfSeasons(for section: Int) -> Int {
        return selectedMenu == .episodes ? 1 : 0
    }
    
    func numberOfepisodes(for section: Int) -> Int {
        if episodes.isEmpty {
            return 0
        }
        
        if selectedMenu == .episodes {
            return episodes[selectedSeason].count
        }
        
        return 0
    }
}

extension TVShowDetailView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        TVShowDetailSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            switch TVShowDetailSection(rawValue: section)! {
            case .detail: return 1
            case .menu: return 1
            case .season: return numberOfSeasons(for: section)
            case .episodes: return numberOfepisodes(for: section)
            case .about: return 1
            }
    }
    
    private func dequeueNavigationMenuCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowDetailNavigationMenuCell", for: indexPath) as! TVShowDetailNavigationMenuCell
        
        cell.didSelectMenu = { [weak self] menu in
            self?.selectedMenu = menu
            self?.collectionView.reloadData()
        }
        
        return cell
    }

    private func dequeueEpisodeCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> TVShowEpisodeCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowEpisodeCell", for: indexPath) as! TVShowEpisodeCell
        let episodes = episodes[selectedSeason]
        
        cell.configure(episodes[indexPath.item])
        return cell
    }

    private func dequeueDetailCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> TVShowDetailCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowDetailCell", for: indexPath) as! TVShowDetailCell
        cell.delegate = self
        cell.configure(tvShow, isFavorited: isFavorited)
        return cell
    }
    
    private func dequeueSeasonCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> SeasonButtonCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonButtonCell", for: indexPath) as! SeasonButtonCell
        
        if episodes.indices.contains(selectedSeason) {
            cell.show(season: selectedSeason+1, episodes: episodes[selectedSeason].count)
        }        
        
        cell.didTapSeasonButton = { [weak self] in
            self?.didTapSeasonButton()
        }
        
        return cell
    }
    
    private func dequeueAboutCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> TVShowAboutCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowAboutCell", for: indexPath) as! TVShowAboutCell
        cell.configure(tvShow)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch TVShowDetailSection(rawValue: indexPath.section)! {
            case .detail: return dequeueDetailCell(collectionView, indexPath)
            case .menu: return dequeueNavigationMenuCell(collectionView, indexPath)
            case .season: return dequeueSeasonCell(collectionView, indexPath)
            case .episodes: return dequeueEpisodeCell(collectionView, indexPath)
            case .about: return dequeueAboutCell(collectionView, indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch TVShowDetailSection.init(rawValue: section) {
        case .detail: return .zero
        default: return UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
        }
    }
}

extension TVShowDetailView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let episode = episodes[selectedSeason][indexPath.item]
        delegate?.didTapEpisode(episode)        
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewWillBeginDecelerating(scrollView)
    }
}

extension TVShowDetailView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        
        switch TVShowDetailSection(rawValue: indexPath.section)! {
        case .detail: return CGSize(width: collectionView.frame.width, height: 650)
        case .menu: return CGSize(width: collectionView.frame.width-32, height: 30)
        case .season: return CGSize(width: collectionView.frame.width-32, height: 30)
        case .episodes: return CGSize(width: collectionView.frame.width-32, height: 150)
        case .about:
            
            let height = (tvShow?.summary?.htmlToString.height(constraintedWidth: collectionView.frame.width-32, font: UIFont.systemFont(ofSize: 15, weight: .regular)) ?? 0) + 300

            return CGSize(width: collectionView.frame.width-32, height: height)
            
        }
    }
}

extension TVShowDetailView: TVShowDetailCellDelegate {

    func didTapFavorite() {
        delegate?.didTapFavorite()
    }

    func didTapSeasonButton() {
        delegate?.didTapSeasonButton()
    }
}


