//
//  Button.swift
//  yapp_test_project
//
//  Created by 김성훈 on 2022/12/06.
//

import UIKit

// ButtonStyle로 통일

final class CommonButton: UIButton {
    
    let fontSize = 16.0
    let redColor = UIColor.red
    let grayColor = UIColor.gray
    
    private var sizeType: SizeType?
    private var mediumSizeConfigeType: MediumSizeConfigeType?
    
    enum SizeType {
        case Large
        case Medium
        case Small
        case XSmall
        case XXSmall
    }
    
    enum MediumSizeConfigeType {
        case none
        case filled
        case tinted
    }
    
    override var isSelected: Bool {
        didSet {
            if self.sizeType != .Medium {
                switch isSelected {
                case true:
                    configuration?.background.strokeColor = redColor
                    configuration?.baseForegroundColor = redColor
                case false:
                    configuration?.background.strokeColor = grayColor
                    configuration?.baseForegroundColor = grayColor
                }
            }
        }
    }
    
    init(sizeType: SizeType, mediumSizeConfigeType: MediumSizeConfigeType = .none, frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.sizeType = sizeType
        if sizeType == .Medium { self.mediumSizeConfigeType = mediumSizeConfigeType }
        configureUI(sizeType: sizeType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(sizeType: SizeType) {
        var config = UIButton.Configuration.tinted()
        config.baseBackgroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 15, leading: 0, bottom: 15, trailing: 0
        )
        var text = AttributedString.init("")
        text.font = UIFont.systemFont(ofSize: fontSize)
        config.background.cornerRadius = 10
        
        switch sizeType {
        case .Large:
            config.contentInsets = NSDirectionalEdgeInsets(
                top: 15, leading: 0, bottom: 15, trailing: 0
            )
        case .Medium:
            if mediumSizeConfigeType == .filled {
                config = UIButton.Configuration.filled()
                config.baseBackgroundColor = redColor
            } else {
                config.background.strokeColor = redColor
                config.baseForegroundColor = redColor
            }
            break
        case .Small:
            config.contentInsets = NSDirectionalEdgeInsets(
                top: 15, leading: 40, bottom: 15, trailing: 40
            )
        case .XSmall:
            config.contentInsets = NSDirectionalEdgeInsets(
                top: 15, leading: 25, bottom: 15, trailing: 25
            )
        case .XXSmall:
            config.contentInsets = NSDirectionalEdgeInsets(
                top: 15, leading: 10, bottom: 15, trailing: 10
            )
        }
        configuration = config
        
        isSelected = false
    }
}
