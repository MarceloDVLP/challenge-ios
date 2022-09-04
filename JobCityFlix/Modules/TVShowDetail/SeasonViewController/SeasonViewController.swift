import UIKit

final class SingleSelectorViewController: UIViewController {
    
    var items: [String]
    var selectedIndex: Int
    var didSelectItem: ((Int) -> ())?
    
    public lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear

        return collection
    }()

    
    init(items: [String], selectedIndex: Int) {
        self.items = items
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

extension SingleSelectorViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCell", for: indexPath) as? SeasonCell {
            cell.configure(season: items[indexPath.item], isSelected: indexPath.item == selectedIndex)
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

extension SingleSelectorViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(indexPath.item)
        dismiss(animated: true)
    }
}

extension SingleSelectorViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}
