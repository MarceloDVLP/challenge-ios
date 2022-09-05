import UIKit

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
                return "Original Title: "
            case .gender:
                return "Gender: "
            case .language:
                return "Language: "
            case .runtime:
                return "Duration: "
            case .schedule:
                return "Air Date: "
            case .country:
                return "Country: "
            case .channel:
                return "Channel: "
            case .year:
                return "Release Year: "
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
        titleLabel = makeTitleLabel("")
        sumaryLabel = makeTitleLabel("Summary")
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
        
        sumaryValueLabel.text = tvShow.summary?.htmlToString
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
            stackView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: -16)
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
        value.lineBreakMode = .byTruncatingTail
        value.textAlignment = .left
        
        let stackView = UIStackView(arrangedSubviews: [label, value])
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
        return (stackView, value)
    }
    
    func setupSumaryLabel() {
        sumaryValueLabel.textColor = Colors.titleInactiveColor
        sumaryValueLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        sumaryValueLabel.numberOfLines = 0
    }
}
