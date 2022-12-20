//
//  NaverMapViewController.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/15.
//

import UIKit
import RxSwift
import RxCocoa
import NMapsMap

final class NaverMapViewController: UIViewController, NMFMapViewTouchDelegate {
    
    lazy var mapView = NMFMapView()
    
    var disposeBag = DisposeBag()
    let themeModel: [ThemeModel] = [
        ThemeModel(category: "food", name: "혼밥잘하는집 신림점", address: "서울시 관악구 호암로26", time: "10:00-21:00"),
        ThemeModel(category: "food", name: "혼밥잘하는집 신림점", address: "서울시 관악구 호암로26", time: "10:00-21:00"),
        ThemeModel(category: "food", name: "혼밥잘하는집 신림점", address: "서울시 관악구 호암로26", time: "10:00-21:00"),
        ThemeModel(category: "food", name: "혼밥잘하는집 신림점", address: "서울시 관악구 호암로26", time: "10:00-21:00")
    ]
    
    let searchCategoryModel: [SearchCategoryModel] = [
        SearchCategoryModel(kind: "인프라"),
        SearchCategoryModel(kind: "치안"),
        SearchCategoryModel(kind: "교통")
    ]
    
    private let themeCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 80)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ThemeMapStoreCell.self, forCellWithReuseIdentifier: "ThemeMapStoreCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let fillterCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(FillterCollectionViewCell.self, forCellWithReuseIdentifier: "FillterCollectionViewCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        //        cv.backgroundColor = .yellow
        return cv
    }()
    
    private let roundButton: YPButton = {
        let btn = YPButton(style: .roundType)
        btn.setTitle(normalTitle: "동네 소개로 이동", selectedTitle: "동네 지도로 이동")
        btn.setImage(normalImageName: "message", selectedImageName: "map")
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        view.addSubview(themeCollectionView)
        view.addSubview(roundButton)
        view.addSubview(fillterCollectionView)
        
        roundButton.addTarget(self, action: #selector(roundButtonAction), for: .touchUpInside)
        
        themeCollectionView.backgroundColor = .clear
        fillterCollectionView.backgroundColor = .clear
        
        mapView.touchDelegate = self
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            themeCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            themeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            themeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            themeCollectionView.heightAnchor.constraint(equalToConstant: 160),
            
            roundButton.topAnchor.constraint(equalTo: themeCollectionView.bottomAnchor, constant: 30),
            roundButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fillterCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant:80),
            fillterCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            fillterCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            fillterCollectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        Observable.just(themeModel)
            .bind(to: themeCollectionView.rx.items(cellIdentifier: "ThemeMapStoreCell", cellType: ThemeMapStoreCell.self)) { index, model, cell in
                cell.bind(model)
            }
            .disposed(by: disposeBag)
        
        themeCollectionView.rx.modelSelected(ThemeModel.self)
            .subscribe { model in
                print("tap \(model.map {$0.name})")
            }
            .disposed(by: disposeBag)
        
        themeCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        Observable.just(searchCategoryModel)
            .bind(to: fillterCollectionView.rx.items(cellIdentifier: "FillterCollectionViewCell", cellType: FillterCollectionViewCell.self)) { index, model, cell in
                cell.bind(model)
            }
            .disposed(by: disposeBag)
        
        
        // 맵 명암 (default 0)
        //        mapView.lightness = -0.5
        
        // 시작 위치
        let coord = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        mapView.moveCamera(cameraUpdate)
        
        // 지도옵션 -> 레이어 그룹
        mapView.setLayerGroup(NMF_LAYER_GROUP_MOUNTAIN, isEnabled: true)
        mapView.setLayerGroup(NMF_LAYER_GROUP_TRANSIT, isEnabled: true)
        
        // 마커
        let marker = NMFMarker()
        
        // 기본 마커 -> 커스텀 이미지 마커로 변경
        let image = NMFOverlayImage(image: UIImage(systemName: "map")!)
        marker.iconImage = image
        
        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
        marker.mapView = mapView
        
        // 마커 색깔 변경
        marker.iconTintColor = UIColor.red
        
        // 마커 크기 변경
        // NMF_MARKER_SIZE_AUTO -> 이미지에 맞게 자동으로 크게 맞춰줌
        marker.width = CGFloat(NMF_MARKER_SIZE_AUTO)
        marker.height = CGFloat(NMF_MARKER_SIZE_AUTO)
        
        // 마커에 택스트 추가 + captionRequestedWidth로 길이 제한
        marker.captionRequestedWidth = 100
        marker.captionText = "아주아주아주아주아주 아주아주아주아주 긴 캡션"
        
        // 택스트 위치 설정
        marker.captionAligns = [NMFAlignType.top]
        
        // 택스트 색깔
        marker.captionColor = UIColor.blue
        marker.captionHaloColor = UIColor(red: 200.0/255.0, green: 1, blue: 200.0/255.0, alpha: 1)
        
        // 택스트 크기
        marker.captionTextSize = 16
        
        // 택스트 특정 줌 레벨에서만 보이게
        // 예시는 12 ~ 16 사이에서만 보임
        marker.captionMinZoom = 12
        marker.captionMaxZoom = 16
        
        // 간격
        marker.captionOffset = 15
        
        // 오버레이 탭 (예시는 마커)
        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
            print("마커 터치")
            return true // 이벤트 소비, -mapView:didTapMap:point 이벤트는 발생하지 않음
        }
        
        // 카메라 줌 늘릴 수 있는 최소값 (작으면 작을수록 지도를 더 넓게 크게 볼 수 있음)
        // 10.0 으로 최대한 넓게 땡기면 이면 대충 서울시, 의정부시, 양주시
        // 5.0 이면 대한민국이 다 보이도록까지 땡길 수 있음
        //
        mapView.minZoomLevel = 5.0
        // 카메라 줌 땡길 수 있는 최대값 (높으면 높을수록 더 지도를 자세하게 볼 수 있음)
        mapView.maxZoomLevel = 18.0
        
        // 카메라 영역 제한 -> 밑에 값은 한반도 인근으로 카메라 이동 제한
        // 원한다면 서울, 경기도 제한 가능할 듯?
        mapView.extent = NMGLatLngBounds(southWestLat: 31.43, southWestLng: 122.37, northEastLat: 44.35, northEastLng: 132)
        
        
        // 겹쳤을 때 어떤 마커를 더 보이게 하고, 숨기고
        // 겹치더라도 무조건 표시해야하는 마커 이런것도 세팅 가능
        // 오버레이 -> 마커 -> 하단
        
        // 폴리곤 그릴 좌표들 (써클 모양으로도 가능)
        // 대한민국 전체 좌표 사각형으로 크게 그려서 .black.withAlphaComponent 덮음
        // 동 표시할 좌표 interiorRings에 넣어주면 전체 덮은거에서 제외 (원래 지도 색으로 보임)
        // 반대로도 가능
        
        let 사직동 = [
            NMGLatLng(lat: 37.575650779448786, lng: 126.976888842748167),
            NMGLatLng(lat: 37.569194530054553, lng: 126.977034498877501),
            NMGLatLng(lat: 37.569336299425764, lng: 126.975974728212492),
            NMGLatLng(lat: 37.569315567021562, lng: 126.975374709912543),
            NMGLatLng(lat: 37.569261800517531, lng: 126.974331935623255),
            NMGLatLng(lat: 37.568194417708334, lng: 126.969048370018541),
            NMGLatLng(lat: 37.568427679612761, lng: 126.968544936033837),
            NMGLatLng(lat: 37.569491655206583, lng: 126.966649959821197),
            NMGLatLng(lat: 37.569700734798701, lng: 126.966281750244846),
            NMGLatLng(lat: 37.569856509723699, lng: 126.966097327080405),
            NMGLatLng(lat: 37.570183936115114, lng: 126.965728529225771),
            NMGLatLng(lat: 37.570318805686199, lng: 126.965926998221278),
            NMGLatLng(lat: 37.571548395577466, lng: 126.96601094018429),
            NMGLatLng(lat: 37.575174660660373, lng: 126.963659220521961),
            NMGLatLng(lat: 37.576485920015543, lng: 126.963086004345101),
            NMGLatLng(lat: 37.57666158609274, lng: 126.962840990511978),
            NMGLatLng(lat: 37.579448809656775, lng: 126.962810410472628),
            NMGLatLng(lat: 37.579601537124489, lng: 126.967424315843317),
            NMGLatLng(lat: 37.579263521441646, lng: 126.967421763026508),
            NMGLatLng(lat: 37.579192577998604, lng: 126.967430060184597),
            NMGLatLng(lat: 37.578975250585437, lng: 126.967457090095607),
            NMGLatLng(lat: 37.578246780467872, lng: 126.968066046996256),
            NMGLatLng(lat: 37.577935262340283, lng: 126.968955116954774),
            NMGLatLng(lat: 37.577935299309388, lng: 126.969212842969057),
            NMGLatLng(lat: 37.578121124142164, lng: 126.969414538865792),
            NMGLatLng(lat: 37.578531136682209, lng: 126.969664426694706),
            NMGLatLng(lat: 37.578736205134931, lng: 126.969667219148718),
            NMGLatLng(lat: 37.578992879009881, lng: 126.969668773533087),
            NMGLatLng(lat: 37.57911252674959, lng: 126.969669499103631),
            NMGLatLng(lat: 37.579301753628734, lng: 126.969904573616262),
            NMGLatLng(lat: 37.57951327793981, lng: 126.97135197544759),
            NMGLatLng(lat: 37.579372140302631, lng: 126.973819257844539),
            NMGLatLng(lat: 37.578487073041011, lng: 126.973917363383421),
            NMGLatLng(lat: 37.578240429978088, lng: 126.973939619980882),
            NMGLatLng(lat: 37.575749906299862, lng: 126.974331538357575),
            NMGLatLng(lat: 37.575649468824203, lng: 126.975803789978045),
            NMGLatLng(lat: 37.575650779448786, lng: 126.976888842748167),
        ]
        
        let 삼청동 = [
            NMGLatLng(lat: 37.595065519422398, lng: 126.98268938649305),
            NMGLatLng(lat: 37.594351925516882, lng: 126.983372584569992),
            NMGLatLng(lat: 37.593850468126433, lng: 126.983868097928024),
            NMGLatLng(lat: 37.593755381897623, lng: 126.984011583697296),
            NMGLatLng(lat: 37.593581837353476, lng: 126.984273496190852),
            NMGLatLng(lat: 37.593331231471026, lng: 126.984678767240084),
            NMGLatLng(lat: 37.5930571567418, lng: 126.985225359852748),
            NMGLatLng(lat: 37.593026356335294, lng: 126.985286808140827),
            NMGLatLng(lat: 37.593005726214919, lng: 126.985328725807221),
            NMGLatLng(lat: 37.592794011604347, lng: 126.985759277179199),
            NMGLatLng(lat: 37.592506465665572, lng: 126.986479840783815),
            NMGLatLng(lat: 37.592246800190104, lng: 126.987526228202512),
            NMGLatLng(lat: 37.592104003075761, lng: 126.988760809134106),
            NMGLatLng(lat: 37.591953415500925, lng: 126.989109450717322),
            NMGLatLng(lat: 37.5917950211998, lng: 126.989475792086679),
            NMGLatLng(lat: 37.591394461628269, lng: 126.989075048100133),
            NMGLatLng(lat: 37.59055671520521, lng: 126.987898495808849),
            NMGLatLng(lat: 37.589015966651431, lng: 126.986210027969463),
            NMGLatLng(lat: 37.588201649920947, lng: 126.986013874282506),
            NMGLatLng(lat: 37.588020241414476, lng: 126.986010874237252),
            NMGLatLng(lat: 37.587418359612826, lng: 126.985956964282408),
            NMGLatLng(lat: 37.587075122228988, lng: 126.985790128959266),
            NMGLatLng(lat: 37.586145890121195, lng: 126.985337100030677),
            NMGLatLng(lat: 37.585633285496741, lng: 126.984974362286536),
            NMGLatLng(lat: 37.585373689951126, lng: 126.984465332345323),
            NMGLatLng(lat: 37.584970435538899, lng: 126.983714217816214),
            NMGLatLng(lat: 37.583458326946833, lng: 126.982918386510292),
            NMGLatLng(lat: 37.583227993147531, lng: 126.982849315927382),
            NMGLatLng(lat: 37.582854067043328, lng: 126.98283620716704),
            NMGLatLng(lat: 37.582717763620884, lng: 126.982842104010956),
            NMGLatLng(lat: 37.582606322658101, lng: 126.982864819894829),
            NMGLatLng(lat: 37.582057058640778, lng: 126.982991787047098),
            NMGLatLng(lat: 37.578433706719778, lng: 126.984034695368365),
            NMGLatLng(lat: 37.577342343203007, lng: 126.984639624275033),
            NMGLatLng(lat: 37.576674025462005, lng: 126.98553316382565),
            NMGLatLng(lat: 37.576335880365889, lng: 126.984948844182966),
            NMGLatLng(lat: 37.576064525106403, lng: 126.984344788680914),
            NMGLatLng(lat: 37.575526362928613, lng: 126.983146652391852),
            NMGLatLng(lat: 37.575943353839534, lng: 126.979839036050819),
            NMGLatLng(lat: 37.57597727455633, lng: 126.979592489109393),
            NMGLatLng(lat: 37.576607041918628, lng: 126.979605791284357),
            NMGLatLng(lat: 37.577161447995692, lng: 126.979617516158967),
            NMGLatLng(lat: 37.578609551100712, lng: 126.97968954034279),
            NMGLatLng(lat: 37.579131431874536, lng: 126.979741125299739),
            NMGLatLng(lat: 37.580086995769008, lng: 126.980028224961956),
            NMGLatLng(lat: 37.580986173619728, lng: 126.980303701624806),
            NMGLatLng(lat: 37.585900230324711, lng: 126.979417938903708),
            NMGLatLng(lat: 37.587178178288674, lng: 126.978973668856298),
            NMGLatLng(lat: 37.587271277315921, lng: 126.978879575772694),
            NMGLatLng(lat: 37.58929695337158, lng: 126.976566811817619),
            NMGLatLng(lat: 37.58929695337158, lng: 126.976566811817619),
            NMGLatLng(lat: 37.589545227974334, lng: 126.97615022517256),
            NMGLatLng(lat: 37.589684034240094, lng: 126.975693343513328),
            NMGLatLng(lat: 37.59259411899388, lng: 126.97363965976345),
            NMGLatLng(lat: 37.593289023280704, lng: 126.973587263553426),
            NMGLatLng(lat: 37.596564222244091, lng: 126.975851137756862),
            NMGLatLng(lat: 37.595065101105888, lng: 126.98105808767329),
            NMGLatLng(lat: 37.595065519422398, lng: 126.98268938649305),
        ]
        
        // 폴리곤 테두리 굵기 및 색깔
        //        polygonOverlay?.outlineWidth = 3
        //        polygonOverlay?.outlineColor = UIColor.green
        
        //        let polygon사직동 = NMGPolygon(ring: NMGLineString(points: 사직동))
        //        let polygonOverlay사직동 = NMFPolygonOverlay(polygon사직동 as! NMGPolygon<AnyObject>)
        //        polygonOverlay사직동?.fillColor = .green
        //        polygonOverlay사직동?.mapView = mapView
        //
        //        let polygon삼청동 = NMGPolygon(ring: NMGLineString(points: 삼청동))
        //        let polygonOverlay삼청동 = NMFPolygonOverlay(polygon삼청동 as! NMGPolygon<AnyObject>)
        //        polygonOverlay삼청동?.fillColor = .green
        //        polygonOverlay삼청동?.mapView = mapView
        
        // 피그마 디자인 대로 처리
        // 폴리곤 내부 홀
        let polygon = NMGPolygon(ring: NMGLineString(points: [
            NMGLatLng(lat: 39.327518, lng: 124.517393),
            NMGLatLng(lat: 39.588436, lng: 128.985682),
            NMGLatLng(lat: 35.251701, lng: 131.426344),
            NMGLatLng(lat: 33.218602, lng: 124.799008),
            NMGLatLng(lat: 39.327518, lng: 124.517393),
        ]), interiorRings: [
            NMGLineString(points: 사직동),
            NMGLineString(points: 삼청동)
        ])

        let polygonOverlay = NMFPolygonOverlay(polygon as! NMGPolygon<AnyObject>)
        polygonOverlay?.fillColor = .black.withAlphaComponent(0.5)
        polygonOverlay?.mapView = mapView
    }
    
    // 지도 탭 + 심벌 아닌 탭
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("지도 탭")
        print("\(latlng.lat), \(latlng.lng)")
    }
    // 지도 탭 + 심벌 탭
    func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
        if symbol.caption == "서울특별시청" {
            print("서울시청 탭")
            return true
            
        } else {
            print("\(symbol.caption!) symbol 탭")
            return false
        }
    }
    
    @objc func roundButtonAction() {
        roundButton.isSelected.toggle()
    }
}

extension NaverMapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 120, height: 160)
    }
}
