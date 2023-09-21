import UIKit
import NMapsMap

class Map_ViewController: UIViewController {

    private var mapView: NMFMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = NMFMapView(frame: view.frame) // 클래스 레벨에서 선언한 mapView 초기화
        view.addSubview(mapView)

        // 좌표 설정 및 마커 추가
        setCamera()
        setMarker()
    }

    func setCamera() {
        let camPosition = NMGLatLng(lat: 37.503730, lng: 127.044871)
        let cameraUpdate = NMFCameraUpdate(scrollTo: camPosition)
        mapView.moveCamera(cameraUpdate)
    }

    func setMarker() {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 37.503730, lng: 127.044871)
        marker.iconImage = NMF_MARKER_IMAGE_BLACK
        marker.iconTintColor = UIColor.red
        marker.width = 50
        marker.height = 60
        marker.mapView = mapView

        // 정보창 생성
        let infoWindow = NMFInfoWindow()
        let dataSource = NMFInfoWindowDefaultTextSource.data()
        dataSource.title = "컬러홀릭 퍼스널컬러진단"
        infoWindow.dataSource = dataSource

        // 마커에 달아주기
        infoWindow.open(with: marker)
    }
}
