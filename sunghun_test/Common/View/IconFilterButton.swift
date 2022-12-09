//
//  IconFilterButton.swift
//  yapp_test_project
//
//  Created by 김성훈 on 2022/12/05.
//

import UIKit

// ButtonStyle로 통일

final class IconFilterButton: UIButton {
    
    let whiteColor = UIColor.white
    let redColor = UIColor.red
    let imagePadding = 5.0
    let fontSize = 16.0
    
    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                configuration?.background.strokeColor = .clear
                configuration?.baseForegroundColor = whiteColor
                configuration?.background.backgroundColor = redColor
            case false:
                configuration?.background.strokeColor = redColor
                configuration?.baseForegroundColor = redColor
                configuration?.background.backgroundColor = whiteColor
            }
        }
    }
    
    init() {
        super.init(frame: CGRectZero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 4, height: 4) // 범위
        layer.shadowOpacity = 0.2 // 투명도
        layer.shadowRadius = 5 // 너비
        
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 20, bottom: 10, trailing: 20
        )
        var text = AttributedString.init("")
        text.font = UIFont.systemFont(ofSize: fontSize)
        config.imagePadding = imagePadding
        config.imagePlacement = .leading
        config.background.cornerRadius = 30
        
        configuration = config
        
        isSelected = false
    }
}
