//
//  ButtonFilterChip.swift
//  yapp_test_project
//
//  Created by 김성훈 on 2022/12/06.
//

import UIKit

// ButtonStyle로 통일

final class ButtonFilterClip: UIButton {
    
    let redColor = UIColor.red
    let grayColor = UIColor.gray
    let imagePadding = 10.0
    let fontSize = 16.0
    
    override var isSelected: Bool {
        didSet {
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
    
    init() {
        super.init(frame: CGRectZero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        var config = UIButton.Configuration.tinted()
        config.baseBackgroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 10, bottom: 10, trailing: 10
        )
        var text = AttributedString.init("")
        text.font = UIFont.systemFont(ofSize: fontSize)
        config.imagePlacement = .trailing
        config.imagePadding = imagePadding
        config.background.strokeColor = UIColor.gray.withAlphaComponent(0.3)
        config.background.strokeWidth = 1
        config.background.cornerRadius = 30
        
        configuration = config
        
        isSelected = false
    }
}
