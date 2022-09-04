import UIKit


protocol SearchTVShowViewDelegate: AnyObject {
    func didTapFilter(_ selectedFilter: SearchFilter)
    func didSelectCast(_ person: Person)
    func didSelectShow(_ show: TVShowCodable)
}

final class SearchTVShowView: UIView {

    weak var delegate: SearchTVShowViewDelegate?
    var selectedFilter: SearchFilter

    enum SearchSection: Int, CaseIterable {
        case filters = 0
        case results = 1
    }
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()

    var shows: [TVShowCodable] = []
    var persons: [Person] = []

    init() {
        self.selectedFilter = .tvShows
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
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func registerCell() {
        collectionView.register(TVShowListCell.self,
                                forCellWithReuseIdentifier: "TVShowListCell")
        collectionView.register(SearchFilterCell.self, forCellWithReuseIdentifier: "SearchFilterCell")
        collectionView.register(SearchPersonCell.self, forCellWithReuseIdentifier: "SearchPersonCell")
    }
    
    func show(_ tvShows: [TVShowCodable]) {
        self.shows = tvShows
        collectionView.reloadData()
    }
    
    func show(_ persons: [Person]) {
        self.persons = persons
        collectionView.reloadData()
    }
    
    func show(_ filter: SearchFilter) {
        self.selectedFilter = filter
        collectionView.reloadData()
    }
}

extension SearchTVShowView: UICollectionViewDataSource {
    
    func items(for section: Int) -> Int {
        switch selectedFilter {
        case .tvShows: return shows.count
        case .actors: return persons.count
        }
    }

    func cell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch selectedFilter {
        case .tvShows: return dequeueTVShowCell(collectionView, cellForItemAt: indexPath)
        case .actors: return dequeuePersonCell(collectionView, cellForItemAt: indexPath)
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SearchSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SearchSection(rawValue: section)! {
        case .filters: return 1
        case .results: return items(for: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SearchSection(rawValue: indexPath.section)! {
        case .filters: return dequeueFilterCell(collectionView, cellForItemAt: indexPath)
        case .results: return cell(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func dequeueTVShowCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVShowListCell", for: indexPath) as? TVShowListCell {
            cell.configure(shows[indexPath.item])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func dequeuePersonCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPersonCell", for: indexPath) as? SearchPersonCell {
            let person = persons[indexPath.item]
            cell.configure(name: person.name ?? "", url: person.image?.medium)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func dequeueFilterCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchFilterCell", for: indexPath) as? SearchFilterCell {
            
            cell.configure(selectedFilter.title)
            cell.didTapFilterButton = { [weak self] in
                guard let self = self else { return }
                self.delegate?.didTapFilter(self.selectedFilter)
            }
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch SearchSection(rawValue: section)! {
        case .filters: return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        case .results: return insets(collectionView, insetForSectionAt: section)
        }
    }
    
    func insets(_ collectionView: UICollectionView, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch selectedFilter {
        case .tvShows: return UIEdgeInsets(top: 30, left: 16, bottom: 0, right: 16)
        case .actors: return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
    
}

extension SearchTVShowView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch selectedFilter {
        case .tvShows: delegate?.didSelectShow(shows[indexPath.item])
        case .actors: delegate?.didSelectCast(persons[indexPath.item])
        }
    }
}

extension SearchTVShowView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let insets = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        let width = collectionView.frame.width-insets.left-insets.right
        
        switch SearchSection(rawValue: indexPath.section)! {
        case .filters: return CGSize(width: width, height: 40)
        case .results: return self.size(collectionView, sizeForItemAt: indexPath)
        }
    }
    
    func size(_ collectionView: UICollectionView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch selectedFilter {
        case .tvShows: return CGSize(width: 85, height: 150)
        case .actors: return CGSize(width: 100, height: 170)
        }
    }
}



