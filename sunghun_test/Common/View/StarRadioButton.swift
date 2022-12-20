//
//  StarRadioButton.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/14.
//

import UIKit

final class StarRadioButton: UIView {
    
    enum StarType {
        case none
        case three
        case five
    }
    
    private var starType: StarType
    private var labelPadding: Double = 10.0
    
    private let backView: UIView = {
        let view = UIView()
        return view
    }()
    
    let radioButton: RadioButton = {
        let btn = RadioButton()
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    lazy var starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    
    private let star1: StarButton = {
        let btn = StarButton()
        btn.isUserInteractionEnabled = false
        return btn
    }()
    private let star2: StarButton = {
        let btn = StarButton()
        btn.isUserInteractionEnabled = false
        return btn
    }()
    private let star3: StarButton = {
        let btn = StarButton()
        btn.isUserInteractionEnabled = false
        return btn
    }()
    private let star4: StarButton = {
        let btn = StarButton()
        btn.isUserInteractionEnabled = false
        return btn
    }()
    private let star5: StarButton = {
        let btn = StarButton()
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    init(starType: StarType) {
        self.starType = starType
        super.init(frame: CGRect.zero)
        
        addView()
        setLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        
        starStackView.addArrangedSubview(star1)
        starStackView.addArrangedSubview(star2)
        starStackView.addArrangedSubview(star3)
        starStackView.addArrangedSubview(star4)
        starStackView.addArrangedSubview(star5)

        backView.addSubview(radioButton)
        backView.addSubview(starStackView)
        backView.addSubview(label)
        
        switch starType {
        case .none:
//            starStackView.isHidden = true
            [star1, star2, star3, star4, star5].forEach {
                $0.isHidden = true
            }
            labelPadding = 0
            label.text = "크게 중요하지 않아요."
        case .three:
            [star1, star2, star3].forEach {
                $0.isSelected = true
            }
            label.text = "중요해요."
        case .five:
            [star1, star2, star3, star4, star5].forEach {
                $0.isSelected = true
            }
            label.text = "매우 중요해요."
        }
        
        addSubview(backView)
    }

    private func setLayout() {
        
        radioButton.leftAnchor.constraint(equalTo: super.leftAnchor).isActive = true
        radioButton.centerYAnchor.constraint(equalTo: super.centerYAnchor).isActive = true
        
        starStackView.leftAnchor.constraint(equalTo: radioButton.rightAnchor, constant: 10).isActive = true
        starStackView.centerYAnchor.constraint(equalTo: super.centerYAnchor).isActive = true
        
        label.leftAnchor.constraint(equalTo: starStackView.rightAnchor, constant: labelPadding).isActive = true
        label.centerYAnchor.constraint(equalTo: super.centerYAnchor).isActive = true
    }
    
    private func configureUI() {
        
    }
}
