//
//  ViewController.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/06.
//

import UIKit

class Component2Controller: UIViewController {
    
    // 이름은 현재 피그마 컴포넌트 이름으로 일단 만들었습니다!
    
    private let iconFilterBtn: YPButton = {
        let btn = YPButton(style: .iconFilterClipType)
        return btn
    }()
    private let btnFilterClip: YPButton = {
        let btn = YPButton(style: .buttonFilterClipType)
        return btn
    }()
    private let radioButton: RadioButton = {
        let btn = RadioButton()
        return btn
    }()
    private let roundButton: YPButton = {
        let btn = YPButton(style: .roundType)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(iconFilterBtn)
        view.addSubview(btnFilterClip)
        view.addSubview(radioButton)
        view.addSubview(roundButton)
        
        iconFilterBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        iconFilterBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        btnFilterClip.topAnchor.constraint(equalTo: iconFilterBtn.bottomAnchor, constant: 50).isActive = true
        btnFilterClip.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        radioButton.topAnchor.constraint(equalTo: btnFilterClip.bottomAnchor, constant: 50).isActive = true
        radioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        roundButton.topAnchor.constraint(equalTo: radioButton.bottomAnchor, constant: 50).isActive = true
        roundButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        iconFilterBtn.setTitle("편의시설", for: .normal)
        iconFilterBtn.setImage(UIImage(systemName: "cart"), for: . normal)
        iconFilterBtn.addTarget(self, action: #selector(iconFilterBtnAction), for: .touchUpInside)
        
        btnFilterClip.setTitle("인프라", for: .normal)
        btnFilterClip.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btnFilterClip.addTarget(self, action: #selector(btnFilterClipAction), for: .touchUpInside)
        
        radioButton.addTarget(self, action: #selector(radioButtonAction), for: .touchUpInside)
        
        var attributeStringNormal = AttributedString("동네 소개로 이동")
        attributeStringNormal.font = .systemFont(ofSize: 16)
        roundButton.setAttributedTitle(NSAttributedString(attributeStringNormal), for: .normal)
        roundButton.setImage(UIImage(systemName: "message"), for: .normal)
        
        var attributeStringSelected = AttributedString("동네 지도로 이동")
        attributeStringSelected.font = .systemFont(ofSize: 16)
        roundButton.setAttributedTitle(NSAttributedString(attributeStringSelected), for: .selected)
        roundButton.setImage(UIImage(systemName: "map"), for: .selected)
        roundButton.addTarget(self, action: #selector(roundButtonAction), for: .touchUpInside)
    }
    
    @objc func iconFilterBtnAction() {
        iconFilterBtn.isSelected.toggle()
    }
    
    @objc func btnFilterClipAction() {
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        present(bottomSheetVC, animated: false, completion: nil)
    }
    
    @objc func radioButtonAction() {
        radioButton.isSelected.toggle()
    }
    
    @objc func roundButtonAction() {
        roundButton.isSelected.toggle()
    }
}

// example BottomSheet
//
final class BottomSheetViewController: BaseBottomSheetViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bottomSheetView.backgroundColor = .red
        
        // bottomSheetView.addSubview(AnyView)
    }
}
