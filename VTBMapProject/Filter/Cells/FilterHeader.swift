import Foundation
import UIKit
import SnapKit

final class FilterHeader: UICollectionReusableView {
    
    static let identifier = "FilterHeader"
    
    private let headerLable: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = "Популярное"
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
        addSubview(headerLable)
        headerLable.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
