import Foundation
import UIKit

final class FilterCoordinator {
    
    private let navigationController: UINavigationController
    
    private let factory: ModuleFactoryProtocol
    
    init(navigationController: UINavigationController, factory: ModuleFactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
        navigationController.pushViewController(factory.getFilterModule(coordinator: self), animated: true)
    }
}
