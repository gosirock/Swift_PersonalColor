import UIKit
import NMapsMap
import CoreLocation

class Map_ViewController: UIViewController, NMFMapViewDelegate {
    
    private var mapView: NMFMapView!
    let locationManager = CLLocationManager()
    private var zoomInButton: UIButton!
    private var zoomOutButton: UIButton!
    private var centerMapButton: UIButton!
    private var markers = [NMFMarker]()
    
    
    var locationDatas: [(Double, Double, String)] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocationsFromCSV()
        
        mapView = NMFMapView(frame: view.frame)
        mapView.delegate = self // mapView의 delegate 설정
        view.addSubview(mapView)
        
        // 최소 줌 레벨 설정
        mapView.minZoomLevel = 5.0 // 필요한 최소 줌 레벨에 따라 변경
        
        // 줌 범위제한
        mapView.extent = NMGLatLngBounds(southWestLat: 31.43, southWestLng: 122.37, northEastLat: 44.35, northEastLng: 132)
        
        // 위치 관리자 설정
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // 현재 위치 업데이트 시작
        locationManager.startUpdatingLocation()
        
        // 버튼 추가
        addZoomButtons()
        addCenterMapButton()
        addMapNearButton()
        
        // 초기 지도 위치를 "더조은 아카데미"로 설정
        let initialCoordinate = NMGLatLng(lat: 37.4947909, lng: 127.0300783)
        mapView.moveCamera(NMFCameraUpdate(scrollTo: initialCoordinate))
        setMarker(latitude: 37.4947909, longitude: 127.0300783, title: "더조은 아카데미")
        
        
        // 데이터 배열을 순환하며 마커 추가
        for location in locationDatas {
            setMarker(latitude: location.0, longitude: location.1, title: location.2)
        }
    }
    

    // 데이터를 로드하고 마커를 설정하는 메서드
    func loadLocationsFromCSV() {
        if let path = Bundle.main.path(forResource: "location", ofType: "csv") { //csv파일 경로지정
            do {
                let csvData = try String(contentsOfFile: path, encoding: .utf8)
                let csvLines = csvData.components(separatedBy: "\n")
                
                for line in csvLines {
                    let components = line.components(separatedBy: ",")
                    if components.count == 3, let latitude = Double(components[2]), let longitude = Double(components[1]) {
                        let name = components[0]
                        locationDatas.append((latitude, longitude, name))
                    }
                }
            } catch {
                print("Error reading CSV file")
            }
        }
    }
    

    
    func setMarker(latitude: Double, longitude: Double, title: String) {
        // 마커 추가
        let marker = NMFMarker()
        let position = NMGLatLng(lat: latitude, lng: longitude)
        marker.position = position
        marker.iconImage = NMF_MARKER_IMAGE_BLACK
        marker.iconTintColor = UIColor.systemBlue
        marker.width = 40
        marker.height = 50
        marker.mapView = mapView
        
        markers.append(marker)
        
        // 정보창 생성 (사용자 정의 정보창)
        let infoWindow = NMFInfoWindow()
        let dataSource = NMFInfoWindowDefaultTextSource.data()
        dataSource.title = title
        infoWindow.dataSource = dataSource
        
        // 마커에 정보창 연결
        marker.touchHandler = { [weak self] overlay in
            if let self = self {
                if infoWindow.mapView != nil {
                    // 정보창이 열려 있으면 닫습니다.
                    infoWindow.close()
                } else {
                    // 정보창이 열려 있지 않으면 엽니다.
                    infoWindow.open(with: marker)
                }
            }
            return true
        }
    }
    

    
    func addZoomButtons() {
        let buttonSize = CGSize(width: 45, height: 45)
        let buttonSpacing: CGFloat = 10
        
        zoomInButton = UIButton(frame: CGRect(x: view.frame.width - buttonSize.width - buttonSpacing, y: 100, width: buttonSize.width, height: buttonSize.height))
        zoomInButton.setImage(UIImage(systemName: "plus"), for: .normal)
        zoomInButton.tintColor = .blue
        zoomInButton.backgroundColor = .systemGray5
        zoomInButton.layer.cornerRadius = 10 // 버튼 사각형
        zoomInButton.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        mapView.addSubview(zoomInButton)
        
        zoomOutButton = UIButton(frame: CGRect(x: view.frame.width - buttonSize.width - buttonSpacing, y: zoomInButton.frame.maxY + buttonSpacing, width: buttonSize.width, height: buttonSize.height))
        zoomOutButton.setImage(UIImage(systemName: "minus"), for: .normal)
        zoomOutButton.tintColor = .blue
        zoomOutButton.backgroundColor = .systemGray5
        zoomOutButton.layer.cornerRadius = 10 // 버튼 사각형
        zoomOutButton.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        mapView.addSubview(zoomOutButton)
    }
  
    
    func addCenterMapButton() {
        let buttonWidth: CGFloat = 160
        let buttonHeight: CGFloat = 40
        centerMapButton = UIButton(frame: CGRect(x: (view.frame.width - buttonWidth) / 2, y: view.frame.height - 140, width: buttonWidth, height: buttonHeight))
        centerMapButton.setTitle("내 위치로 이동하기", for: .normal)
        centerMapButton.setTitleColor(.white, for: .normal)
        centerMapButton.titleLabel?.font = UIFont.systemFont(ofSize: 15) // 폰트 크기 조정
        centerMapButton.backgroundColor = .systemIndigo
        centerMapButton.layer.cornerRadius = 10
        centerMapButton.addTarget(self, action: #selector(centerMapOnUserButtonTapped), for: .touchUpInside)
        mapView.addSubview(centerMapButton)
    }
    

    
    func addMapNearButton(){
        let buttonWidth: CGFloat = 160
        let buttonHeight: CGFloat = 40
        centerMapButton = UIButton(frame: CGRect(x: (view.frame.width - buttonWidth) / 2, y: view.frame.height - 190, width: buttonWidth, height: buttonHeight))
        centerMapButton.setTitle("가까운 매장 찾기", for: .normal)
        centerMapButton.setTitleColor(.white, for: .normal)
        centerMapButton.titleLabel?.font = UIFont.systemFont(ofSize: 15) // 폰트 크기 조정
        centerMapButton.backgroundColor = .systemBlue
        centerMapButton.layer.cornerRadius = 10
        centerMapButton.addTarget(self, action: #selector(findNearestMarker), for: .touchUpInside)
        mapView.addSubview(centerMapButton)
    }
    

    
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<Current Location>>>>>>>>>>>>>>>>
    //사용자 디바이스의 위치서비스가 활성화 된 상태라면 앱권한 상태를 확인해야한다.
    func checkUserDeviceLocationServiceAuthorization() {
        
        // 3.1
        guard CLLocationManager.locationServicesEnabled() else {
            // 시스템 설정으로 유도하는 커스텀 얼럿
            showRequestLocationServiceAlert()
            return
        }
        
        
        // 3.2
        let authorizationStatus: CLAuthorizationStatus
        
        // 앱의 권한 상태 가져오는 코드 (iOS 버전에 따라 분기처리)
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        }else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // 권한 상태값에 따라 분기처리를 수행하는 메서드 실행
        checkUserCurrentLocationAuthorization(authorizationStatus)
    }
    
    
    //디바이스의 시스템 설정으로 유도하는 커스텀 어럴트
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true)
    }
    
    /*
     앱에 대한 위치 권한이 부여된 상태인지 확인하는 메서드 추가
     */
    func checkUserCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // 사용자가 권한에 대한 설정을 선택하지 않은 상태
            
            // 권한 요청을 보내기 전에 desiredAccuracy 설정 필요
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            // 권한 요청을 보낸다.
            locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            // 사용자가 명시적으로 권한을 거부했거나, 위치 서비스 활성화가 제한된 상태
            // 시스템 설정에서 설정값을 변경하도록 유도한다.
            // 시스템 설정으로 유도하는 커스텀 얼럿
            showRequestLocationServiceAlert()
            
        case .authorizedWhenInUse:
            // 앱을 사용중일 때, 위치 서비스를 이용할 수 있는 상태
            // manager 인스턴스를 사용하여 사용자의 위치를 가져온다.
            locationManager.startUpdatingLocation()
            
        default:
            print("Default")
        }
    }
    
    @objc func zoomIn() {
        // 현재 줌 레벨을 가져옴
        var currentZoom = mapView.zoomLevel
        // 새로운 줌 레벨을 설정
        currentZoom += 1
        // 유효한 줌 레벨 범위를 확인하고 설정
        if currentZoom <= mapView.maxZoomLevel {
            mapView.zoomLevel = currentZoom
        }
    }
    
    @objc func zoomOut() {
        // 현재 줌 레벨을 가져옴
        var currentZoom = mapView.zoomLevel
        // 새로운 줌 레벨을 설정
        currentZoom -= 1
        // 유효한 줌 레벨 범위를 확인하고 설정
        if currentZoom >= mapView.minZoomLevel {
            mapView.zoomLevel = currentZoom
        }
    }
    
    @objc func centerMapOnUserButtonTapped() {
        // 현재 사용자 위치를 가져옴.
        let userLocation = mapView.locationOverlay.location
        
        // 현재 위치로 지도 중앙을 이동.
        mapView.positionMode = .direction
        mapView.moveCamera(NMFCameraUpdate(scrollTo: userLocation))
        
        // 현재 위치를 파란색 원으로 표시.
        let circleOverlay = NMFCircleOverlay()
        circleOverlay.center = userLocation
        circleOverlay.radius = 100
        circleOverlay.fillColor = UIColor.blue.withAlphaComponent(0.5)
        circleOverlay.mapView = mapView
    }
    
    
    @objc func findNearestMarker() {
        // 현재 사용자 위치를 가져옴.
        let userLocation = mapView.locationOverlay.location
        
        // 사용자 위치가 nil이 아닌 경우에만 로직을 실행
        if userLocation != nil {
            // 여기에서 가장 가까운 마커를 찾는 로직을 구현합니다.
            // 코드를 새로 작성하여 오류가 발생하지 않도록 합니다.
            // 예를 들어, 마커 배열을 순회하면서 각 마커와 사용자 위치 간의 거리를 계산하여 최소 거리를 찾을 수 있습니다.
            var nearestMarker: NMFMarker?
            var minDistance: CLLocationDistance = .greatestFiniteMagnitude
            
            for marker in markers { // markers는 마커들을 저장한 배열
                let markerLocation = marker.position
                let distance = userLocation.distance(to: markerLocation)
                if distance < minDistance {
                    minDistance = distance
                    nearestMarker = marker
                }
            }
            
            // 가장 가까운 마커를 찾았으면 해당 마커로 지도 이동
            if let nearestMarker = nearestMarker {
                mapView.moveCamera(NMFCameraUpdate(scrollTo: nearestMarker.position))
                
                // 이후 원하는 작업을 수행할 수 있습니다.
                // 예를 들어, 해당 마커를 강조 표시하거나 정보창을 열 수 있습니다.
            }
        } else {
            // 사용자 위치를 가져오지 못한 경우 처리
            print("사용자 위치를 가져올 수 없음")
        }
    }
    
}


//extension>>>>>>>>>>>>>>>>>
extension Map_ViewController: CLLocationManagerDelegate {
    
    // 사용자의 위치를 성공적으로 가져왔을 때 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 위치 정보를 배열로 입력받는데, 마지막 index값이 가장 정확하다고 한다.
        if let coordinate = locations.last?.coordinate {
            // ⭐️ 사용자 위치 정보 사용
            //             UI 업데이트나 다른 비동기 작업을 처리할 때는 메인 스레드로 돌아가서 실행
            DispatchQueue.main.async {
                let userLocation = NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude)
                
                // 지도상에서 사용자 위치를 업데이트하는 나머지 코드
            }
        }
        
        // 위치 업데이트를 중지합니다.
        locationManager.stopUpdatingLocation()
    }
    
    
    // 사용자가 GPS 사용이 불가한 지역에 있는 등 위치 정보를 가져오지 못했을 때 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    // 앱에 대한 권한 설정이 변경되면 호출 (iOS 14 이상)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
        checkUserDeviceLocationServiceAuthorization()
    }
    // 앱에 대한 권한 설정이 변경되면 호출 (iOS 14 미만)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
        checkUserDeviceLocationServiceAuthorization()
    }
}

//extension>>>>>>>>>>>>>>>>>END

