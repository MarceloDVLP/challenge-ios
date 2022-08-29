import UIKit

final class TVShowDetailMenuView: UIView {

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        constrainSubView(view: stackView, top: 0, bottom: 0, left: 0, right: 0)
        
        let buttons = [makeButton("Episódios", true),
                       makeButton("Detalhes", false),
                       makeButton("", false),
                       makeButton("", false)]
        
        buttons.forEach({ button in
            stackView.addArrangedSubview(button)
            
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        })
        
        addBottomLineView()
    }
    
    private func makeButton(_ title: String, _ isSelected: Bool) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor( isSelected ?  Colors.titleColor : Colors.titleInactiveColor , for: .normal)
        button.setTitleColor(Colors.titleInactiveColor, for: .highlighted)
        button.backgroundColor = .clear
        button.layer.borderWidth = 0
        
        button.addTarget(self, action: #selector(didSelectButton), for: .touchUpInside)
                        
        addBottomLineViewForSelectedButton(in: button, isSelected ? 1 : 0)
        
        return button
    }
    
    private func addBottomLineViewForSelectedButton(in view: UIButton, _ alpha: CGFloat) {
        let lineView = UIView()
        lineView.backgroundColor = Colors.activeLineColor
        lineView.tag = -1
        lineView.alpha = alpha
        view.constrainSubView(view: lineView, bottom: 5, left: 0, right: 0, height: 0.5)
    }
    
    private func isLineView(_ view: UIView) -> Bool {
        return view.tag == -1
    }

    private func addBottomLineView() {
        let lineView = UIView()
        lineView.backgroundColor = Colors.lineColor
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
            
            guard let uiButton = button as? UIButton else { return }
            
            self.layoutForButton(uiButton, isSelected: button == sender)
        })
    }
    
    private func layoutForButton(_ button: UIButton, isSelected: Bool) {
        button.setTitleColor(isSelected ? Colors.titleColor : Colors.titleInactiveColor, for: .normal)

        button.subviews.forEach({ view in
            if self.isLineView(view) {
                animate(view: view, alpha: isSelected ? 1 : 0)
            }
        })
    }
    
    private func animate(view: UIView, alpha: CGFloat) {
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = alpha
        })
    }
}
