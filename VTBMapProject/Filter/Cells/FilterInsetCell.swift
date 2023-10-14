import Foundation
import UIKit
import SnapKit

final class FilterInsetCell: UICollectionViewListCell {
    
    let headerLable: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(headerLable)
        headerLable.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
