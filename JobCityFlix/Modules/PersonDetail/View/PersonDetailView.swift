import UIKit

protocol PersonDetailViewDelegate: AnyObject {
    func didTapShow(_ tvShow: TVShowModel)
}

final class PersonDetailView: UIView {

    var person: Person?
    var shows: [TVShowModel] = []
    weak var delegate: PersonDetailViewDelegate?
    
    public lazy var collectionView: UICollectionView = {
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
        collectionView.register(TVShowListCell.self, forCellWithReuseIdentifier: "TVShowListCell")
        collectionView.register(PersonDetailCell.self, forCellWithReuseIdentifier: "PersonDetailCell")
    }
    
    public func show(_ shows: [TVShowModel]) {
        self.shows = shows
        collectionView.reloadData()
    }
    
    public func show(_ person: Person) {
        self.person = person
        collectionView.reloadData()
    }
}

extension PersonDetailView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        PersonDetailSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch PersonDetailSection(rawValue: section)! {
        case .detail: return 1
        case .shows: return shows.count
        }
    }

    private func dequeueShowCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> TVShowListCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowListCell", for: indexPath) as! TVShowListCell
        
        cell.configure(shows[indexPath.item])
        return cell
    }

    private func dequeueDetailCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> PersonDetailCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonDetailCell", for: indexPath) as! PersonDetailCell
        
        cell.configure(person)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch PersonDetailSection.init(rawValue: indexPath.section)! {
        case .detail: return dequeueDetailCell(collectionView, indexPath)
        case .shows : return dequeueShowCell(collectionView, indexPath)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch PersonDetailSection.init(rawValue: section)! {
        case .detail: return .zero
        case .shows: return UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
        }
    }
}

extension PersonDetailView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapShow(shows[indexPath.item])
    }
}

extension PersonDetailView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        
        switch PersonDetailSection(rawValue: indexPath.section)! {
        case .detail: return CGSize(width: collectionView.frame.width, height: 550)
        case .shows: return CGSize(width: 85, height: 130)
        }
    }
}

enum PersonDetailSection: Int, CaseIterable {
    case detail = 0
    case shows = 1
}
