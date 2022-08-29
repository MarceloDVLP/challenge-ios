import UIKit

final class TVShowEpisodeListView: UIView {

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
    
    var items: [TVShowCodable] = []

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

extension TVShowEpisodeListView: UICollectionViewDataSource {
    
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
                
        cell.configure(items.first)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension TVShowEpisodeListView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        didSelectTVShow?(item)
    }
}

extension TVShowEpisodeListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: 85, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let height = collectionView.frame.height*0.6

        return CGSize(width: collectionView.frame.width, height: height)
    }
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

