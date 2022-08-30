import UIKit

protocol TVShowDetailViewDelegate: AnyObject {
    func didTapSeasonButton()
}

final class TVShowDetailView: UIView {
    
    weak var delegate: TVShowDetailViewDelegate?
    
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
    var item: TVShowCodable?

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
        constrainSubView(view: collectionView, top: 0, bottom: 0, left: 0, right: 0)
    }
    
    private func registerCell() {
        collectionView.register(TVShowDetailCell.self,
                                forCellWithReuseIdentifier: "TVShowDetailCell")
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
}

extension TVShowDetailView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowDetailCell", for: indexPath) as! TVShowDetailCell
        
        cell.configure(nil, episodes[selectedSeason], self)
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TVShowDetailMainHeader", for: indexPath) as! TVShowDetailMainHeader
//        
//        let randomInt = Int.random(in: 0..<items.count)
//        cell.configure(items[randomInt])
//        
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension TVShowDetailView: UICollectionViewDelegate {
    
}

extension TVShowDetailView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        
//        let height = collectionView.frame.height*0.6
//
//        return CGSize(width: collectionView.frame.width, height: height)
//    }
}


extension TVShowDetailView: TVShowDetailCellDelegate {

    func didTapSeasonButton() {
        delegate?.didTapSeasonButton()
    }
}
