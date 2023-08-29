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
    
    private lazy var infoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeCollectionViewLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension CVViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        TestData.skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "\(SkillViewCell.self)",
                for: indexPath
            ) as? SkillViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(
            skill: TestData.skills[indexPath.row],
            maxWidth: collectionView.bounds.width
            - Constants.collectionViewGroupInsets.leading
            - Constants.collectionViewGroupInsets.trailing
            - SkillViewCell.Constants.contentInsets.left
            - SkillViewCell.Constants.contentInsets.right
        )
        return cell
    }
}

private extension CVViewController {
    enum Constants {
        static let screenName = "Профиль"
        static let avatarImageName = "avatar"
        static let locationImageName = "location"
        static let locationCity = "Воронеж"
        static let nameText = "Смирнов Антон\nАндреевич"
        static let aboutText = "Junior iOS-разработчик, опыт более 1 года"
        
        static let collectionViewGroupInsets: NSDirectionalEdgeInsets = .init(top: 12, leading: 12, bottom: 0, trailing: 12)
    }
    
    enum TestData {
        static let skills = ["UIKit", "SwiftUI", "Combine", "Compositional Layout"]
    }
    
    func setupViews() {
        self.view.backgroundColor = .secondarySystemBackground
        self.title = Constants.screenName
        
        infoCollectionView.register(SkillViewCell.self, forCellWithReuseIdentifier: "\(SkillViewCell.self)")
        infoCollectionView.dataSource = self
        
        setupConstraints()
    }
    
    func setupConstraints() {
        self.view.addSubview(avatarView)
        self.view.addSubview(nameView)
        self.view.addSubview(aboutView)
        self.view.addSubview(locationView)
        self.view.addSubview(infoCollectionView)
        
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
        NSLayoutConstraint.activate([
            infoCollectionView.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 20),
            infoCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, env in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(56))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.contentInsets = Constants.collectionViewGroupInsets
            group.interItemSpacing = .fixed(12)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
