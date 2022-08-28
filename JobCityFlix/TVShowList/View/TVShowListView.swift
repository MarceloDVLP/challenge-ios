import UIKit

final class TVShowListView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    init() {
        super.init(frame: .zero)
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
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            collectionView.heightAnchor.constraint(equalToConstant: 900)
        ])
    }
    
    private func registerCell() {
        collectionView.register(TVShowListCell.self, forCellWithReuseIdentifier: "TVShowListCell")
    }
}

extension TVShowListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowListCell", for: indexPath)
    }
    
    
}

extension TVShowListView: UICollectionViewDelegate {
    
}

extension TVShowListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCells = 3.5
        let width = collectionView.frame.width/numberOfCells
        
        return CGSize(width: 96, height: 128)
    }
    
}
