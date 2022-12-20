//
//  ButtonStyle.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/09.
//

import UIKit

struct YPButtonStyle {
    let configu: UIButton.Configuration
    let titleFont: UIFont
    let selectedBackgroundColor: UIColor
    let nonSelectedBackgroundColor: UIColor
    let selectedBaseColor: UIColor
    let nonSelectedBaseColor: UIColor
    let inset: CGFloat
    var imagePlacement: NSDirectionalRectEdge = .all
    var imagePointSize: Double = 1
    let imagePadding: CGFloat
    let cornerRadius: CGFloat
    var isShadow: Bool = false
    var strokeWidth: Double = 1
}

// 컬러, 폰트사이즈 추후 값 수정
private let tempFontSize = 16.0
private let tempWhiteColor = UIColor.white
private let tempBlackColor = UIColor.black
private let tempRedColor = UIColor.red
private let tempGrayColor = UIColor.gray

extension YPButtonStyle {
    
    static let largeType = YPButtonStyle (
        configu: .tinted(),
        titleFont: .systemFont(ofSize: tempFontSize),
        selectedBackgroundColor: tempWhiteColor,
        nonSelectedBackgroundColor: tempWhiteColor,
        selectedBaseColor: tempRedColor,
        nonSelectedBaseColor: tempGrayColor,
        inset: 0,
        imagePadding: 0,
        cornerRadius: 10
    )
    
    static let mediumBackgroundColorType = YPButtonStyle (
        configu: .filled(),
        titleFont: .systemFont(ofSize: tempFontSize),
        selectedBackgroundColor: tempRedColor,
        nonSelectedBackgroundColor: tempRedColor,
        selectedBaseColor: tempWhiteColor,
        nonSelectedBaseColor: tempWhiteColor,
        inset: 50,
        imagePadding: 0,
        cornerRadius: 10
    )
    
    static let mediumOpacityBackgroundColorType = YPButtonStyle (
        configu: .tinted(),
        titleFont: .systemFont(ofSize: tempFontSize),
        selectedBackgroundColor: tempRedColor.withAlphaComponent(0.3),
        nonSelectedBackgroundColor: tempRedColor.withAlphaComponent(0.3),
        selectedBaseColor: tempRedColor,
        nonSelectedBaseColor: tempRedColor,
        inset: 50,
        imagePadding: 0,
        cornerRadius: 10
    )
    
    static let mediumRadiusColorType = YPButtonStyle (
        configu: .tinted(),
        titleFont: .systemFont(ofSize: tempFontSize),
        selectedBackgroundColor: tempWhiteColor,
        nonSelectedBackgroundColor: tempWhiteColor,
        selectedBaseColor: tempRedColor,
        nonSelectedBaseColor: tempRedColor,
        inset: 50,
        imagePadding: 0,
        cornerRadius: 10
    )
    
    static let smallType = YPButtonStyle (
        configu: .tinted(),
        titleFont: .systemFont(ofSize: tempFontSize),
        selectedBackgroundColor: tempWhiteColor,
        nonSelectedBackgroundColor: tempWhiteColor,
        selectedBaseColor: tempRedColor,
        nonSelectedBaseColor: tempGrayColor,
        inset: 40,
        imagePadding: 0,
        cornerRadius: 10
    )
    
    static let xSmallType = YPButtonStyle (
        configu: .tinted(),
        titleFont: .systemFont(ofSize: tempFontSize),
        selectedBackgroundColor: tempWhiteColor,
        nonSelectedBackgroundColor: tempWhiteColor,
        selectedBaseColor: tempRedColor,
        nonSelectedBaseColor: tempGrayColor,
        inset: 25,
        imagePadding: 0,
        cornerRadius: 10
    )
    
    static let xxSmallType = YPButtonStyle (
        configu: .tinted(),
        titleFont: .systemFont(ofSize: tempFontSize),
        selectedBackgroundColor: tempWhiteColor,
        nonSelectedBackgroundColor: tempWhiteColor,
        selectedBaseColor: tempRedColor,
        nonSelectedBaseColor: tempGrayColor,
        inset: 10,
        imagePadding: 0,
        cornerRadius: 10
    )
    
    static let buttonFilterClipType = YPButtonStyle (
        configu: .tinted(),
        titleFont: .systemFont(ofSize: tempFontSize),
        selectedBackgroundColor: tempWhiteColor,
        nonSelectedBackgroundColor: tempWhiteColor,
        selectedBaseColor: tempRedColor,
        nonSelectedBaseColor: tempGrayColor,
        inset: 20,
        imagePlacement: .trailing,
        imagePointSize: 10,
        imagePadding: 5,
        cornerRadius: 30
    )
    
    static let iconFilterClipType = YPButtonStyle (
        configu: .tinted(),
        titleFont: .systemFont(ofSize: tempFontSize),
        selectedBackgroundColor: tempWhiteColor,
        nonSelectedBackgroundColor: tempWhiteColor,
        selectedBaseColor: tempRedColor,
        nonSelectedBaseColor: tempGrayColor,
        inset: 20,
        imagePlacement: .leading,
        imagePointSize: 10,
        imagePadding: 5,
        cornerRadius: 30,
        isShadow: true
    )
    
    static let roundType = YPButtonStyle (
        configu: .filled(),
        titleFont: .systemFont(ofSize: tempFontSize),
        selectedBackgroundColor: tempWhiteColor,
        nonSelectedBackgroundColor: tempBlackColor,
        selectedBaseColor: tempBlackColor,
        nonSelectedBaseColor: tempWhiteColor,
        inset: 20,
        imagePlacement: .leading,
        imagePointSize: 10,
        imagePadding: 5,
        cornerRadius: 30,
        isShadow: true
    )
    
    static let iconButtonType = YPButtonStyle (
        configu: .tinted(),
        titleFont: .systemFont(ofSize: 20),
        selectedBackgroundColor: tempWhiteColor,
        nonSelectedBackgroundColor: tempWhiteColor,
        selectedBaseColor: tempRedColor,
        nonSelectedBaseColor: tempGrayColor,
        inset: 20,
        imagePlacement: .top,
        imagePointSize: 30,
        imagePadding: 10,
        cornerRadius: 0,
        strokeWidth: 0.0
    )
}
