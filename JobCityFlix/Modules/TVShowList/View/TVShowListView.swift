import UIKit


final class TVShowListView: UIView {
    
    var didSelectTVShow: ((TVShowCodable) ->())?
    var didFavoriteTVShow: ((TVShowCodable) ->())?
    var didFinishPage: (() -> ())?
    var scrollViewWillBeginDecelerating: ((UIScrollView) -> ())?

    //MARK: REMOVER ISSO!!
    var navigationController: UINavigationController?
    
    public lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    var items: [TVShowCodable] = []
    
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
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 900)
        ])
    }
    
    private func registerCell() {
        collectionView.register(TVShowListCell.self,
                                forCellWithReuseIdentifier: "TVShowListCell")
        collectionView.register(TVShowMainHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TVShowMainHeader")
    }
}

extension TVShowListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowListCell", for: indexPath) as? TVShowListCell {            
            cell.configure(items[indexPath.item])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TVShowMainHeader", for: indexPath) as! TVShowMainHeader
        cell.delegate = self
        if  items.count > 0 {
            let random = Int.random(in: 0..<items.count-1)
            cell.configure(items[random])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == items.count-1 {
            didFinishPage?()
        }
    }
}

extension TVShowListView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        didSelectTVShow?(item)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollViewWillBeginDecelerating?(scrollView)
    }
}

extension TVShowListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: 85, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let height = collectionView.frame.height*0.6
        return CGSize(width: collectionView.frame.width, height: height)
    }
}

extension TVShowListView: TVShowMainHeaderDelegate {

    func didTapMore(_ show: TVShowCodable) {
        didSelectTVShow?(show )
    }
    
    func didTapAddFavorite(_ show: TVShowCodable) {
        didFavoriteTVShow?(show)
    }
    
    
}
