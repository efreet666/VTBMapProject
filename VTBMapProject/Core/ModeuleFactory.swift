import Foundation
import UIKit

protocol ModuleFactoryProtocol {
    func getMapModule() -> UIViewController
    func getAdressListModule() -> UIViewController
}

final class ModuleFactory: ModuleFactoryProtocol {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func getMapModule() -> UIViewController {
        return MainMapViewController()
    }
    
    func getAdressListModule() -> UIViewController {
        let vm = AdressListViewModel()
        let vc = AdressListViewController()
        vc.viewModel = vm
        return vc
    }
}
