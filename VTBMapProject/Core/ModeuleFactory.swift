import Foundation
import UIKit

protocol ModuleFactoryProtocol {
    func getMapModule() -> UIViewController
    func getAdressListModule(coordinator: AddressListCoordinator) -> UIViewController
}

final class ModuleFactory: ModuleFactoryProtocol {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func getMapModule() -> UIViewController {
        return MainMapViewController()
    }
    
    func getAdressListModule(coordinator: AddressListCoordinator) -> UIViewController {
        let vm = AdressListViewModel(coordinator: coordinator)
        let vc = AdressListViewController()
        vc.viewModel = vm
        vm.viewController = vc
        return vc
    }
}
