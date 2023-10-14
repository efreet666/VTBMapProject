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
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.isHidden = true
        return activity
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel?.getPointAddresses()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        [
        segmentControll,
        searchBar,
        tableView,
        activityIndicator
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
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

extension AdressListViewController: AddressListPresentable {
    func displayAdresses(_ items: [AdressListItem]) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        var snapshot = NSDiffableDataSourceSnapshot<Int, AdressListItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot)
        tableView.reloadData()
    }
}
