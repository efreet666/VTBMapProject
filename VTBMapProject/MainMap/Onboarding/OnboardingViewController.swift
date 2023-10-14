//
//  OnboardingViewController.swift
//  VTBMapProject
//
//  Created by Vlad on 14.10.2023.
//

import UIKit
import Lottie

class OnboardingViewController: UIViewController {

	private var dataSource: [OnboardingModel] = [
	OnboardingModel(title: "Новые возможности с ВТБ", subtitle: "Знакомьтесь с Робом, вашим личным голосовым помощником. ", jsonName: "Пинкод"),
	OnboardingModel(title: "", subtitle: "Роб всегда готов помочь: найти ближайшее отделение, записать в него и ответить на вопросы.", jsonName: "Разворот пальцы подмиг"),
	OnboardingModel(title: "Проще, чем когда-либо", subtitle: "Просто скажите «Найди ближайшее отделение ВТБ» или «Запиши меня на приём». Роб сделает всё остальное.", jsonName: "Язык")
	]
	
	private var currentPage = 0 {
		didSet {
			self.setPage(page: currentPage)
		}
	}
	
	private let closeButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(systemName: "xmark"), for: .normal)
		return button
	}()
	
	private let nextButton: UIButton = {
		let bt = UIButton()
		bt.setTitle("Перейти к карте", for: .normal)
		bt.setTitleColor(.white, for: .normal)
		bt.alpha = 0
		bt.layer.cornerRadius = 8
		return bt
	}()
	
	private let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
	
	let onboardingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewCenteredFlowLayout())
	
	private let pageControll: UIPageControl = {
		let pageControll = UIPageControl()
		pageControll.numberOfPages = 3
		pageControll.currentPage = 0
		pageControll.pageIndicatorTintColor = .gray
		pageControll.currentPageIndicatorTintColor = .blue
		return pageControll
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .white
  
		self.view.addSubview(onboardingCollectionView)
		onboardingCollectionView.edgesToSuperview()
		onboardingCollectionView.delegate = self
		onboardingCollectionView.dataSource = self
		onboardingCollectionView.register(OnboardInfoCollectionViewCell.self, forCellWithReuseIdentifier: OnboardInfoCollectionViewCell.reuseIdentifier)
		let layout = CollectionViewCenteredFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		onboardingCollectionView.setCollectionViewLayout(layout, animated: false)
		onboardingCollectionView.backgroundColor = .white
		onboardingCollectionView.showsHorizontalScrollIndicator = false
		onboardingCollectionView.isPagingEnabled = true
		
		// Do any additional setup after loading the view.
		self.view.addSubview(closeButton)
		closeButton.topToSuperview(usingSafeArea: true)
		closeButton.trailingToSuperview(offset: 15)
		closeButton.height(25)
		closeButton.width(25)
		self.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
		
		self.view.addSubview(pageControll)
		pageControll.bottomToSuperview(offset: -50)
		pageControll.leadingToSuperview(offset: 50)
		pageControll.trailingToSuperview(offset: 50)
		pageControll.height(15)
		
		self.view.addSubview(nextButton)
		nextButton.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.height.equalTo(48)
			make.width.equalTo(300)
			make.bottom.equalToSuperview().inset(90)
		}
    }
    
	@objc func close() {
		let vc = MainMapViewController()
		vc.modalPresentationStyle = .fullScreen
		self.present(vc, animated: true)
	}
	
	public func setPage(page: Int) {

		pageControll.page = page
		if page == 2 {
			nextButton.backgroundColor = self.hexStringToUIColor(hex: "#3A83F1")
			nextButton.addTarget(self, action: #selector(close), for: .touchUpInside)
			UIView.animate(withDuration: 0.5) {
				self.nextButton.alpha = 1
			}
		}
	}
	
	func hexStringToUIColor (hex:String) -> UIColor {
		var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

		if (cString.hasPrefix("#")) {
			cString.remove(at: cString.startIndex)
		}

		if ((cString.count) != 6) {
			return UIColor.gray
		}

		var rgbValue:UInt64 = 0
		Scanner(string: cString).scanHexInt64(&rgbValue)

		return UIColor(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(1.0)
		)
	}
	
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataSource.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardInfoCollectionViewCell.reuseIdentifier, for: indexPath) as? OnboardInfoCollectionViewCell
		cell?.configure(model: dataSource[indexPath.row])
		return cell ?? UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let itemWidth = self.view.bounds.width
		let itemHeight = self.onboardingCollectionView.bounds.height
		return CGSize(width: itemWidth, height: itemHeight)
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let width = scrollView.frame.width
		currentPage = Int(scrollView.contentOffset.x / width)
		self.setPage(page: currentPage)
	}
}

extension UIPageControl {
	var page: Int {
		get {
			return currentPage
		}
		set {
			currentPage = newValue
		}
	}
}
