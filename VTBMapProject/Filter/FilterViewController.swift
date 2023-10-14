import Foundation
import UIKit
import SnapKit

final class FilterViewController: UIViewController {
    
    var viewModel: FilterViewModel?
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        makeSubviewsLayout()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        
    }
    
    private func makeSubviewsLayout() {
        
    }
}
