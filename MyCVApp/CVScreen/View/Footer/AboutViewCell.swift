import UIKit

class SkillsFooterView: UICollectionReusableView {
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.titleText
        label.font = Constants.titleFont
        return label
    }()
    
    private lazy var information: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.informationText
        label.numberOfLines = 0
        label.font = Constants.informationFont
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SkillsFooterView {
    func setupViews() {
        addSubview(title)
        addSubview(information)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            information.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            information.leadingAnchor.constraint(equalTo: leadingAnchor),
            information.trailingAnchor.constraint(equalTo: trailingAnchor),
            information.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    enum Constants {
        static let titleText = "О себе"
        static let informationText = "Люблю яблочки"
        static let titleFont = UIFont.systemFont(ofSize: 17, weight: .medium)
        static let informationFont = UIFont.systemFont(ofSize: 14)
    }
}
