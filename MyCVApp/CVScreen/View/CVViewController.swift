import UIKit

class CVViewController: UIViewController {
    
    private lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Constants.avatarImage
        return imageView
    }()
    
    private lazy var nameView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = NSMutableAttributedString(string: Constants.nameText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.font = Constants.nameFont
        label.textAlignment = .center
        return label
    }()
    
    private lazy var aboutView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.aboutText
        label.textColor = .systemGray
        label.font = Constants.detailsFont
        return label
    }()
    
    private lazy var locationView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.image = Constants.locationImage
        
        let label = UILabel()
        label.text = Constants.locationCity
        label.textColor = .systemGray
        label.font = Constants.detailsFont
        
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        TestData.skills.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "\(SkillViewCell.self)",
                for: indexPath
            ) as? SkillViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(
            skill: TestData.skills[indexPath.row],
            maxWidth: collectionView.bounds.width
            - Constants.sectionInset.leading
            - Constants.sectionInset.trailing,
            isEditing: collectionView.isEditing,
            onDeleteTapped: ({ [weak self] in
                TestData.skills.remove(at: indexPath.row)
                self?.infoCollectionView.reloadData()
            })
        )
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "\(SkillsHeaderView.self)",
                for: indexPath
            ) as? SkillsHeaderView
            else {
                return UICollectionReusableView()
            }
            
            header.configure { [weak self] isEditing in
                self?.infoCollectionView.isEditing = isEditing
                self?.infoCollectionView.reloadData()
            }
            return header
        case UICollectionView.elementKindSectionFooter:
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "\(SkillsFooterView.self)",
                for: indexPath
            )
        default:
            return UICollectionReusableView()
        }
    }
}

private extension CVViewController {
    enum Constants {
        static let screenName = "Профиль"
        static let locationImage = UIImage(named: "location")
        static let locationCity = "Воронеж"
        static let nameText = "Смирнов Антон\nАндреевич"
        static let aboutText = "Junior iOS-разработчик, опыт более 1 года"
        static let avatarImage = UIImage(named: "avatar")
        static let nameFont = UIFont.boldSystemFont(ofSize: 26)
        static let detailsFont = UIFont.systemFont(ofSize: 14)
        static let groupInset: NSDirectionalEdgeInsets = .init(top: 0, leading: 0, bottom: 12, trailing: 0)
        static let sectionInset: NSDirectionalEdgeInsets = .init(top: 16, leading: 12, bottom: 16, trailing: 12)
    }
    
    enum TestData {
        static var skills = ["UIKit", "SwiftUI", "Combine", "Compositional Layout", "URLSession", "MVVM", "Redux"]
    }
    
    func setupViews() {
        self.view.backgroundColor = .secondarySystemBackground
        self.title = Constants.screenName
        
        infoCollectionView.register(
            SkillViewCell.self,
            forCellWithReuseIdentifier: "\(SkillViewCell.self)"
        )
        infoCollectionView.register(
            SkillsHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "\(SkillsHeaderView.self)"
        )
        infoCollectionView.register(
            SkillsFooterView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "\(SkillsFooterView.self)"
        )
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(80), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(56))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = Constants.groupInset
        group.interItemSpacing = .fixed(12)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = Constants.sectionInset
        section.boundarySupplementaryItems = [makeHeaderView(), makeFooterView()]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func makeHeaderView() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(64)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
    
    func makeFooterView() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(64)),
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
    }
}
