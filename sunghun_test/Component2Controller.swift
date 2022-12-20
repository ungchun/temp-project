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
        btn.setTitle(normalTitle: "편의시설", selectedTitle: "편의시설")
        btn.setImage(normalImageName: "cart", selectedImageName: "cart")
        return btn
    }()
    private let btnFilterClip: YPButton = {
        let btn = YPButton(style: .buttonFilterClipType)
        btn.setTitle(normalTitle: "인프라")
        btn.setImage(normalImageName: "chevron.down")
        return btn
    }()
    private let checkButton: CheckButton = {
        let btn = CheckButton()
        return btn
    }()
    private let roundButton: YPButton = {
        let btn = YPButton(style: .roundType)
        btn.setTitle(normalTitle: "동네 소개로 이동", selectedTitle: "동네 지도로 이동")
        btn.setImage(normalImageName: "message", selectedImageName: "map")
        return btn
    }()
    private let radioButton: RadioButton = {
        let btn = RadioButton()
        return btn
    }()
    private let iconButton: YPButton = {
        let btn = YPButton(style: .iconButtonType)
        btn.setTitle(normalTitle: "문화", selectedTitle: "문화")
        btn.setImage(normalImageName: "book.closed", selectedImageName: "book.closed")
//        btn.backgroundColor = .red
        return btn
    }()
    
    lazy var starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    lazy var noneStarRadioButton: StarRadioButton = {
        let star = StarRadioButton(starType: .none)
        star.translatesAutoresizingMaskIntoConstraints = false
        star.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starNoneButtonAction))
        star.addGestureRecognizer(tapGesture)
        
        return star
    }()
    lazy var threeStarRadioButton: StarRadioButton = {
        let star = StarRadioButton(starType: .three)
        star.translatesAutoresizingMaskIntoConstraints = false
        star.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starThreeButtonAction))
        star.addGestureRecognizer(tapGesture)
        
        return star
    }()
    lazy var fiveStarRadioButton: StarRadioButton = {
        let star = StarRadioButton(starType: .five)
        star.translatesAutoresizingMaskIntoConstraints = false
        star.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(starFiveButtonAction))
        star.addGestureRecognizer(tapGesture)
        
        return star
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(iconFilterBtn)
        view.addSubview(btnFilterClip)
        view.addSubview(checkButton)
        view.addSubview(roundButton)
        view.addSubview(radioButton)
        view.addSubview(iconButton)
        
        
        starStackView.addArrangedSubview(noneStarRadioButton)
        starStackView.addArrangedSubview(threeStarRadioButton)
        starStackView.addArrangedSubview(fiveStarRadioButton)
        
        view.addSubview(starStackView)
        
        
        iconFilterBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        iconFilterBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        btnFilterClip.topAnchor.constraint(equalTo: iconFilterBtn.bottomAnchor, constant: 50).isActive = true
        btnFilterClip.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        checkButton.topAnchor.constraint(equalTo: btnFilterClip.bottomAnchor, constant: 50).isActive = true
        checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        roundButton.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 50).isActive = true
        roundButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        radioButton.topAnchor.constraint(equalTo: roundButton.bottomAnchor, constant: 50).isActive = true
        radioButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        iconButton.topAnchor.constraint(equalTo: radioButton.bottomAnchor, constant: 50).isActive = true
        iconButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        starStackView.topAnchor.constraint(equalTo: iconButton.bottomAnchor, constant: 10).isActive = true
        starStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 40).isActive = true
        starStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        starStackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        //                starStackView.backgroundColor = .red
        
        iconFilterBtn.addTarget(self, action: #selector(iconFilterBtnAction), for: .touchUpInside)
        
        btnFilterClip.addTarget(self, action: #selector(btnFilterClipAction), for: .touchUpInside)
        
        checkButton.addTarget(self, action: #selector(checkButtonAction), for: .touchUpInside)
        
        roundButton.addTarget(self, action: #selector(roundButtonAction), for: .touchUpInside)
        
        radioButton.addTarget(self, action: #selector(radioButtonAction), for: .touchUpInside)
        
        iconButton.addTarget(self, action: #selector(iconButtonAction), for: .touchUpInside)
        
    }
    
    @objc func iconFilterBtnAction() {
        iconFilterBtn.isSelected.toggle()
    }
    
    @objc func btnFilterClipAction() {
        //        let bottomSheetVC = TopTabBarViewController()
        //        bottomSheetVC.modalPresentationStyle = .overFullScreen
        //        present(bottomSheetVC, animated: false, completion: nil)
        
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        present(bottomSheetVC, animated: false, completion: nil)
    }
    
    @objc func checkButtonAction() {
        checkButton.isSelected.toggle()
    }
    
    @objc func roundButtonAction() {
        roundButton.isSelected.toggle()
    }
    
    @objc func radioButtonAction() {
        radioButton.isSelected.toggle()
    }
    
    @objc func iconButtonAction() {
        iconButton.isSelected.toggle()
    }
    
    @objc func starNoneButtonAction(sender : UITapGestureRecognizer){
        noneStarRadioButton.radioButton.isSelected = true
        threeStarRadioButton.radioButton.isSelected = false
        fiveStarRadioButton.radioButton.isSelected = false
    }
    
    @objc func starThreeButtonAction(sender : UITapGestureRecognizer){
        noneStarRadioButton.radioButton.isSelected = false
        threeStarRadioButton.radioButton.isSelected = true
        fiveStarRadioButton.radioButton.isSelected = false
    }
    
    @objc func starFiveButtonAction(sender : UITapGestureRecognizer){
        noneStarRadioButton.radioButton.isSelected = false
        threeStarRadioButton.radioButton.isSelected = false
        fiveStarRadioButton.radioButton.isSelected = true
    }
}

// example BottomSheet
//
final class BottomSheetViewController: BaseBottomSheetViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bottomSheetView.backgroundColor = .red
        //        bottomSheetView.addSubview()
    }
}
