//
//  MapViewController.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/06.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // annotation enum value
    var annotationIcon = AnnotationIcon.Circle
    
    // 다이소나, 편의점 위치를 보여주는 테스트를 위한 좌표들
    let filterAnnotationTest_1: [TriangleAnnotation] = [
        TriangleAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.476828, longitude: 126.946994)),
        TriangleAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.474716, longitude: 126.923305)),
        TriangleAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.485750, longitude: 126.946823)),
    ]
    let filterAnnotationTest_2: [HexgonAnnotation] = [
        HexgonAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.460069, longitude: 126.943475)),
        HexgonAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.460274, longitude: 126.962101)),
        HexgonAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.472468, longitude: 126.921159)),
        HexgonAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.486908, longitude: 126.949827)),
    ]
    
    // 지도 바탕 검은색으로 세팅하기위한 전체 좌표값
    var outerCoordinates = [CLLocationCoordinate2D]()
    
    let mapView: MKMapView = {
        let view = MKMapView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 테스트 필터 아이콘 (나중에는 아마 컬렉션 뷰 셀로 들어가는 버튼)
    private let firstIconFilterBtn: IconFilterButton = {
        let btn = IconFilterButton()
        return btn
    }()
    private let secondIconFilterBtn: IconFilterButton = {
        let btn = IconFilterButton()
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getOuterCoordinater()
        
        // mapView 기본 세팅
        mapView.delegate = self
        
        // 좌표에 custom Pin 찍으려면 이렇게 View를 따로 만들어서 register로 등록을 해야함 + Identifier
        // -> 밑에 코드 보면 알겠지만 컬렉션 뷰, 테이블 뷰 처럼 annotation을 reuse하기 때문에 주의
        mapView.register(CircleAnnotationView.self, forAnnotationViewWithReuseIdentifier: "CircleAnnotationView")
        mapView.register(TriangleAnnotationView.self, forAnnotationViewWithReuseIdentifier: "TriangleAnnotationView")
        mapView.register(HexgonAnnotationView.self, forAnnotationViewWithReuseIdentifier: "HexgonAnnotationView")
        
        view.addSubview(mapView)
        
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        mapView.addSubview(firstIconFilterBtn)
        mapView.addSubview(secondIconFilterBtn)
        
        firstIconFilterBtn.setTitle("첫번째", for: .normal)
        firstIconFilterBtn.addTarget(self, action: #selector(firstIconFilterBtnAction), for: .touchUpInside)
        firstIconFilterBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        secondIconFilterBtn.setTitle("두번째", for: .normal)
        secondIconFilterBtn.addTarget(self, action: #selector(secondIconFilterBtnAction), for: .touchUpInside)
        secondIconFilterBtn.topAnchor.constraint(equalTo: firstIconFilterBtn.bottomAnchor, constant: 30).isActive = true
        
        // MARK: - Example
        //
        // 지도 들어가면 맨 처음 보여지는 위치
        let coordinate = CLLocationCoordinate2D(latitude: 37.489332, longitude: 126.923823)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        // 2호선 까치산 ~ 대림 까지 pin
        let annotation: [CircleAnnotation] = [
            CircleAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.5317675, longitude: 126.8467055)),
            CircleAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.520234, longitude: 126.852868)),
            CircleAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.512322, longitude: 126.865633)),
            CircleAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.51447, longitude: 126.88264)),
            CircleAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.5088099, longitude: 126.8912061)),
            CircleAnnotation(__coordinate: CLLocationCoordinate2D(latitude: 37.5317675, longitude: 126.8467055)),
        ]
        mapView.addAnnotations(annotation)
        
        // 2호선 까치산 ~ 대림 까지 line
        let polylineCoordinates = [
            CLLocationCoordinate2D(latitude: 37.5317675, longitude: 126.8467055),
            CLLocationCoordinate2D(latitude: 37.520234, longitude: 126.852868),
            CLLocationCoordinate2D(latitude: 37.512322, longitude: 126.865633),
            CLLocationCoordinate2D(latitude: 37.51447, longitude: 126.88264),
            CLLocationCoordinate2D(latitude: 37.5088099, longitude: 126.8912061),
            CLLocationCoordinate2D(latitude: 37.4925043, longitude: 126.8949615),
        ]
        let polyline = MKPolyline(coordinates: polylineCoordinates, count: polylineCoordinates.count)
        mapView.addOverlay(polyline)
        
        // 동네 좌표 (여러개 추가 가능)
        let points = [
            CLLocationCoordinate2D(latitude: 37.601839, longitude: 126.981634),
            CLLocationCoordinate2D(latitude: 37.602722, longitude: 126.994601),
            CLLocationCoordinate2D(latitude: 37.595726, longitude: 127.004827),
            CLLocationCoordinate2D(latitude: 37.591601, longitude: 126.999156),
            CLLocationCoordinate2D(latitude: 37.591672, longitude: 126.982768),
            CLLocationCoordinate2D(latitude: 37.601839, longitude: 126.981634),
        ]
        let points2 = [
            CLLocationCoordinate2D(latitude: 37.489332, longitude: 126.923823),
            CLLocationCoordinate2D(latitude: 37.490990, longitude: 126.943416),
            CLLocationCoordinate2D(latitude: 37.467443, longitude: 126.952557),
            CLLocationCoordinate2D(latitude: 37.476818, longitude: 126.926963),
            CLLocationCoordinate2D(latitude: 37.471684, longitude: 126.894900),
            CLLocationCoordinate2D(latitude: 37.489332, longitude: 126.923823),
        ]
        
        var innerPolygons = [MKPolygon]()
        let poly = MKPolygon(coordinates: points, count: points.count)
        let poly2 = MKPolygon(coordinates: points2, count: points2.count)
        innerPolygons.append(poly)
        innerPolygons.append(poly2)
        
        // 지도 동네 부분 제외 검은색으로 세팅
        let polygon = MKPolygon(coordinates: outerCoordinates, count: outerCoordinates.count, interiorPolygons: innerPolygons)
        mapView.addOverlay(polygon)
        
        // 동네 부분만 검은색으로 세팅
        //        mapView.addOverlays(innerPolygons)
    }
    
    // add, remove로 annotaion을 추가 제거하면 지도에서 pin이 보이고 사라짐
    // 이거 하려면 해당 좌표값들 잘 가지고 있어야 함
    @objc func firstIconFilterBtnAction() {
        if firstIconFilterBtn.isSelected {
            mapView.removeAnnotations(filterAnnotationTest_1)
        } else {
            annotationIcon = .Triangle
            mapView.addAnnotations(filterAnnotationTest_1)
        }
        firstIconFilterBtn.isSelected.toggle()
    }
    
    @objc func secondIconFilterBtnAction() {
        if secondIconFilterBtn.isSelected {
            mapView.removeAnnotations(filterAnnotationTest_2)
        } else {
            annotationIcon = .Hexgon
            mapView.addAnnotations(filterAnnotationTest_2)
        }
        secondIconFilterBtn.isSelected.toggle()
    }
}

