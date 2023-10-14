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
        let vc = OnboardingViewController()
		//factory.getAdressListModule()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
	
	func main() {
		let vc = MainMapViewController()
		//factory.getAdressListModule()
		window?.rootViewController = vc
		window?.makeKeyAndVisible()
	}
    
}
