//
//  PlaceModel.swift
//  MapKitTestUIkit
//
//  Created by Vlad on 10.10.2023.
//

import UIKit

struct BankDepartmentModel: Identifiable {
    let id = UUID()
    let title: String
    let latitude: Double
    let longitude: Double
	let isFavorite: Bool
}

struct BankDepartmentMockData {
    static let BankData: [BankDepartmentModel] = [
		BankDepartmentModel(title: "Отделение 1", latitude: 59.935383, longitude: 30.327492, isFavorite: false),
		BankDepartmentModel(title: "Отделение 2", latitude: 59.931383, longitude: 30.323492, isFavorite: true),
		BankDepartmentModel(title: "Отделение 3", latitude: 59.939383, longitude: 30.321492, isFavorite: false)
    ]
}
