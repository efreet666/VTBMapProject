//
//  SegmentContollView.swift
//  VTBMapProject
//
//  Created by Vlad on 14.10.2023.
//

import UIKit

class SegmentContollView: UIView {
	
	let segmentedControl: UISegmentedControl = {
		let segmentedControl = UISegmentedControl(items: ["Segment 1", "Segment 2"])
		segmentedControl.selectedSegmentIndex = 0
		segmentedControl.tintColor = .blue
		return segmentedControl
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
	}
	
	private func setupUI() {
		addSubview(segmentedControl)
		segmentedControl.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
			segmentedControl.centerYAnchor.constraint(equalTo: centerYAnchor),
		])
	}
	
	

}
