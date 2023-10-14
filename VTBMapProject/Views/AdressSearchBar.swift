import Foundation
import UIKit
import SnapKit

final class AdressSearchBar: UIView {
    
    let search: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.placeholder = "Город, район, метро, улица"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Filter Solid")!, for: .normal)
        button.adjustsImageWhenHighlighted = false
        return button
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
        makeSubviewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(search)
        addSubview(filterButton)
        backgroundColor = .white
    }
    
    private func makeSubviewLayout() {
        search.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
//            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview()
        }
        
        filterButton.snp.makeConstraints {
            $0.centerY.equalTo(search)
            $0.leading.equalTo(search.snp.trailing).offset(15)
            $0.size.equalTo(CGSize(width: 28, height: 28))
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
}
