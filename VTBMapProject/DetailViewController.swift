//
//  DetailViewController.swift
//  MapKitTestUIkit
//
//  Created by Vlad on 10.10.2023.
//

import UIKit

final class DetailViewController: UIViewController {

	let detailView: UIImageView = {
		let iv = UIImageView()
		iv.image = UIImage(named: "Detail")
		return iv
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .white
		self.view.addSubview(detailView)
		detailView.edgesToSuperview(usingSafeArea: true)
		
    }
	
}