extension MapViewController: MKMapViewDelegate {
    
    // MKCircle : 원형 모양 (원 가운데 좌표 세팅하고 범위 지정)
    // MKPolyline : 단순 선 (좌표 두개 선으로 이음)
    // MKPolygon : 도형 (선 이어서 사각형이든 어떤 모양이든 만들 수 있음)
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 2
            return renderer
            
        } else if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.green
            renderer.lineWidth = 5
            return renderer
            
        } else if overlay is MKPolygon {
            let renderer = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
            renderer.strokeColor = UIColor.orange
            renderer.lineWidth = 2
            return renderer
        }
        
        return MKOverlayRenderer()
    }
    
    // custom pin (image)
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        var annotationView: MKAnnotationView?
        
        switch annotation {
        case is CircleAnnotation:
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "CircleAnnotationView", for: annotation)
            annotationView?.image = UIImage(systemName: "circle")
        case is TriangleAnnotation:
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "TriangleAnnotationView", for: annotation)
            annotationView?.image = UIImage(systemName: "triangle.fill")
        case is HexgonAnnotation:
            annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "HexgonAnnotationView", for: annotation)
            annotationView?.image = UIImage(systemName: "hexagon.fill")
        default:
            break
        }
        if annotationView == nil {
            switch annotationIcon {
            case .Circle:
                annotationView = CircleAnnotationView(annotation: annotation, reuseIdentifier: "CircleAnnotationView")
                annotationView?.image = UIImage(systemName: "circle")
                annotationView?.annotation = CircleAnnotation()
            case .Triangle:
                annotationView = TriangleAnnotationView(annotation: annotation, reuseIdentifier: "TriangleAnnotationView")
                annotationView?.image = UIImage(systemName: "triangle.fill")
                annotationView?.annotation = TriangleAnnotation()
            case .Hexgon:
                annotationView = HexgonAnnotationView(annotation: annotation, reuseIdentifier: "HexgonAnnotationView")
                annotationView?.image = UIImage(systemName: "hexagon.fill")
                annotationView?.annotation = TriangleAnnotation()
            }
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    // outerCoordinates 값 세팅
    func getOuterCoordinater() {
        for i in -90...90 {
            outerCoordinates.append(
                CLLocationCoordinate2D(latitude: Double(i), longitude: -180)
            )
        }
        for i in -180...180 {
            outerCoordinates.append(
                CLLocationCoordinate2D(latitude: 90, longitude: Double(i))
            )
        }
        for i in -90...90 {
            outerCoordinates.append(
                CLLocationCoordinate2D(latitude: Double(i * -1), longitude: 180)
            )
        }
        for i in -180...180 {
            outerCoordinates.append(
                CLLocationCoordinate2D(latitude: -90, longitude: Double(i * -1))
            )
        }
    }
}

enum AnnotationIcon: String {
    case Circle = "circle"
    case Triangle = "triangle.fill"
    case Hexgon = "hexagon.fill"
}

final class CircleAnnotationView: MKAnnotationView {
    override func prepareForReuse() {
        super.prepareForReuse()
        image = UIImage(systemName: "circle")
    }
}
final class CircleAnnotation: MKPointAnnotation { }

final class TriangleAnnotationView: MKAnnotationView {
    override func prepareForReuse() {
        super.prepareForReuse()
        image = UIImage(systemName: "triangle.fill")
    }
}
final class TriangleAnnotation: MKPointAnnotation { }

final class HexgonAnnotationView: MKAnnotationView {
    override func prepareForReuse() {
        super.prepareForReuse()
        image = UIImage(systemName: "hexgon.fill")
    }
}
final class HexgonAnnotation: MKPointAnnotation { }
