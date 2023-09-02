import UIKit

class SkillsHeaderView: UICollectionReusableView {
    
    private lazy var skillsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.skillsLabelText
        label.font = Constants.textFont
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.editButtonImage, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SkillsHeaderView {
    
    func setupConstraints() {
        addSubview(skillsLabel)
        addSubview(editButton)
        
        NSLayoutConstraint.activate([
            skillsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            skillsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            skillsLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            editButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    enum Constants {
        static let skillsLabelText = "Мои навыки"
        static let editButtonImage = UIImage(named: "edit_button")
        static let textFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
}
