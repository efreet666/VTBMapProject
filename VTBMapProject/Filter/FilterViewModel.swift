import Foundation

final class FilterViewModel {
    
    weak var viewController: FilterViewPresentable?
    
    let coordinator: FilterCoordinator
    
    init(coordinator: FilterCoordinator) {
        self.coordinator = coordinator
    }
}
