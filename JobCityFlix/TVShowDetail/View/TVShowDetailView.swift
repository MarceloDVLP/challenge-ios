import UIKit

protocol TVShowDetailViewDelegate: AnyObject {
    func didTapSeasonButton()
}

enum Section: Int, CaseIterable {
    case detail = 0
    case menu = 1
    case season = 2
    case episodes = 3
    case about = 4
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
    var tvShow: TVShowCodable?
    var selectedMenu = NavigationMenu.episodes
    


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
        collectionView.reloadData()// reloadSections([Section.season.rawValue, Section.episodes.rawValue])
    }
    
    public func show(_ seasonIndex: Int) {
        self.selectedSeason = seasonIndex
        collectionView.reloadData()//reloadSections([Section.season.rawValue, Section.episodes.rawValue])
    }
    
    public func show(_ detail: TVShowCodable) {
        self.tvShow = detail
        collectionView.reloadData()//reloadSections([Section.detail.rawValue])
    }
}

extension TVShowDetailView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            switch Section(rawValue: section)! {
            case .detail: return 1
            case .menu: return 1
            case .season: return selectedMenu == .episodes ? 1 : 0
            case .episodes: return selectedMenu == .episodes ? episodes[selectedSeason].count : 0
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
        
        cell.configure(tvShow)
        return cell
    }
    
    private func dequeueSeasonCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> SeasonButtonCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonButtonCell", for: indexPath) as! SeasonButtonCell
        cell.show(season: selectedSeason+1, episodes: episodes[selectedSeason].count)
        
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

        switch Section(rawValue: indexPath.section)! {
            case .detail: return dequeueDetailCell(collectionView, indexPath)
            case .menu: return dequeueNavigationMenuCell(collectionView, indexPath)
            case .season: return dequeueSeasonCell(collectionView, indexPath)
            case .episodes: return dequeueEpisodeCell(collectionView, indexPath)
            case .about: return dequeueAboutCell(collectionView, indexPath)
        }
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
        
        switch Section.init(rawValue: section) {
        case .about, .detail: return .zero
        default: return UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16)
        }
    }
}

extension TVShowDetailView: UICollectionViewDelegate {
    
}

extension TVShowDetailView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        switch Section(rawValue: indexPath.section)! {
        case .detail: return CGSize(width: collectionView.frame.width, height: 550)
        case .menu: return CGSize(width: collectionView.frame.width-32, height: 30)
        case .season: return CGSize(width: collectionView.frame.width-32, height: 30)
        case .episodes: return CGSize(width: collectionView.frame.width-32, height: 150)
        case .about: return CGSize(width: collectionView.frame.width-32, height: 700)
            
        }
    }
}


extension TVShowDetailView: TVShowDetailCellDelegate {

    func didTapSeasonButton() {
        delegate?.didTapSeasonButton()
    }
}

final class SeasonButtonCell: UICollectionViewCell {

    var didTapSeasonButton: (() -> ())?
    
    lazy var seasonButton: UIButton = {
        let button = UIButton()
        button.setupWithMainColors()
        
        let image = UIImage(named: "arrow-down")!
        button.setImage(image, for: .normal)

        button.contentHorizontalAlignment = .left
        button.alignImageToRight()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return button
    }()
    
    lazy var totalEpisodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = Colors.titleInactiveColor
        return label
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           constrainSubView(view: seasonButton, top: 0, left: 0, width: 130, height: 30)
           
           addSubview(totalEpisodeLabel)
           totalEpisodeLabel.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               totalEpisodeLabel.leftAnchor.constraint(equalTo: seasonButton.rightAnchor, constant: 8),
               totalEpisodeLabel.centerYAnchor.constraint(equalTo: seasonButton.centerYAnchor)
           ])
           
           seasonButton.addTarget(self, action: #selector(didTapSeasonButtonFunc), for: .touchUpInside)
       }
       
    func show(season: Int, episodes: Int) {
        let seasonTitle = "\(season)ª Temporada   "
        seasonButton.setTitle(seasonTitle, for: .normal)
        totalEpisodeLabel.text = "\(episodes) episódios"
    }
        
    @objc func didTapSeasonButtonFunc(_ sender: UIButton) {
            didTapSeasonButton?()
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }
}

