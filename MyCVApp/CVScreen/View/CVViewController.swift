import UIKit

class CVViewController: UIViewController {
    
    private lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.avatarImageName)
        return imageView
    }()
    
    private lazy var nameView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = NSMutableAttributedString(string: Constants.nameText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var aboutView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.aboutText
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var locationView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.locationImageName)
        
        let label = UILabel()
        label.text = Constants.locationCity
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

private extension CVViewController {
    enum Constants {
        static let screenName = "Профиль"
        static let avatarImageName = "avatar"
        static let locationImageName = "location"
        static let locationCity = "Воронеж"
        static let nameText = "Иванов Иван\nИванович"
        static let aboutText = "Junior iOS-разработчик, опыт более 1 года"
    }
    
    func setupViews() {
        self.view.backgroundColor = .secondarySystemBackground
        self.title = Constants.screenName
        
        setupConstraints()
    }
    
    func setupConstraints() {
        self.view.addSubview(avatarView)
        self.view.addSubview(nameView)
        self.view.addSubview(aboutView)
        self.view.addSubview(locationView)
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 20),
            nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            aboutView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 10),
            aboutView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: aboutView.bottomAnchor, constant: 4),
            locationView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
