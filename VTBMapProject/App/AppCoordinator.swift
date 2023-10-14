import Foundation
import UIKit

final class AppCoordinator {
    
    private var window: UIWindow?
    private let factory: ModuleFactoryProtocol
    
    
    init(window: UIWindow?, factory: ModuleFactoryProtocol) {
        self.window = window
        self.factory = factory
    }
    
    func start() {
        let navCont = UINavigationController()
        let coordinator = FilterCoordinator(navigationController: navCont, factory: factory)
        window?.rootViewController = navCont
        window?.makeKeyAndVisible()
        coordinator.start()
    }
    
}
