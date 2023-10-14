import Foundation
import UIKit
import SnapKit

final class FilterRoundedCell: UICollectionViewListCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .init(red: 0.13, green: 0.14, blue: 0.17, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .init(red: 0.92, green: 0.95, blue: 1, alpha: 1)
        contentView.layer.cornerRadius = 19
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
