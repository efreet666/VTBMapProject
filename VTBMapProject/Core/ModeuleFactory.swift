import Foundation
import UIKit

protocol ModuleFactoryProtocol {
    func getMapModule() -> UIViewController
    func getAdressListModule(coordinator: AddressListCoordinator) -> UIViewController
    func getFilterModule(coordinator: FilterCoordinator) -> UIViewController
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
    
    func getFilterModule(coordinator: FilterCoordinator) -> UIViewController {
        let vm = FilterViewModel(coordinator: coordinator)
        let vc = FilterViewController()
        vc.viewModel = vm
        vm.viewController = vc
        return vc
    }
}
