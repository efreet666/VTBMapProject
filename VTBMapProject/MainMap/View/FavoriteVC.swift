//
//  FavoriteVC.swift
//  VTBMapProject
//
//  Created by Vlad on 15.10.2023.
//

import UIKit

final class FavoriteVC: UIViewController {

	let detailView: UIImageView = {
		let iv = UIImageView()
		iv.image = UIImage(named: "FavoriteVC")
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		self.view.addSubview(detailView)
		detailView.edgesToSuperview(usingSafeArea: true)
	}
}
