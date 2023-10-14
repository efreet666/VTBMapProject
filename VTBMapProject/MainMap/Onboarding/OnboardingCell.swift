//
//  OnboardingCell.swift
//  VTBMapProject
//
//  Created by Vlad on 14.10.2023.
//


import UIKit
import TinyConstraints
import Lottie

class OnboardInfoCollectionViewCell: UICollectionViewCell {
	
	static let reuseIdentifier = "OnboardInfoCollectionViewCell"
	private let edgeInset: CGFloat = 32
	
	private var animationView: LottieAnimationView = {
		let im = LottieAnimationView()
		im.contentMode = .scaleAspectFill
		return im
	}()
	
	
	private func configureLottie(json: String) {
		let jsonName = json
		let animation = LottieAnimation.named(jsonName)

		// Load animation to AnimationView
		animationView.animation = animation
		animationView.play()
		animationView.loopMode = .autoReverse
	}
	
	private let titleLabel: UILabel = {
		let lb = UILabel()
		lb.numberOfLines = 0
		lb.textAlignment = .center
		lb.textColor = .black
		lb.adjustsFontSizeToFitWidth = true
		lb.minimumScaleFactor = 0.5
		lb.font = UIFont.boldSystemFont(ofSize: 20.0)
		return lb
	}()
	
	private let descriptionLabel: UILabel = {
		let lb = UILabel()
		lb.textColor = .black
		lb.numberOfLines = 0
		lb.textAlignment = .center
		lb.font = UIFont.systemFont(ofSize: 18.0)
		return lb
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)

		addSubview(titleLabel)
		addSubview(descriptionLabel)
		configureLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureLayout() {
		// Add animationView as subview
		addSubview(animationView)
		animationView.edgesToSuperview(excluding: .bottom, insets: .top(100))
		animationView.height(400)
		
		// Play the animation
		animationView.play()
		
		titleLabel.topToBottom(of: animationView, offset: 50)
		
		
		titleLabel.edgesToSuperview(excluding: [.top, .bottom], insets: .left(edgeInset) + .right(edgeInset))
		titleLabel.height(min: 56)
		
		
		descriptionLabel.topToBottom(of: titleLabel, offset: 8)
		
		descriptionLabel.edgesToSuperview(excluding: [.top, .bottom], insets: .left(edgeInset) + .right(edgeInset))
		descriptionLabel.height(min: 42)
	}
	
	func configure(model: OnboardingModel) {
		configureLottie(json: model.jsonName)
		titleLabel.text = model.title
		descriptionLabel.text = model.subtitle
	}
}
