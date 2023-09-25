import UIKit
import NMapsMap
import CoreLocation

class Map_ViewController: UIViewController, NMFMapViewDelegate{
    
    private var mapView: NMFMapView!
    let locationManager = CLLocationManager()
    private var zoomInButton: UIButton!
    private var zoomOutButton: UIButton!
    private var centerMapButton: UIButton!
//    private var centerNearButton: UIButton!
    private var markers = [NMFMarker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        
        
        // 경도, 위도, 지점명 데이터 배열
        let locationData: [(Double, Double, String)] = [
            
            (37.5433349, 126.9537990, "퍼스널컬러 트렌드연구소 컬러 인사이트"),
             (37.5562697, 126.9320554, "피엘컬러 퍼스널컬러 진단"),
             (37.5530486, 126.9376538, "더빠른퍼스널컬러컨설팅"),
             (37.5317256, 126.9715196, "주얼인유 퍼스널컬러"),
            (37.5433349, 126.9537990, "퍼스널컬러 트렌드연구소 컬러 인사이트"),
             (37.5562697, 126.9320554, "피엘컬러 퍼스널컬러 진단"),
             (37.5530486, 126.9376538, "더빠른퍼스널컬러컨설팅"),
             (37.5317256, 126.9715196, "주얼인유 퍼스널컬러"),
             (37.5558595, 126.9293970, "메이크온전히 퍼스널컬러 진단"),
             (37.5415418, 126.9473839, "한국퍼스널컬러코디네이터협회"),
             (37.5572655, 126.9227875, "컬러가산다 퍼스널컬러진단 홍대동교센터"),
             (37.5603872, 126.9236486, "컬러가산다 퍼스널컬러진단 홍대연남센터"),
             (37.5556488, 126.9273619, "담쁨퍼스널컬러진단"),
             (37.5589391, 126.9290920, "색갈피 퍼스널컬러"),
             (37.5588444, 126.9258750, "비비드강 퍼스널컬러"),
             (37.5577576, 126.9243708, "퍼스널컬러 색다르다"),
             (37.5592446, 126.9235076, "컬러쏘싸이어티 퍼스널컬러"),
             (37.5621258, 126.9245387, "느로아 퍼스널컬러"),
             (37.5558414, 126.9256060, "유트룰리 퍼스널컬러"),
             (37.5535219, 126.9222828, "세컨뉴 퍼스널컬러"),
             (37.5506197, 127.0453382, "오띠모 퍼스널컬러 진단"),
             (37.5538067, 126.9179503, "아란 퍼스널컬러"),
             (37.5841971, 127.0511390, "컬러라이즈 퍼스널컬러 진단"),
             (37.5496736, 126.9165413, "컬러아카이브 퍼스널컬러"),
             (37.5220655, 127.0215170, "퍼스널컬러 이미지호 가로수길점"),
             (37.5198939, 127.0206526, "무드컬렉트 퍼스널컬러 신사점"),
             (37.5461143, 127.0500401, "담쁨퍼스널컬러진단 성수점"),
             (37.5548406, 126.9126815, "필린 퍼스널컬러 & 이미지컨설팅"),
             (37.5268022, 127.0407396, "한국패션심리연구원 퍼스널컬러진단"),
             (37.5406187, 127.0561318, "CCL컬러이미지융합연구소 퍼스널컬러 진단"),
             (37.6151105, 126.9280907, "조이컬러공방 퍼스널컬러진단"),
             (37.5386028, 127.0689342, "컬러가산다 퍼스널컬러진단 건대센터"),
             (37.5163742, 127.0227536, "컬러연 퍼스널컬러"),
             (37.5482383, 127.0556496, "쇼컬러 퍼스널컬러"),
             (37.4928206, 127.0285600, "컬러라이즈 퍼스널컬러 진단"),
             (37.5248682, 127.0393425, "온니큐 퍼스널 컬러&메이크업"),
             (37.5057056, 127.0216841, "컬러모아 퍼스널컬러진단"),
             (37.4944557, 127.0376446, "컬러시그널 퍼스널컬러 진단"),
             (37.5059437, 127.0226975, "컬러공방 퍼스널컬러진단"),
             (37.5193548, 127.0580459, "리즈컬러 퍼스널컬러진단&메이크업&체형진단"),
             (37.5194834, 126.8980387, "픽컬러브랜딩센터 퍼스널컬러 진단"),
             (37.4950995, 127.0449082, "컬러플레이스 퍼스널컬러진단 본점"),
             (37.5583072, 126.9008980, "프목 퍼스널컬러"),
             (37.5037609, 127.0208126, "웜앤쿨 퍼스널컬러진단"),
             (37.5044278, 127.0472490, "디자인미 퍼스널컬러진단"),
             (37.5028561, 127.0447712, "컬러홀릭 퍼스널컬러진단"),
             (37.5473557, 127.0723979, "컬러바이유 퍼스널컬러"),
             (37.5367287, 126.8954318, "퍼스널컬러 꼴로레"),
             (37.5185935, 127.0415783, "유어컬러즈:컬러곰 퍼스널컬러진단"),
             (37.5258609, 126.8947826, "톤앤핏 퍼스널컬러"),
             (37.6008305, 126.8902090, "인더루체랩 퍼스널컬러진단"),
             (37.4825012, 126.9835267, "컬러앤센트 퍼스널컬러 진단"),
             (37.4948012, 127.0286234, "컬러온에어 퍼스널컬러진단"),
             (37.5095284, 126.8877721, "이음컬러 퍼스널컬러 진단"),
             (37.4944557, 127.0376446, "컬러시그널 퍼스널컬러진단 실버점"),
             (37.5028561, 127.0447712, "컬러홀릭 골격핏 퍼스널컬러진단"),
             (37.4865420, 126.9001590, "푸른달컬러 퍼스널컬러 진단"),
             (37.5359472, 126.8780787, "컬러웨이브스튜디오 퍼스널컬러"),
             (37.5421890, 127.0709999, "퍼스널컬러 아뜰리에베베"),
             (37.4922357, 127.0290714, "이안컬러랩 퍼스널컬러 진단"),
             (37.4800389, 126.9504891, "퍼스널컬러 온"),
             (37.5232964, 126.8640417, "로앤드로우 퍼스널컬러 진단"),
             (37.5590997, 126.8279956, "퍼스널컬러 진단 오운이미지랩"),
             (37.4823204, 126.9290563, "퍼스널리브 퍼스널컬러 진단"),
             (37.5041804, 127.0514980, "이수 퍼스널컬러경영컨설팅"),
             (37.4772493, 126.9834388, "딸로퍼스널컬러컨설팅"),
             (37.5680891, 126.8254241, "퍼스널컬러나다움"),
             (37.5688514, 126.8273386, "탑 컬러 퍼스널컬러 진단"),
             (37.5266711, 126.8593555, "컬러텔링 퍼스널컬러"),
             (37.5294250, 126.8426741, "유컬러 퍼스널컬러"),
             (37.5608356, 126.8296186, "퍼스널컬러 휴어"),
             (37.5589625, 126.8294731, "퍼스널컬러 당신의 팔레트"),
             (37.6700269, 127.1136794, "럽리브 컬러코칭센터 퍼스널컬러 진단"),
             (37.5029457, 126.7728595, "컬러시안 퍼스널컬러진단"),
             (37.3857069, 127.1257165, "위올컬러 퍼스널컬러진단"),
             (37.5616135, 127.1939457, "쵸밍 퍼스널컬러&메이크업"),
             (37.4840085, 127.0182770, "뉴퍼스널컬러연구소 서초센터"),
             (37.6451195, 126.7845885, "컬러블랑쉬 퍼스널컬러"),
             (37.4853653, 126.7803105, "컬러그레이 퍼스널컬러"),
             (37.3681546, 127.1072392, "퍼컬바다 퍼스널컬러 진단"),
             (37.3889964, 127.1225147, "다이브컬러 퍼스널컬러 진단"),
             (37.3933191, 126.9631752, "KBP 퍼스널컬러 골격진단 연구소"),
             (37.4544017, 126.7077708, "브이엘퍼스널컬러진단"),
             (37.5158606, 126.7268033, "유티크 컬러앤이미지 퍼스널컬러&이미지진단"),
             (37.3905053, 126.9491852, "컬러페르테 퍼스널컬러"),
             (37.7443582, 127.0990154, "비마이팔레트 퍼스널컬러"),
             (37.3781416, 127.1123236, "모모 퍼스널컬러 진단"),
             (37.5031690, 126.7788582, "퍼스널컬러 가치파인더"),
             (37.5033138, 126.7778489, "A퍼스널컬러"),
             (37.2659420, 127.0016930, "퍼스널컬러진단 컬러한송이"),
             (37.2632388, 127.0006216, "퍼스널컬러진단 포유어컬러 수원역점"),
             (37.2658934, 127.0310278, "컬러화 퍼스널컬러진단경영컨설팅"),
             (37.3195127, 126.8323489, "드림캐처 이미지컨설팅 퍼스널컬러진단"),
             (37.4634723, 126.6825210, "컬러숨 퍼스널컬러경영컨설팅"),
             (37.3189133, 126.8348265, "비마이컬러 퍼스널컬러진단"),
             (37.2881246, 127.0607027, "컬러 꽃 피움 퍼스널컬러 진단"),
             (37.2450583, 127.0511613, "컬러를채우다 퍼스널컬러진단"),
             (37.3853568, 126.6413467, "컬러제이 퍼스널컬러"),
             (37.3606103, 126.9325909, "컬러당 퍼스널컬러"),
             (37.2851029, 127.0159552, "퍼스널컬러진단 포유어컬러 행궁점"),
             (37.3134218, 126.8393424, "퍼스널컬러진단 포유어컬러 안산점"),
             (37.7148478, 126.7614804, "컬러무드 : 퍼스널컬러"),
             (37.2005516, 127.0720150, "퍼스널컬러진단 포유어컬러 동탄점"),
             (37.7286138, 126.7614247, "언컬러드 퍼스널컬러 스튜디오"),
             (37.3942568, 127.1122717, "퍼스널컬러진단 브랜미 판교점"),
             (37.2680374, 127.0013137, "퍼스널컬러진단 웨이브컬러"),
             (37.2669773, 127.0293223, "컬러오프 퍼스널컬러이미지 컨설팅"),
             (37.4131313, 127.2613491, "나답다 퍼스널컬러 진단"),
             (37.3832893, 126.6422608, "만지작퍼스널컬러"),
             (37.2874971, 127.0602549, "아이컬러콘텐츠랩 퍼스널컬러진단 광교본점"),
             (37.3202489, 127.1093997, "비다무드 퍼스널컬러"),
             (37.2997124, 126.9706354, "컬러무이 퍼스널컬러"),
             (37.2875826, 127.0568585, "컬러씨 퍼스널컬러 컨설팅"),
             (37.3732329, 127.1381852, "이유퍼스널컬러"),
             (35.1557132, 126.8489336, "오후2시,설렘 퍼스널컬러"),
             (35.2224552, 126.8517061, "유주얼컬러 퍼스널컬러진단"),
             (35.1358444, 129.1014369, "컬러풀 퍼스널컬러진단"),
             (35.6025819, 129.3640463, "리유팔레트 퍼스널컬러"),
             (36.3529106, 127.3788486, "룩앤체인지 퍼스널컬러"),
             (36.5988243, 127.4558010, "비앤씨컬러랩퍼스널컬러"),
             (35.1532498, 129.0618000, "블루밍 퍼스널컬러"),
             (35.2611642, 128.8722418, "생기를더하다 퍼스널컬러진단"),
             (35.1133138, 129.0156829, "표현 퍼스널컬러"),
             (35.1595614, 126.8648567, "아로아로컬러랩Lab 퍼스널컬러"),
             (35.1512727, 129.1120329, "라움이미지브랜딩 퍼스널컬러진단"),
             (36.0268145, 129.3679978, "해시 퍼스널컬러 포항점"),
             (36.3391679, 127.3902132, "컬러블리 퍼스널컬러 이미지컨설팅"),
             (33.4945886, 126.5274844, "휴 퍼스널 컬러"),
             (35.1652915, 129.1150692, "웨어컬러브랜딩센터 퍼스널컬러진단"),
             (36.3080506, 127.3549033, "컬러 루미닝 퍼스널컬러"),
             (35.2262411, 128.6783340, "퍼스널컬러 온컬러"),
             (38.1986235, 128.5729892, "컬러데이 퍼스널컬러"),
             (35.2260011, 128.8764769, "피뉴컬러 브랜딩 센터 퍼스널컬러진단"),
             (35.1564198, 129.0647188, "나의빛색 퍼스널컬러"),
             (35.2359928, 129.0107187, "퍼스널컬러 시소"),
             (35.1456824, 129.0596975, "컬러썸 퍼스널컬러"),
             (36.8937319, 126.6296618, "퍼스널컬러 더 샤인"),
             (36.3530932, 127.3777857, "퍼스널컬러진단 포유어컬러 대전점"),
             (35.1597310, 129.1197673, "퍼스널컬러 컬러스튜디오"),
             (35.2303438, 129.0878889, "컬러조이 퍼스널컬러"),
             (35.1710552, 129.0700216, "피타코디 퍼스널컬러 톤앤9이미지 진단"),
             (36.6559533, 126.6732681, "컬러빛 퍼스널컬러"),
             (35.1570892, 129.0647296, "멜로즈 퍼스널컬러"),
             (35.1055312, 129.0356890, "퍼스널컬러 클라"),
             (36.0507939, 129.3709869, "컬리쉬 퍼스널컬러"),
             (34.8522199, 128.4321648, "퍼스널 컬러 드랍 더 빛"),
             (33.5162770, 126.5802701, "아반리티퍼스널컬러"),
             (37.3277397, 127.9784669, "하주선퍼스널컬러교육원"),
             (35.0987388, 129.0308276, "랑핏 이미지메이킹 퍼스널컬러"),
             (37.7516064, 128.8953540, "이또컬러랩 퍼스널컬러 진단"),
             (35.1855849, 129.0797877, "컬러별 퍼스널컬러"),
             (35.1953381, 128.9942645, "퍼스널컬러 색울림"),
             (35.2360277, 128.8608359, "컬러윤 퍼스널컬러 브랜딩 센터"),
             (35.1461785, 126.8458283, "포엠루나 퍼스널컬러"),
             (35.0989136, 128.9060117, "퍼스널컬러 색감"),
             (37.5484293, 127.0435625, "컬러오브데이 퍼스널컬러진단"),
             (37.5548406, 126.9126815, "멜팅피 퍼퓸 앤 퍼스널컬러"),
             (37.5100578, 127.0193538, "주타 메이크업 & 퍼스널컬러"),
             (37.6371282, 127.0252103, "챠밍아틀리에 퍼스널컬러&메이크업"),
             (37.5193548, 127.0580459, "청담퍼스널컬러세븐에이알"),
             (37.5268022, 127.0407396, "한국패션심리연구원 퍼스널컬러자격증"),
             (37.5787240, 126.9697728, "어나더29"),
             (37.4939852, 127.0189055, "퍼스널컬러 메이크업 스튜디오 금옥살롱"),
             (37.5619014, 126.9955133, "색단비컬러컨설팅"),
             (37.5608356, 126.8296186, "퍼스널컬러 당신을 그리다"),
             (37.5812977, 126.9820353, "칼라코드 컬러연구소"),
             (37.4805094, 127.1232611, "라라 메이크업 & 퍼스널컬러 & 네일"),
             (37.6627548, 126.8895645, "퍼스널컬러 메이크업 이미지랩"),
             (37.5658177, 127.1912304, "엠피컬러 퍼스널컬러진단&메이크업"),
             (37.4823178, 127.1221100, "유아더 메이크업 & 퍼스널 컬러"),
             (37.7374682, 127.0448363, "퍼스널컬러 아리이미지"),
             (37.5616135, 127.1939457, "컬러엠 퍼스널컬러진단 및 자격증"),
             (37.5083996, 126.7240370, "로코블랑 퍼스널컬러"),
             (37.5570405, 126.9531538, "컬러튜드"),
             (37.3716373, 127.1071715, "블루아525퍼스널컬러코스메틱 분당정자점"),
             (37.5838749, 126.9994209, "컬러에딧"),
             (37.2942778, 126.9803515, "꼼쟁이네퍼스널컬러네일"),
             (37.5839822, 127.0020846, "돌핀컬러"),
             (37.2466737, 127.0565997, "블루아525퍼스널컬러심리연구소 수원망포점"),
             (37.5593420, 126.9451336, "세임컬러"),
             (37.5470564, 126.9542936, "컬러윙스"),
             (37.5657465, 127.0166374, "리랙셔리"),
             (37.5876039, 126.9497456, "FOR YOUR STYLE"),
             (37.5302767, 126.9684257, "이미지 케렌시아"),
             (37.5648791, 127.0264961, "블룸프로젝트"),
             (37.5558444, 126.9311620, "피엘컬러 기업부설연구소"),
             (37.5587222, 126.9233476, "컬러오브유"),
             (37.5566900, 126.9229406, "온도팔레트"),
             (37.5249444, 127.0266276, "몽끄컬러랩 본점"),
             (37.5540014, 126.9367182, "홀리몰리"),
             (37.5487522, 126.9214001, "히얼유어컬러"),
             (36.3362248, 127.3395425, "라피유벨 퍼스널컬러"),
             (37.5619129, 126.9154670, "코코리색채연구소 본점"),
             (33.4920961, 126.5397624, "WISE 퍼스널컬러"),
             (35.1513100, 126.9115920, "유피피컬러스튜디오 퍼스널컬러"),
             (34.8118813, 126.4195021, "디어온느 퍼스널컬러"),
             (37.3412468, 127.9719911, "라제이부티크 앤 퍼스널컬러진단(미용기능장)"),
             (37.5594774, 126.9241420, "지니비컬러"),
             (36.9841832, 127.9381005, "란쥬 메이크업&드레스&퍼스널컬러"),
             (35.1472602, 129.0656311, "퍼스널컬러 컬러로운"),
             (36.9698542, 127.9309824, "에스퍼스널컬러"),
             (35.1450419, 126.8430272, "누니컬러스튜디오 퍼스널컬러 진단"),
             (33.4880862, 126.4918835, "킹메이크업퍼스널컬러"),
             (37.3277397, 127.9784669, "하주선퍼스널컬러진단센터"),
             (37.5559575, 126.9272908, "이미지호 홍대점"),
             (35.1461386, 126.9107634, "더하루퍼스널컬러"),
             (34.8018700, 126.4272443, "버닝퍼스널컬러&퍼스널컨설팅"),
             (33.4840346, 126.4754746, "제주퍼스널컬러"),
             (37.5216279, 127.0218073, "코코리색채연구소 가로수길팝업스토어"),
             (35.1067640, 128.9653225, "퍼스널컬러 이미지앤컬러 브랜딩센터"),
             (37.5613795, 127.0345883, "예슬 이미지"),
             (37.5182230, 127.0208295, "컬러즈아트"),
             (37.5231010, 127.0324011, "마이쇼퍼 압구정점"),
             (37.5212559, 127.0461602, "유이레컬러"),
             (37.5126708, 127.0215947, "컬러에이치"),
             (37.5506545, 126.9148695, "리얼컬러"),
             (37.5207575, 126.9269566, "오콜로르 여의도점"),
             (37.5217254, 126.9266154, "블레스미 여의도점"),
             (37.5207575, 126.9269566, "라엘나"),
             (37.5497792, 126.9151005, "엘리이미지연구소"),
             (37.5010124, 127.0276623, "컬러가산다 강남센터"),
             (37.5158011, 127.0319377, "더빛날랩 강남점"),
             (37.5177526, 127.0260528, "네프끌레어"),
             (37.5120858, 127.0263326, "잇츠마이컬러"),
             (37.5465698, 127.0529437, "컬러블링"),
             (37.5488383, 127.0438934, "엘랑.M이미지"),
             (37.5240636, 126.9260425, "스토리 앤 스타일"),
             (37.5017470, 127.0253050, "제이닝 스튜디오 시코르 강남역점"),
             (37.5218999, 127.0203335, "에스이미지컬렉션"),
             (37.5181683, 127.0206946, "무드플러스"),
             (37.5435511, 127.0556140, "컬러츄"),
             (37.5080171, 127.0217538, "브리안느 이미지컨설팅 강남본점"),
             (37.5229252, 127.0477136, "제이앤이미지 퍼스널이미지브랜딩"),
             (37.5434989, 127.0580540, "누벨 이마주"),
             (37.5182363, 127.0420295, "스타일만"),
             (37.4982135, 127.0307752, "무드컬렉트 강남점"),
             (37.5252956, 127.0389767, "이미지유어즈"),
             (37.5281774, 126.8757769, "스튜디오 씨"),
             (37.5061086, 127.0272092, "컬러예보"),
             (37.5643352, 126.9094778, "디스타일"),
             (37.5659538, 126.9030647, "프론트퍼스널컨설팅"),
             (37.5110571, 127.0789070, "컬러올마이티"),
             (37.6371247, 127.0293982, "유어크로마"),
             (37.4940339, 127.0282402, "초이컬러"),
             (37.5085920, 127.0187691, "피플비츠"),
             (37.5071237, 126.8869550, "컬러챰"),
             (37.5179628, 126.9020104, "프롬컬러"),
             (37.4780053, 126.9618940, "오롯이컬러"),
             (37.5178094, 127.0414074, "크레비"),
             (37.4897482, 126.9294846, "컬러 마지끄"),
             (37.4948012, 127.0286234, "더이미지플러스"),
             (37.4830538, 126.9494565, "컬러데이즈"),
             (37.5127638, 126.9340656, "한국이미지메이킹연구소"),
             (37.5222886, 127.0547908, "파인드유컨설팅 강남점"),
             (37.5178094, 127.0414074, "벨르브릿츠"),
             (37.5232143, 127.0310143, "다흰휴먼브랜드컨설팅"),
             (37.5090877, 127.0186173, "컬러이즈"),
             (37.5091856, 127.0841766, "컬러마인"),
             (37.5067569, 127.1035934, "다채로윤"),
             (37.4915740, 127.0083593, "아소르이미지"),
             (37.5158269, 127.1151903, "스튜디오 씨큐"),

        ]
        
        // 데이터 배열을 순환하며 마커 추가
        for (latitude, longitude, title) in locationData {
            setMarker(latitude: latitude, longitude: longitude, title: title)
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
            infoWindow.open(with: marker)
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
        centerMapButton.backgroundColor = .tintColor
        centerMapButton.layer.cornerRadius = 10
        centerMapButton.layer.cornerRadius = 10
        centerMapButton.addTarget(self, action: #selector(centerMapOnUserButtonTapped), for: .touchUpInside)
        mapView.addSubview(centerMapButton)
    }
    
    
    
    
    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<Current Location>>>>>>>>>>>>>>>>
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
    
    
//    @objc func findNearestStoreButtonTapped() {
//        // 현재 사용자 위치를 가져옴.
//        guard let userLocation = mapView.locationOverlay.location else {
//            // 사용자 위치를 가져오지 못한 경우 처리
//            return
//        }
//
//        // 여기에서 가장 가까운 마커를 찾는 로직을 구현합니다.
//        // 예를 들어, 마커 배열을 순회하면서 각 마커와 사용자 위치 간의 거리를 계산하여 최소 거리를 찾을 수 있습니다.
//        var nearestMarker: NMFMarker?
//        var minDistance: CLLocationDistance = .greatestFiniteMagnitude
//
//        for marker in markers { // markers는 마커들을 저장한 배열
//            let markerLocation = marker.position
//            let distance = userLocation.distance(to: markerLocation)
//            if distance < minDistance {
//                minDistance = distance
//                nearestMarker = marker
//            }
//        }
//
//        // 가장 가까운 마커를 찾았으면 해당 마커로 지도 이동
//        if let nearestMarker = nearestMarker {
//            mapView.moveCamera(NMFCameraUpdate(scrollTo: nearestMarker.position))
//
//            // 이후 원하는 작업을 수행할 수 있습니다.
//            // 예를 들어, 해당 마커를 강조 표시하거나 정보창을 열 수 있습니다.
//        }
//    }

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
            
            
            
//----------------------------------------------------
//                            DispatchQueue.main.async {
//                                // 사용자의 현재 위치를 가져옵니다.
//                                let userLocation = NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude)
//
//                                // 현재 위치로 지도 중앙을 이동합니다.
////                                self.mapView.positionMode = .direction
////                                self.mapView.moveCamera(NMFCameraUpdate(scrollTo: userLocation))
//
//                                // 현재 위치를 파란색 원으로 표시합니다.
//                                let circleOverlay = NMFCircleOverlay()
//                                circleOverlay.center = userLocation
//                                circleOverlay.radius = 100
//                                circleOverlay.fillColor = UIColor.blue.withAlphaComponent(0.5)
//                                circleOverlay.mapView = self.mapView
//                            }
//
//        }
//        // startUpdatingLocation()을 사용하여 사용자 위치를 가져왔다면
//        // 불필요한 업데이트를 방지하기 위해 stopUpdatingLocation을 호출
//        locationManager.stopUpdatingLocation()
//    }
//---------------------------------------------------

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




//

//
