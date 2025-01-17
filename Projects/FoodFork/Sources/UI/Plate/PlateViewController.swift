//
//  PlateViewController.swift
//  FoodFork
//
//  Created by Ivy Moon on 2023/03/12.
//

import UIKit
import RxSwift
import KakaoMapsSDK
import Design

class PlateViewController: UINavigationController, ViewLayout {
    let disposeBag = DisposeBag()

    var observerAdded: Bool = false
    var auth: Bool = false
    var appear: Bool = false

    lazy var plateView = PlateView()

    let viewModel = PlateViewModel()

    var navigation: NavigationDelegate? {
        didSet {
            plateView.navigation = navigation
        }
    }

    deinit {
        viewModel.mapController?.pauseEngine()
        viewModel.mapController?.resetEngine()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setAttribute()
        setBind()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadFork()
        plateView.list.reloadData()

        addObservers()
        appear = true
        if viewModel.mapController?.isEnginePrepared == false {
            viewModel.mapController?.prepareEngine()
        }

        if viewModel.mapController?.isEngineActive == false {
            viewModel.mapController?.activateEngine()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        appear = false
        viewModel.mapController?.pauseEngine()  // 렌더링 중지.
    }

    override func viewDidDisappear(_ animated: Bool) {
        removeObservers()
        viewModel.mapController?.resetEngine()     // 엔진 정지. 추가되었던 ViewBase들이 삭제된다.
    }

    func setLayout() {
        self.view = plateView
    }

    func setAttribute() {
        viewModel.mapController = KMController(viewContainer: plateView.map)
        viewModel.mapController?.delegate = self
        viewModel.mapController?.prepareEngine() // 엔진 초기화. 엔진 내부 객체 생성 및 초기화가 진행된다.

        plateView.viewModel = viewModel

        self.plateView.list.register(PlateItemView.self, forCellReuseIdentifier: PlateItemView.id)
    }

    func setBind() {
        viewModel.forkInfo
            .bind(to: plateView.list.rx.items(cellIdentifier: PlateItemView.id,
                                              cellType: PlateItemView.self) ) { _, data, cell in
            cell.setData(data)
        }
        .disposed(by: disposeBag)

        plateView.list.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let info = viewModel.forkInfo.value[indexPath.row]
                viewModel.selectFork(fork: info)
                plateView.list.deselectRow(at: indexPath, animated: false)
                plateView.detailView.setData(info)
                plateView.showDetail(true)
            })
            .disposed(by: disposeBag)

        viewModel.selectFork.bind(onNext: { [weak self] info in
            guard let self = self else { return }
            if let info = info {
                plateView.showDetail(true)
                plateView.detailView.setData(info)
            } else {
                plateView.showDetail(false)
            }
        })
        .disposed(by: disposeBag)

        viewModel.mapPoint.bind(onNext: { [weak self] point in
            guard let self = self else { return }
            guard let view: KakaoMap = viewModel.mapController?.getView("mapview") as? KakaoMap else { return }

            let rect = AreaRect(points: [MapPoint(longitude: point.x, latitude: point.y)])
            view.animateCamera(cameraUpdate: CameraUpdate.make(area: rect),
                               options: CameraAnimationOptions(autoElevation: false,
                                                               consecutive: false,
                                                               durationInMillis: 1000)) { () in
                view.getLabelManager().getLabelLayer(layerID: "PoiLayer")?.showAllPois()
            }
        })
        .disposed(by: disposeBag)

    }

}

extension PlateViewController: MapControllerDelegate {
    // 인증 성공시 delegate 호출.
    func authenticationSucceeded() {
        // 일반적으로 내부적으로 인증과정 진행하여 성공한 경우 별도의 작업은 필요하지 않으나,
        // 네트워크 실패와 같은 이슈로 인증실패하여 인증을 재시도한 경우, 성공한 후 정지된 엔진을 다시 시작할 수 있다.
        if auth == false {
            auth = true
        }

        if appear && viewModel.mapController?.isEngineActive == false {
            viewModel.mapController?.activateEngine()
        }
    }

