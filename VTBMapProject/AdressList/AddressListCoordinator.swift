import Foundation
import UIKit

final class AddressListCoordinator {
    private let navigationController: UINavigationController
    
    private let factory: ModuleFactoryProtocol
    
    init(navigationController: UINavigationController, factory: ModuleFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        navigationController.pushViewController(factory.getAdressListModule(coordinator: self), animated: true)
    }
}
