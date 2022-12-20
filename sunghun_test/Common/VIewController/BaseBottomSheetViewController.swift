//
//  BaseBottomSheetViewController.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/07.
//

import UIKit

class BaseBottomSheetViewController: BaseViewController {
    
    // MARK: - Properties
    //
    let bottomHeight: CGFloat = 360
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    // MARK: - Views
    //
    private let dimmedBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.0
        return view
    }()
    let bottomSheetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 27
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    private let dismissIndicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray2
        view.layer.cornerRadius = 3
        return view
    }()
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheet()
    }
    
    // MARK: - Functions
    //
    override func addView() {
        [dimmedBackView, bottomSheetView, dismissIndicatorView].forEach {
            view.addSubview($0)
        }
        
    }
    
    override func setupView() { }
    
    override func setLayout() {
        NSLayoutConstraint.activate([
            dimmedBackView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let top = window?.safeAreaInsets.top ?? 0
        let bottom = window?.safeAreaInsets.bottom ?? 0
        
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant - top - bottom
        )
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSheetViewTopConstraint
        ])
        
        NSLayoutConstraint.activate([
            dismissIndicatorView.widthAnchor.constraint(equalToConstant: 100),
            dismissIndicatorView.heightAnchor.constraint(equalToConstant: 7),
            dismissIndicatorView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 10),
            dismissIndicatorView.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor)
        ])
    }
    
    private func setupGestureRecognizer() {
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedBackView.addGestureRecognizer(dimmedTap)
        dimmedBackView.isUserInteractionEnabled = true
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        print("UIScreen().bounds.height \(UIScreen.main.bounds.size.height)")
        print("not safeAreaHeight \(view.safeAreaInsets.bottom)")
        print("not safeAreaHeight \(view.safeAreaInsets.top)")
        print("safeAreaHeight \(safeAreaHeight)")
        
        print("safeAreaWidth \(view.safeAreaLayoutGuide.layoutFrame.width)")
        print("bottomPadding \(bottomPadding)")
        print("sub \((safeAreaHeight + bottomPadding) - bottomHeight)")
        
        // safeAreaHeight -> 탑, 바텀 safeArea 뺀 height 값
        // bottomPadding -> 바텀 safeArea
        // bottomSheetViewTopConstraint -> autolayout topAnchor
        // bottomSheetViewTopConstraint : safeAreaHeight + bottomPadding
        // safeAreaHeight + bottomPadding -> top에서 부터 safeAreaHeight + bottomPadding 만큼 띄움, 즉 화면에 안보임
        // 여기서 - bottomHeight -> 해주면 bottomHeight 만큼의 바텀시트가 생김
        
        bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.5
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedBackView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
    
    @objc private func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
}
