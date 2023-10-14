import Foundation
import UIKit
import SnapKit

final class FilterMultiCell: UICollectionViewCell {
    
    let headerLable: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
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
            $0.leading.equalToSuperview().offset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
