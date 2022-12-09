//
//  YPButton.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/09.
//

import UIKit

final class YPButton: UIButton {
    
    var style: YPButtonStyle
    
    init(frame: CGRect = .zero, style: YPButtonStyle) {
        self.style = style
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configureUI()
    }
    
    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                configuration?.background.strokeColor = style.selectedBaseColor
                configuration?.baseForegroundColor = style.selectedBaseColor
                configuration?.baseBackgroundColor = style.selectedBackgroundColor
            case false:
                configuration?.background.strokeColor = style.nonSelectedBaseColor
                configuration?.baseForegroundColor = style.nonSelectedBaseColor
                configuration?.baseBackgroundColor = style.nonSelectedBackgroundColor
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        if style.isShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = .init(width: 4, height: 4) // 범위
            layer.shadowOpacity = 0.2 // 투명도
            layer.shadowRadius = 5 // 너비
        }
        
        var config = style.configu
        config.baseBackgroundColor = style.selectedBackgroundColor
        var text = AttributedString.init("")
        text.font = style.titleFont
        config.attributedTitle = text
        config.background.cornerRadius = style.cornerRadius
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 15, leading: style.inset, bottom: 15, trailing: style.inset
        )
        config.background.strokeColor = style.nonSelectedBaseColor
        config.baseForegroundColor = style.nonSelectedBaseColor
        config.imagePlacement = style.imagePlacement
        config.imagePadding = style.imagePadding
        
        configuration = config
        
        isSelected = false
    }
}
