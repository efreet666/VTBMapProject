import Foundation

enum FilterSections: Hashable {
    case roundedFilters
    case officeTypes
    case worloadTypes
    case popularFilters
}

enum FilterItems: Hashable {
    case rounded(Int)
    case office(Int)
}

struct RoundedItem {
    let id: String
    let title: String
}

struct Item {
    let uuid = UUID()
    let title: String
}

extension Item: Hashable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
            return lhs.uuid == rhs.uuid
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
        }
}

struct OfficeItem {
    let id: String
    let title: String
}

struct SettingsModel: Hashable {
    let roundedSettings: [String]
    let officeTypes: [String]
    let worloadTypes: [String]
    let popularFilters: [String]
}
