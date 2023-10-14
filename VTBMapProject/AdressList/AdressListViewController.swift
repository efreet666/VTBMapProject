import Foundation
import UIKit
import SnapKit

fileprivate typealias AdressListDataSource = UITableViewDiffableDataSource<Int, AdressListItem>

final class AdressListViewController: UIViewController {
    
     var viewModel: AdressListViewModel?
    
    private let segmentControll = SegmentContollView()
    
    private let searchBar = AdressSearchBar()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(AdressListCell.self, forCellReuseIdentifier: AdressListCell.identifier)
        return tableView
    }()
    
    private lazy var dataSource: AdressListDataSource = {
        AdressListDataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AdressListCell.identifier, for: indexPath) as? AdressListCell else { return UITableViewCell() }
            
            cell.setup(name: item.title, adress: item.adress)
            return cell
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        setupView()
        makeSubviewLayout()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        [
        segmentControll,
        searchBar,
        tableView,
        ].forEach(view.addSubview)
    }
    
    private func makeSubviewLayout() {
        segmentControll.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(32)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalTo(segmentControll.snp.bottom).offset(24)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(36)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
