import UIKit
import YandexMapsMobile
import TinyConstraints

class ViewController: UIViewController, YMKUserLocationObjectListener {

	let mapView = YMKMapView()
	
	fileprivate func setUserLocation() {
		mapView.mapWindow.map.isRotateGesturesEnabled = false
		mapView.mapWindow.map.move(with:
									YMKCameraPosition(target: YMKPoint(latitude: 0, longitude: 0), zoom: 14, azimuth: 0, tilt: 0))
		
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
	}

	private func setupPlaceData() {
		let placeData: [BankDepartmentModel]? = getPlaceData()
		guard let placeData else { return }
		placeData.forEach { place in
			self.addPlacemark(mapView.mapWindow.map, title: place.title, latitude: place.latitude, longutude: place.longitude )
		}
	}
	
	private func getPlaceData() -> [BankDepartmentModel] {
		return BankDepartmentMockData.BankData
	}
	
	private func addPlacemark(_ map: YMKMap, title: String, latitude: Double, longutude: Double) {
		let image = UIImage(named: "Pin Map")!
		image.withTintColor(.blue, renderingMode: .alwaysTemplate)
		let placemark = map.mapObjects.addPlacemark()
		placemark.setIconWith(image, style: YMKIconStyle(anchor: nil, rotationType: nil, zIndex: nil, flat: nil, visible: nil, scale: 2, tappableArea: nil))
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
