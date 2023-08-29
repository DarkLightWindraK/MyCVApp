import UIKit

class SkillViewCell: UICollectionViewCell {
    private lazy var skillName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(skill: String, maxWidth: CGFloat) {
        skillName.text = skill
        skillName.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
    }
}

private extension SkillViewCell {
    func setupCell() {
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        contentView.addSubview(skillName)
        
        NSLayoutConstraint.activate([
            skillName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.contentInsets.left),
            skillName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.contentInsets.right),
            skillName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.contentInsets.top),
            skillName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.contentInsets.bottom),
        ])
    }
}

extension SkillViewCell {
    enum Constants {
        static let contentInsets: UIEdgeInsets = .init(top: 12, left: 24, bottom: 12, right: 24)
        static let cornerRadius: CGFloat = 10
        static let backgroundColor: UIColor = .systemGray5
    }
}
