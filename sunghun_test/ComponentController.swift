//
//  ViewController.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/06.
//

import UIKit

class ComponentController: UIViewController {
    
    // 이름은 현재 피그마 컴포넌트 이름으로 일단 만들었습니다!
    
    private let largeButton: YPButton = {
        let btn = YPButton(style: .largeType)
        return btn
    }()
    private let mediumBackgroundColorButton: YPButton = {
        let btn = YPButton(style: .mediumBackgroundColorType)
        return btn
    }()
    private let mediumOpacityBackgroundColorButton: YPButton = {
        let btn = YPButton(style: .mediumOpacityBackgroundColorType)
        return btn
    }()
    private let mediumRadiusColorButton: YPButton = {
        let btn = YPButton(style: .mediumRadiusColorType)
        return btn
    }()
    private let smallButton: YPButton = {
        let btn = YPButton(style: .smallType)
        return btn
    }()
    private let xSmallButton: YPButton = {
        let btn = YPButton(style: .xSmallType)
        return btn
    }()
    private let xxSmallButton: YPButton = {
        let btn = YPButton(style: .xxSmallType)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(largeButton)
        view.addSubview(mediumBackgroundColorButton)
        view.addSubview(mediumOpacityBackgroundColorButton)
        view.addSubview(mediumRadiusColorButton)
        view.addSubview(smallButton)
        view.addSubview(xSmallButton)
        view.addSubview(xxSmallButton)
        
        largeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        largeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        largeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        mediumBackgroundColorButton.topAnchor.constraint(equalTo: largeButton.bottomAnchor, constant: 50).isActive = true
        mediumBackgroundColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mediumOpacityBackgroundColorButton.topAnchor.constraint(equalTo: mediumBackgroundColorButton.bottomAnchor, constant: 50).isActive = true
        mediumOpacityBackgroundColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        mediumRadiusColorButton.topAnchor.constraint(equalTo: mediumOpacityBackgroundColorButton.bottomAnchor, constant: 50).isActive = true
        mediumRadiusColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        smallButton.topAnchor.constraint(equalTo: mediumRadiusColorButton.bottomAnchor, constant: 50).isActive = true
        smallButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        xSmallButton.topAnchor.constraint(equalTo: smallButton.bottomAnchor, constant: 50).isActive = true
        xSmallButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        xxSmallButton.topAnchor.constraint(equalTo: xSmallButton.bottomAnchor, constant: 50).isActive = true
        xxSmallButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        largeButton.setTitle("적용하기", for: .normal)
        largeButton.addTarget(self, action: #selector(commonLargeButtonAction), for: .touchUpInside)
        
        mediumBackgroundColorButton.setTitle("동네지도", for: .normal)
        mediumOpacityBackgroundColorButton.setTitle("동네지도", for: .normal)
        mediumRadiusColorButton.setTitle("동네지도", for: .normal)
        
        smallButton.setTitle("강남구", for: .normal)
        smallButton.addTarget(self, action: #selector(commonSmallButtonAction), for: .touchUpInside)
        
        xSmallButton.setTitle("1호선", for: .normal)
        xSmallButton.addTarget(self, action: #selector(commonXSmallButtonAction), for: .touchUpInside)
        
        xxSmallButton.setTitle("편의점", for: .normal)
        xxSmallButton.addTarget(self, action: #selector(commonXXSmallButtonAction), for: .touchUpInside)
    }
    
    @objc func commonLargeButtonAction() {
        largeButton.isSelected.toggle()
    }
    
    @objc func commonSmallButtonAction() {
        smallButton.isSelected.toggle()
    }
    
    @objc func commonXSmallButtonAction() {
        xSmallButton.isSelected.toggle()
    }
    
    @objc func commonXXSmallButtonAction() {
        xxSmallButton.isSelected.toggle()
    }
}
