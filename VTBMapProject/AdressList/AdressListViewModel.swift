import Foundation

final class AdressListViewModel {
    
    weak var viewController: AddressListPresentable?
    
    private let coordinator: AddressListCoordinator
    
    init(coordinator: AddressListCoordinator) {
        self.coordinator = coordinator
    }
    
    func getPointAddresses() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            let itemsList: [AdressListItem] = [.init(id: UUID().uuidString, title: "1", adress: "adress 1"),
                                               .init(id: UUID().uuidString, title: "2", adress: "adress 2"),
                                               .init(id: UUID().uuidString, title: "3", adress: "adress 3"),
                                               .init(id: UUID().uuidString, title: "4", adress: "adress 4"),
                                               .init(id: UUID().uuidString, title: "5", adress: "adress 5"),
                                               .init(id: UUID().uuidString, title: "6", adress: "adress 6"),
            ]
            self.viewController?.displayAdresses(itemsList)
        }
    }
}