final class TVShowAboutCell: UICollectionViewCell {
    
    enum Fields: CaseIterable {
        case originalTitle
        case gender
        case language
        case runtime
        case schedule
        case channel
        case country
        case year
        
        var title: String {
            switch self {
            case .originalTitle:
                return "Titulo Original: "
            case .gender:
                return "Genero: "
            case .language:
                return "Idioma: "
            case .runtime:
                return "Duração média: "
            case .schedule:
                return "Data de Exibição: "
            case .country:
                return "País: "
            case .channel:
                return "Canal: "
            case .year:
                return "Ano de lançamento: "
            }
        }
    }
    
    private var titleLabel = UILabel()

    private var sumaryLabel = UILabel()
    
    private var sumaryValueLabel = UILabel()
    
    private var mainStackView = UIStackView()
    
    private var fields: [(UILabel, Fields)] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = makeTitleLabel("Ficha Técnica")
        sumaryLabel = makeTitleLabel("Sinopse")
        setupMainStackView()
        setupSumaryLabel()
        contentView.constrainSubView(view: titleLabel, top: 0, left: 0)
        constrainMainStack(stackView: mainStackView)
        constrainSumaryLabel()
        constrainSumaryValueLabel()
    }
    
    func configure(_ tvShow: TVShowCodable?) {
        guard let tvShow = tvShow else {
            return
        }

        for field in fields {
            switch field.1 {
                
            case .originalTitle:
                field.0.text = tvShow.name
            case .gender:
                field.0.text = tvShow.genres?.joined(separator: ",")
            case .language:
                field.0.text = tvShow.language
            case .runtime:
                field.0.text = "\(tvShow.runtime ?? 0)min"
            case .schedule:
                field.0.text = "at \(tvShow.schedule?.time ?? "") on \(tvShow.schedule?.days?.joined(separator: ",") ?? "")"
            case .channel:
                field.0.text = tvShow.network?.name
            case .country:
                field.0.text = tvShow.network?.country?.name
            case .year:
                field.0.text = tvShow.premiered
            }
        }
        
        sumaryValueLabel.text = tvShow.summary
    }
    
    private func setupMainStackView() {
        mainStackView = makeStackViewContainer()
        
        for field in Fields.allCases {
            let (stack, label) = makeLabelStack(labelSting: field.title, valueString: "")
            mainStackView.addArrangedSubview(stack)
            fields.append((label, field))
        }
    }
    
    private func constrainMainStack(stackView: UIView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor)
        ])
    }
    
    private func constrainSumaryLabel() {
        sumaryLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sumaryLabel)
        
        NSLayoutConstraint.activate([
            sumaryLabel.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            sumaryLabel.leftAnchor.constraint(equalTo: leftAnchor),
            sumaryLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    private func constrainSumaryValueLabel() {
        sumaryValueLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sumaryValueLabel)
        
        NSLayoutConstraint.activate([
            sumaryValueLabel.topAnchor.constraint(equalTo: sumaryLabel.bottomAnchor, constant: 10),
            sumaryValueLabel.leftAnchor.constraint(equalTo: leftAnchor),
            sumaryValueLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeTitleLabel(_ title: String) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        label.text = title
        return label
    }
    
    func makeStackViewContainer() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }
    
    func makeLabelStack(labelSting: String, valueString: String) -> (UIStackView, UILabel) {
        
        let label = UILabel()
        label.textColor = Colors.titleInactiveColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = labelSting
        label.textAlignment = .left

        let value = UILabel()
        value.textColor = Colors.titleInactiveColor
        value.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        value.text = valueString
        value.textAlignment = .left
        
        let stackView = UIStackView(arrangedSubviews: [label, value])
//        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return (stackView, value)
    }
    
    func setupSumaryLabel() {
        sumaryValueLabel.textColor = Colors.titleInactiveColor
        sumaryValueLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        sumaryValueLabel.numberOfLines = 4
        sumaryValueLabel.text = "<p><b>Murder in the First</b> follows homicide detectives Terry English and Hildy Mulligan as they investigate two seemingly unrelated murders. The mystery deepens, however, when they find both murders have a common denominator in a Silicon Valley wunderkind.</p>"
    }
}
