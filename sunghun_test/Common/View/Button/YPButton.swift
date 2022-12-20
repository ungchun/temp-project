//
//  YPButton.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/09.
//

import UIKit

final class YPButton: UIButton {
    
    private let style: YPButtonStyle
    
    init(frame: CGRect = .zero, style: YPButtonStyle) {
        self.style = style
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    func setTitle(normalTitle: String = .init(), selectedTitle: String = .init()) {
        setTitle(normalTitle, for: .normal)
        setTitle(selectedTitle, for: .selected)
    }
    
    func setImage(normalImageName: String = .init(), selectedImageName: String = .init()) {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: style.imagePointSize, weight: .light)
        let normalImage = UIImage(systemName: normalImageName, withConfiguration: imageConfig)
        let selectedImage = UIImage(systemName: selectedImageName, withConfiguration: imageConfig)
        
        setImage(normalImage, for: .normal)
        setImage(selectedImage, for: .selected)
    }
    
    private func configureUI() {
        // 추후 값 수정
        if style.isShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = .init(width: 4, height: 4) // 범위
            layer.shadowOpacity = 0.2 // 투명도
            layer.shadowRadius = 5 // 너비
        }
        
        var config = style.configu
        config.baseBackgroundColor = style.selectedBackgroundColor

        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ [weak self] incoming in
            var outgoing = incoming
            outgoing.font = self?.style.titleFont
            return outgoing
        })

        config.background.cornerRadius = style.cornerRadius
        
        // 추후 top, bottom 값 수정
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 15, leading: style.inset, bottom: 15, trailing: style.inset
        )
    
        config.background.strokeColor = style.nonSelectedBaseColor
        config.background.strokeWidth = style.strokeWidth
        config.baseForegroundColor = style.nonSelectedBaseColor
        config.imagePlacement = style.imagePlacement
        config.imagePadding = style.imagePadding
        
        configuration = config
        
        isSelected = false
    }
}