    // 인증 실패시 호출.
    func authenticationFailed(_ errorCode: Int, desc: String) {
        print("error code: \(errorCode)")
        print("desc: \(desc)")
        auth = false
        switch errorCode {
        case 400:
            showToast(self.view, message: "지도 종료(API인증 파라미터 오류)")
            case 401:
            showToast(self.view, message: "지도 종료(API인증 키 오류)")
            case 403:
            showToast(self.view, message: "지도 종료(API인증 권한 오류)")
            case 429:
            showToast(self.view, message: "지도 종료(API 사용쿼터 초과)")
            case 499:
            showToast(self.view, message: "지도 종료(네트워크 오류) 5초 후 재시도..")

            // 인증 실패 delegate 호출 이후 5초뒤에 재인증 시도..
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                print("retry auth...")

                self.viewModel.mapController?.prepareEngine()
            }
        default:
            break
        }
    }

    func addViews() {
        // 여기에서 그릴 View(KakaoMap, Roadview)들을 추가한다.
        let defaultPosition = MapPoint(longitude: viewModel.mapPoint.value.x, latitude: viewModel.mapPoint.value.y)
        // 지도(KakaoMap)를 그리기 위한 viewInfo를 생성
        let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview",
                                                   viewInfoName: "map",
                                                   defaultPosition: defaultPosition,
                                                   defaultLevel: 7)

        // KakaoMap 추가.
        viewModel.mapController?.addView(mapviewInfo)
    }

    func moveView(_ point: CGPoint) {

        if viewModel.mapController?.getView("mapview") != nil {
            print("move")
//            let size = view.viewRect.size
//            view.viewRect.size = size
//            view.viewRect.origin = point
            viewModel.mapController?.removeView("mapview")
            let defaultPosition = MapPoint(longitude: viewModel.mapPoint.value.x, latitude: viewModel.mapPoint.value.y)
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview",
                                                       viewInfoName: "map",
                                                       defaultPosition: defaultPosition,
                                                       defaultLevel: 7)
            viewModel.mapController?.addView(mapviewInfo)

        }
    }

    func viewInit(viewName: String) {
        createPois()
    }

    // addView 성공 이벤트 delegate. 추가적으로 수행할 작업을 진행한다.
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        if let view = viewModel.mapController?.getView("mapview") as? KakaoMap {
            view.viewRect = plateView.map.bounds    // 뷰 add 도중에 resize 이벤트가 발생한 경우 이벤트를 받지 못했을 수 있음. 원하는 뷰 사이즈로 재조정.
            viewInit(viewName: viewName)
        }
    }

    // addView 실패 이벤트 delegate. 실패에 대한 오류 처리를 진행한다.
    func addViewFailed(_ viewName: String, viewInfoName: String) {
        print("Failed")
    }

    // Container 뷰가 리사이즈 되었을때 호출된다. 변경된 크기에 맞게 ViewBase들의 크기를 조절할 필요가 있는 경우 여기에서 수행한다.
    func containerDidResized(_ size: CGSize) {
        let mapView: KakaoMap? = viewModel.mapController?.getView("mapview") as? KakaoMap
        mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)   // 지도뷰의 크기를 리사이즈된 크기로 지정한다.
    }

    func addObservers() {
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(willResignActive),
                         name: UIApplication.willResignActiveNotification,
                         object: nil)
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(didBecomeActive),
                         name: UIApplication.didBecomeActiveNotification,
                         object: nil)

        observerAdded = true
    }

    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)

        observerAdded = false
    }

    @objc func willResignActive() {
        viewModel.mapController?.pauseEngine()  // 뷰가 inactive 상태로 전환되는 경우 렌더링 중인 경우 렌더링을 중단.
    }

    @objc func didBecomeActive() {
        viewModel.mapController?.activateEngine()
        // 뷰가 active 상태가 되면 렌더링 시작. 엔진은 미리 시작된 상태여야 함.
    }
}

extension PlateViewController {
    func createPois() {
        // Poi가 속할 레이어 생성
        let mapView: KakaoMap? = viewModel.mapController?.getView("mapview") as? KakaoMap
        let labelManager = mapView?.getLabelManager()
        let layer = labelManager?.addLabelLayer(option: LabelLayerOptions(layerID: "PoiLayer",
                                                                          competitionType: .none,
                                                                          competitionUnit: .poi,
                                                                          orderType: .rank, zOrder: 0))

        // Poi가 그려질 스타일 생성
        let iconOffStyle = PoiIconStyle(symbol: UIImage(named: "Marker_Off")!, anchorPoint: CGPoint(x: 0.0, y: 0.5))
        let perLevelOffStyle = PerLevelPoiStyle(iconStyle: iconOffStyle, level: 0)
        let poiOffStyle = PoiStyle(styleID: "PoiOffStyle", styles: [perLevelOffStyle])
        labelManager?.addPoiStyle(poiOffStyle)

        let iconOnStyle = PoiIconStyle(symbol: UIImage(named: "Marker_On")!, anchorPoint: CGPoint(x: 0.0, y: 0.5))
        let perLevelOnStyle = PerLevelPoiStyle(iconStyle: iconOnStyle, level: 0)
        let poiOnStyle = PoiStyle(styleID: "PoiOnStyle", styles: [perLevelOnStyle])
        labelManager?.addPoiStyle(poiOnStyle)

        for info in viewModel.forkInfo.value {
            let options = PoiOptions(styleID: "PoiOffStyle", poiID: info.uuid?.uuidString ?? "")
            options.clickable = true
            _ = layer?.addPoi(option: options,
                              at: info.getMapPoint() ?? .init(longitude: 0,
                                                              latitude: 0))
            { [weak mapView, weak layer](poi: Poi?) in
                guard mapView != nil else { return }
                guard layer != nil else { return }
                _ = poi?.addPoiTappedEventHandler(target: self, handler: PlateViewController.clickedButtonPoi(_:))
                poi?.show()
            }
        }
    }

    func clickedButtonPoi(_ param: PoiInteractionEventParam) {
        viewModel.selectFork(uuid: param.poiItem.itemID)
        param.poiItem.changeStyle(styleID: "PoiOnStyle", enableTransition: true)
    }
}
