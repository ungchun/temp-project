//
//  ButtonStyle.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/09.
//

import UIKit

// CommonButton + ButtonFilterClip + IconFilterButton
// font, color, inset 크기 등 세세한 value 들은 정해지면 수정

struct YPButtonStyle {
    let configu: UIButton.Configuration
    let selectedBackgroundColor: UIColor
    let nonSelectedBackgroundColor: UIColor
    let titleFont: UIFont
    let selectedBaseColor: UIColor
    let nonSelectedBaseColor: UIColor
    let inset: CGFloat
    let imagePadding: CGFloat
    let cornerRadius: CGFloat
    let imagePlacement: NSDirectionalRectEdge
    let isShadow: Bool
}

extension YPButtonStyle {
    
    static let largeType = YPButtonStyle (
        configu: .tinted(),
        // iconFilterClip 만약 선택했을 때 배경있는걸로 바꾸려면 filled로 바꾸고 색깔 바꾸기
        selectedBackgroundColor: .white,
        nonSelectedBackgroundColor: .white,
        titleFont: .systemFont(ofSize: 16),
        selectedBaseColor: .red,
        nonSelectedBaseColor: .gray,
        inset: 0,
        imagePadding: 0,
        cornerRadius: 10,
        imagePlacement: .all,
        isShadow: false
    )
    
    static let mediumBackgroundColorType = YPButtonStyle (
        configu: .filled(),
        selectedBackgroundColor: .red,
        nonSelectedBackgroundColor: .red,
        titleFont: .systemFont(ofSize: 16),
        selectedBaseColor: .white,
        nonSelectedBaseColor: .white,
        inset: 50,
        imagePadding: 0,
        cornerRadius: 10,
        imagePlacement: .all,
        isShadow: false
    )
    
    static let mediumOpacityBackgroundColorType = YPButtonStyle (
        configu: .tinted(),
        selectedBackgroundColor: UIColor.red.withAlphaComponent(0.3),
        nonSelectedBackgroundColor: UIColor.red.withAlphaComponent(0.3),
        titleFont: .systemFont(ofSize: 16),
        selectedBaseColor: .red,
        nonSelectedBaseColor: .red,
        inset: 50,
        imagePadding: 0,
        cornerRadius: 10,
        imagePlacement: .all,
        isShadow: false
    )
    
    static let mediumRadiusColorType = YPButtonStyle (
        configu: .tinted(),
        selectedBackgroundColor: .white,
        nonSelectedBackgroundColor: .white,
        titleFont: .systemFont(ofSize: 16),
        selectedBaseColor: .red,
        nonSelectedBaseColor: .red,
        inset: 50,
        imagePadding: 0,
        cornerRadius: 10,
        imagePlacement: .all,
        isShadow: false
    )

    static let smallType = YPButtonStyle (
        configu: .tinted(),
        selectedBackgroundColor: .white,
        nonSelectedBackgroundColor: .white,
        titleFont: .systemFont(ofSize: 16),
        selectedBaseColor: .red,
        nonSelectedBaseColor: .gray,
        inset: 40,
        imagePadding: 0,
        cornerRadius: 10,
        imagePlacement: .all,
        isShadow: false
    )
    
    static let xSmallType = YPButtonStyle (
        configu: .tinted(),
        selectedBackgroundColor: .white,
        nonSelectedBackgroundColor: .white,
        titleFont: .systemFont(ofSize: 16),
        selectedBaseColor: .red,
        nonSelectedBaseColor: .gray,
        inset: 25,
        imagePadding: 0,
        cornerRadius: 10,
        imagePlacement: .all,
        isShadow: false
    )
    
    static let xxSmallType = YPButtonStyle (
        configu: .tinted(),
        selectedBackgroundColor: .white,
        nonSelectedBackgroundColor: .white,
        titleFont: .systemFont(ofSize: 16),
        selectedBaseColor: .red,
        nonSelectedBaseColor: .gray,
        inset: 10,
        imagePadding: 0,
        cornerRadius: 10,
        imagePlacement: .all,
        isShadow: false
    )
    
    static let buttonFilterClipType = YPButtonStyle (
        configu: .tinted(),
        selectedBackgroundColor: .white,
        nonSelectedBackgroundColor: .white,
        titleFont: .systemFont(ofSize: 16),
        selectedBaseColor: .red,
        nonSelectedBaseColor: .gray,
        inset: 20,
        imagePadding: 5,
        cornerRadius: 30,
        imagePlacement: .trailing,
        isShadow: false
    )
    
    static let iconFilterClipType = YPButtonStyle (
        configu: .tinted(),
        // iconFilterClip 만약 선택했을 때 배경있는걸로 바꾸려면 filled로 바꾸고 색깔 바꾸기
        selectedBackgroundColor: .white,
        nonSelectedBackgroundColor: .white,
        titleFont: .systemFont(ofSize: 16),
        selectedBaseColor: .red,
        nonSelectedBaseColor: .gray,
        inset: 20,
        imagePadding: 5,
        cornerRadius: 30,
        imagePlacement: .leading,
        isShadow: true
    )
    
    static let roundType = YPButtonStyle (
        configu: .filled(),
        selectedBackgroundColor: .white,
        nonSelectedBackgroundColor: .black,
        titleFont: .systemFont(ofSize: 16),
        selectedBaseColor: .black,
        nonSelectedBaseColor: .white,
        inset: 20,
        imagePadding: 5,
        cornerRadius: 30,
        imagePlacement: .leading,
        isShadow: true
    )
}
