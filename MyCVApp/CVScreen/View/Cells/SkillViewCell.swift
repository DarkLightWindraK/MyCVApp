import UIKit

class SkillViewCell: UICollectionViewCell {
    private lazy var skillName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(Constants.deleteButtonImage, for: .normal)
        button.imageView?.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didDeleteTapped), for: .touchUpInside)
        return button
    }()
    
    private var maxCellWidth: NSLayoutConstraint?
    private var labelRightConstraint: NSLayoutConstraint?
    private var labelRightToButton: NSLayoutConstraint?
    
    private var onDeleteButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(
        skill: String,
        maxWidth: CGFloat,
        isEditing: Bool,
        onDeleteTapped: (() -> Void)?
    ) {
        skillName.text = skill
        deleteButton.isHidden = !isEditing
        labelRightConstraint?.isActive = !isEditing
        labelRightToButton?.isActive = isEditing
        maxCellWidth?.constant = maxWidth
        onDeleteButtonTapped = onDeleteTapped
    }
}

private extension SkillViewCell {
    @objc func didDeleteTapped() {
        onDeleteButtonTapped?()
    }
    
    func setupCell() {
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        contentView.addSubview(skillName)
        contentView.addSubview(deleteButton)
        
        labelRightConstraint = skillName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.contentInsets.right)
        labelRightConstraint?.isActive = true
        
        labelRightToButton = skillName.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -Constants.spacing)
        
        NSLayoutConstraint.activate([
            skillName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.contentInsets.left),
            skillName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.contentInsets.top),
            skillName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.contentInsets.bottom),
        ])
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.contentInsets.top),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.contentInsets.right),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.contentInsets.bottom)
        ])
        
        maxCellWidth = contentView.widthAnchor.constraint(lessThanOrEqualToConstant: 0)
        maxCellWidth?.isActive = true
        
        skillName.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        deleteButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    enum Constants {
        static let contentInsets: UIEdgeInsets = .init(top: 12, left: 24, bottom: 12, right: 24)
        static let cornerRadius: CGFloat = 10
        static let spacing: CGFloat = 12
        static let backgroundColor: UIColor = .systemGray5
        static let deleteButtonImage = UIImage(systemName: "xmark")
    }
}
