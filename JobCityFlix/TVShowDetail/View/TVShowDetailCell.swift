import UIKit
import SDWebImage


enum Colors {
    
    static let backGroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00)
}

final class TVShowDetailCell: UICollectionViewCell {
    
    let titleColor = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.00)
    let titleInactiveColor = UIColor(red: 0.37, green: 0.37, blue: 0.37, alpha: 1.00)
    let lineColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1.00)
    let activeLineColor = UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.00)
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupStackView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ tvShow: TVShowCodable?) {

    }
    
    override func prepareForReuse() {
    }
    
    private func setupStackView() {
        constrainSubView(view: stackView, top: 100, left: 0, right: 0, height: 30)
        
        let buttons = [makeButton("Episódios", true), makeButton("Detalhes", false), makeButton("", false), makeButton("", false)]
        
        buttons.forEach({ button in
            stackView.addArrangedSubview(button)
            
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        })
        
        

        addBottomLineView()
    }
    
    private func makeButton(_ title: String, _ isSelected: Bool) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor( isSelected ?  titleColor : titleInactiveColor , for: .normal)
        button.setTitleColor(.clear, for: .highlighted)
        button.backgroundColor = .clear
        button.layer.borderWidth = 0
        
        button.addTarget(self, action: #selector(didSelectButton), for: .touchUpInside)
                        
        addBottomLineViewForSelectedButton(in: button, isSelected ? 1 : 0)
        
        return button
    }
    
    private func addBottomLineViewForSelectedButton(in view: UIButton, _ alpha: CGFloat) {
        let lineView = UIView()
        lineView.backgroundColor = activeLineColor
        lineView.tag = -1
        lineView.alpha = alpha
        view.constrainSubView(view: lineView, bottom: 5, left: 0, right: 0, height: 0.5)
    }
    
    private func isLineView(_ view: UIView) -> Bool {
        return view.tag == -1
    }

    private func addBottomLineView() {
        let lineView = UIView()
        lineView.backgroundColor = lineColor
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.leftAnchor.constraint(equalTo: leftAnchor),
            lineView.rightAnchor.constraint(equalTo: rightAnchor),
            lineView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    @objc func didSelectButton(_ sender: UIButton) {
        stackView.subviews.forEach({ button in
            

            if button == sender {
                sender.setTitleColor(titleColor, for: .normal)

                button.subviews.forEach({ view in
                    if self.isLineView(view) {
                        UIView.animate(withDuration: 0.3, animations: {
                            view.alpha = 1
                        })
                    }
                })

            } else {
                (button as? UIButton)?.setTitleColor(titleInactiveColor, for: .normal)
                
                button.subviews.forEach({ view in
                    if self.isLineView(view) {
                        UIView.animate(withDuration: 0.3, animations: {
                            view.alpha = 0
                        })
                    }
                })

            }
        })
    }

}
