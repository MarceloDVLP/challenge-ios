import UIKit

final class MyFavoriteListViewController: UIViewController {
    
    var items: [FavoriteEntity] = []
    var interactor: MyFavoriteListInteractorProtocol
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        return collection
    }()
    
    init(interactor: MyFavoriteListInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = Colors.backGroundColor
        view.constrainSubView(view: collectionView, top: 0, bottom: 0, left: 0, right: 0)
        collectionView.register(TVShowListCell.self, forCellWithReuseIdentifier: "TVShowListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.viewWillAppear()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyFavoriteListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        let show = TVShowCodable(Int(item.showId))
        let viewController = TVShowDetailConfigurator.make(show)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MyFavoriteListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: 90, height: 140)        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension MyFavoriteListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowListCell", for: indexPath) as! TVShowListCell
        
        cell.configure(items[indexPath.item])
        return cell
    }
}

extension MyFavoriteListViewController: MyFavoriteListPresenterDelegate {
    
    func show(_ favorites: [FavoriteEntity]) {
        self.items = favorites
        collectionView.reloadData()
    }
}
