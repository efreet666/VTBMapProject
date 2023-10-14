import Foundation
import UIKit

protocol ModuleFactoryProtocol {
    func getMapModule() -> UIViewController
}

final class ModuleFactory: ModuleFactoryProtocol {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func getMapModule() -> UIViewController {
        return ViewController()
    }
}
