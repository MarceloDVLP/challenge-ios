import UIKit

final class SeasonListViewController: UIViewController {
    
    var seasons: [String]
    var selectedIndex: Int
    var didSelectSeason: ((Int) -> ())?
    
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
        didSelectSeason?(indexPath.item)
        dismiss(animated: true)
    }
}

extension SeasonListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}
