import UIKit
import YandexMapsMobile
import TinyConstraints
import SnapKit
import Lottie

final class MainMapViewController: UIViewController, YMKUserLocationObjectListener {

	// MARK: - variables
	let mapView = YMKMapView()
	var isRobEnable: Bool = false
	
	// MARK: - View
	private let customView = SegmentContollView()
	private let searchBar: UIImageView = {
		let iv = UIImageView()
		iv.image = UIImage(named: "card")
		return iv
	}()
	
	private let robView: UIImageView = {
		let iv = UIImageView()
		iv.image = UIImage(named: "RobView")
		iv.alpha = 0
		return iv
	}()
	
	private let favoriteButton: UIButton = {
		let bt = UIButton()
		bt.setImage(UIImage(named: "favorites"), for: .normal)
		return bt
	}()
	
	private let robButton: UIButton = {
		let bt = UIButton()
		bt.setImage(UIImage(named: "Rob"), for: .normal)
		return bt
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .lightGray
		self.view.addSubview(mapView)
		self.mapView.edgesToSuperview()
		
		
		
		
		mapView.mapWindow.map.move(
			with: YMKCameraPosition(
				target: YMKPoint(latitude: 59.935493, longitude: 30.327392),
				zoom: 16,
				azimuth: 0,
				tilt: 0
			),
			animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0),
			cameraCallback: nil)
		
		setupPlaceData()
		
		setUserLocation()
		setupLayout()
	}

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
		animationView.loopMode = .playOnce
		DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
			self.animationView.isHidden = true
		}
	}
	
	private func setupLayout() {
		
		self.view.addSubview(customView)
		
		configureLayout()
	}
	
	func configureLayout() {
		self.customView.snp.makeConstraints { make in
			make.top.equalTo(60)
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
			make.height.equalTo(32)
		}
		
		self.view.addSubview(searchBar)
		self.searchBar.snp.makeConstraints { make in
			make.height.equalTo(104)
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		self.view.addSubview(favoriteButton)
		self.view.addSubview(robButton)
		
		
		robButton.snp.makeConstraints { make in
			make.top.equalTo(customView.snp_bottomMargin).offset(15)
			make.height.equalTo(60)
			make.height.equalTo(60)
			make.leading.equalToSuperview().inset(14)
		}
		
		favoriteButton.snp.makeConstraints { make in
			make.top.equalTo(robButton.snp_bottomMargin).offset(0)
			make.height.equalTo(60)
			make.height.equalTo(60)
			make.leading.equalToSuperview().inset(10)
		}
		
		self.view.addSubview(robView)
		robView.snp.makeConstraints { make in
			make.bottom.equalToSuperview()
			make.leading.equalToSuperview()
			make.trailing.equalToSuperview()
			make.height.equalTo(210)
		}
		
		robButton.addTarget(self, action: #selector(openRob), for: .touchUpInside)
		
		favoriteButton.addTarget(self, action: #selector(openFavorite), for: .touchUpInside)
		
		self.view.addSubview(animationView)
		animationView.edgesToSuperview()
		configureLottie(json: "Кнопка полёт (1)")
		// Play the animation
	}
	
	@objc func openRob() {
		isRobEnable.toggle()
		UIView.animate(withDuration: 0.5) {
			self.robView.alpha = self.isRobEnable ? 1 : 0
		}
	}
	
	@objc func openFavorite() {
		let vc = FavoriteVC()
		vc.modalPresentationStyle = .pageSheet
		self.present(vc, animated: true, completion: nil)
	}
	
	private func setupPlaceData() {
		let placeData: [BankDepartmentModel]? = getPlaceData()
		guard let placeData else { return }
		placeData.forEach { place in
			self.addPlacemark(mapView.mapWindow.map, title: place.title, latitude: place.latitude, longutude: place.longitude, image: place.image )
		}
	}
	
	private func getPlaceData() -> [BankDepartmentModel] {
		return BankDepartmentMockData.BankData
	}
	
	private func setUserLocation() {
		mapView.mapWindow.map.isRotateGesturesEnabled = false
		mapView.mapWindow.map.move(with:
									YMKCameraPosition(target: YMKPoint(latitude: 59.935493, longitude: 30.327392), zoom: 14, azimuth: 0, tilt: 0))
		
		let scale = UIScreen.main.scale
		let mapKit = YMKMapKit.sharedInstance()
		let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
		
		userLocationLayer.setVisibleWithOn(true)
		userLocationLayer.isHeadingEnabled = true
//        userLocationLayer.setAnchorWithAnchorNormal(
//            CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
//            anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
		userLocationLayer.setObjectListenerWith(self)
	}
	
	private func addPlacemark(_ map: YMKMap, title: String, latitude: Double, longutude: Double, image: UIImage) {
		image.withTintColor(.blue, renderingMode: .alwaysTemplate)
		let placemark = map.mapObjects.addPlacemark()
		placemark.setIconWith(image, style: YMKIconStyle(anchor: nil, rotationType: nil, zIndex: nil, flat: nil, visible: nil, scale: 1.4, tappableArea: nil))
		placemark.geometry = YMKPoint(latitude: latitude, longitude: longutude)
		placemark.useAnimation()
		
		placemark.addTapListener(with: mapObjectTapListener)
	}
	
	private lazy var mapObjectTapListener: YMKMapObjectTapListener = MapObjectTapListener(controller: self)

	func onObjectAdded(with view: YMKUserLocationView) {
		view.arrow.setIconWith(UIImage(systemName: "mappin")!)
		
		let pinPlacemark = view.pin.useCompositeIcon()
		
		pinPlacemark.setIconWithName("icon",
			image: UIImage(systemName: "mappin")!,
			style:YMKIconStyle(
				anchor: CGPoint(x: 0.5, y: 1) as NSValue,
				rotationType:YMKRotationType.rotate.rawValue as NSNumber,
				zIndex: 0,
				flat: true,
				visible: true,
				scale: 1.8,
				tappableArea: nil))

		view.accuracyCircle.fillColor = UIColor.blue
	}

	func onObjectRemoved(with view: YMKUserLocationView) {}

	func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {}
}

final private class MapObjectTapListener: NSObject, YMKMapObjectTapListener {
	init(controller: UIViewController) {
		self.controller = controller
	}

	func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
		print("\(mapObject)!!!")
		let vc = DetailViewController()
		vc.modalPresentationStyle = .pageSheet //or .overFullScreen for transparency
		self.controller.present(vc, animated: true, completion: nil)
		return true
	}

	private let controller: UIViewController
}
