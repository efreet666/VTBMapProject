import Foundation
import UIKit
import SnapKit

final class AdressListCell: UITableViewCell {
    
    static let identifier = "AdressListCell"
    
    private let name: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .init(red: 0.17, green: 0.18, blue: 0.2, alpha: 1)
        return label
    }()
    
    private let adress: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .init(red: 0.6, green: 0.62, blue: 0.66, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        makeSubviewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [
        name,
        adress
        ].forEach(contentView.addSubview)
        contentView.backgroundColor = .white
    }
    
    private func makeSubviewLayout() {
        name.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        adress.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    func setup(name: String, adress: String) {
        self.name.text = name
        self.adress.text = adress
    }
}
