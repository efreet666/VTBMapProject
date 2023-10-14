import Foundation
import UIKit
import SnapKit

protocol FilterViewPresentable: AnyObject {
    
}

typealias FilterDataSource = UICollectionViewDiffableDataSource<FilterSections, Item>

final class FilterViewController: UIViewController {
    
    var viewModel: FilterViewModel?
    
    lazy var dataSource: FilterDataSource = {
        FilterDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) in
            let section = self.sections[indexPath.section]
            
            switch section {
                case .roundedFilters:
                let cell = collectionView.dequeueConfiguredReusableCell(using: self.roundedCellRegister,
                                                                        for: indexPath,
                                                                        item: item)
                   return cell
            case .officeTypes:
                if indexPath.row == 0 {
                    let cell = collectionView.dequeueConfiguredReusableCell(using: self.registerHeaderCell,
                                                                         for: indexPath,
                                                                         item: item)
                    return cell
                } else {
                    let cell = collectionView.dequeueConfiguredReusableCell(using: self.reigsterFilterInsetCell,
                                                                         for: indexPath,
                                                                         item: item)
                    return cell
                }
            case .worloadTypes:
                if indexPath.row == 0 {
                    let cell = collectionView.dequeueConfiguredReusableCell(using: self.registerHeaderCell,
                                                                         for: indexPath,
                                                                         item: item)
                    return cell
                } else {
                    let cell = collectionView.dequeueConfiguredReusableCell(using: self.reigsterFilterInsetCell,
                                                                         for: indexPath,
                                                                         item: item)
                    return cell
                }
            case .popularFilters:
                let cell = collectionView.dequeueConfiguredReusableCell(using: self.registerMultiCell,
                                                                     for: indexPath,
                                                                     item: item)
                return cell
            }
        })
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewSectionsLayout())
        collectionView.backgroundColor = .white
        collectionView.register(FilterHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilterHeader.identifier)
        return collectionView
    }()
    
    private let sections: [FilterSections] = [.roundedFilters, .officeTypes, .worloadTypes, .popularFilters]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        makeSubviewsLayout()
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FilterHeader.identifier, for: indexPath) as? FilterHeader else { return UICollectionReusableView() }
            
            return header
        }
        
        createInitialSnapshot()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        [
            collectionView,
        ].forEach(view.addSubview)
    }
    
    private func makeSubviewsLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //MARK: RegisterCell
    let roundedCellRegister: UICollectionView.CellRegistration<FilterRoundedCell, Item> =  {
        UICollectionView.CellRegistration<FilterRoundedCell, Item> {(cell, indexPath, item) in
            cell.titleLabel.text = item.title
        }
    }()
    
    let registerHeaderCell: UICollectionView.CellRegistration<HeaderFiltercell, Item> = {
        UICollectionView.CellRegistration<HeaderFiltercell, Item> { (cell, indexPath, item) in
            let disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [.outlineDisclosure(options: disclosureOptions)]
            cell.headerLable.text = item.title
        }
    }()
    
    let reigsterFilterInsetCell: UICollectionView.CellRegistration<FilterInsetCell, Item> = {
        UICollectionView.CellRegistration<FilterInsetCell, Item> { (cell, indexPath, item) in
            
            cell.headerLable.text = item.title
        }
    }()
    
    let registerMultiCell: UICollectionView.CellRegistration<FilterMultiCell, Item> = {
        UICollectionView.CellRegistration<FilterMultiCell, Item> { (cell, indexPath, item) in
            cell.headerLable.text = item.title
        }
    }()
}
//MARK: CollectionViewlayout
extension FilterViewController {
    private func collectionViewSectionsLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) in
            guard let self else { return .none }
            let section = self.sections[sectionIndex]
            switch section {
            case .roundedFilters:
                return self.createRoundedSectionLayout()
            case .officeTypes:
                return createListTypeSectionLayout(environment: layoutEnvironment)
            case .worloadTypes:
                return createListTypeSectionLayout(environment: layoutEnvironment)
            case .popularFilters:
                return self.createPopularSection()
            }
        }
    }
    
    private func createRoundedSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(15),
                                                            heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 6, bottom: 0, trailing: 6)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .absolute(36)), subitems: [item])
        let section = createlayoutSection(group: group, behavior: .continuous, interGroupSpacing: 0, supplementaryItem: [])
        return section
    }
    
    private func createListTypeSectionLayout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .white
        let section = NSCollectionLayoutSection.list(using: listConfiguration, layoutEnvironment: environment)
        return section
    }
    
    private func createPopularSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .absolute(72)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                       heightDimension: .absolute(72)),
                                                     subitems: [item])
        let section = createlayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 0,
                                          supplementaryItem: [supplementaryHeaderItem()])
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .absolute(52)),
              elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    private func createlayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItem: [NSCollectionLayoutBoundarySupplementaryItem]) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItem
        return section
    }
    
}


extension FilterViewController: FilterViewPresentable {
    func createInitialSnapshot() {
        var roundedSettings = ["Открыто сейчас", "Банкомат", "Парковка", "Эл. очередь", "Выдача болших сумм", "Оформление кредета"]
        var officeTypes = ["Виды отделений", "Физические лица", "Юридические лица", "Привелегия", "Прайм"]
        let worloadTypes = ["Низкая загруженность", "Средняя загруженность", "Высокая загруженность"]
        let popularFilters = ["Кредитования", "Покупка и продажа валют", "Денежные переводы", "Услуги страхования", "Прием коммунальных платежей"]
        let model = SettingsModel(roundedSettings: roundedSettings,
                                  officeTypes: officeTypes,
                                  worloadTypes: worloadTypes,
                                  popularFilters: popularFilters)
        
        var snapshot = NSDiffableDataSourceSnapshot<FilterSections, Item>()
        
        snapshot.appendSections(sections)
        
        snapshot.appendItems(roundedSettings.map { .init(title: $0) }, toSection: .roundedFilters)
        
       
        
        
        officeTypes.removeFirst()
        
        var snapshot2 = NSDiffableDataSourceSectionSnapshot<Item>()
        let item = Item(title: officeTypes.first!)
        snapshot2.append([item])
        
        snapshot2.append(officeTypes.map { .init(title: $0) }, to: item)
        snapshot.appendItems(worloadTypes.map { .init(title: $0) }, toSection: .worloadTypes)
        snapshot.appendItems(popularFilters.map { .init(title: $0) }, toSection: .popularFilters)
        
        dataSource.apply(snapshot)
        dataSource.apply(snapshot2, to: .officeTypes)
        collectionView.reloadData()
    }
}
