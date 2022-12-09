//
//  CardDongneCell.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/07.
//

import UIKit

class CardDongneCell: UITableViewCell {
    
    // MARK: Properties
    //
    static let identifier = "CardDongneCell"
    private var dong: String = ""
    var onTap: ((String) -> Void)?
    var model: Any? {
        didSet {
            if let model = model { bind(model) }
        }
    }
    
    // MARK: Views
    //
    private let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    private let townIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "circle.fill")
        return imageView
    }()
    private var townTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private var townIntroduceTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    private let JjimBtn: UIButton = {
        let imageView = UIButton()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setImage(UIImage(systemName: "heart"), for: .normal)
        imageView.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        return imageView
    }()
    private let btnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    private let introduceBtn: YPButton = {
        let button = YPButton(style: .mediumBackgroundColorType)
        var attributeStringSelected = AttributedString("동네 소개")
        attributeStringSelected.font = .systemFont(ofSize: 16)
        button.setAttributedTitle(NSAttributedString(attributeStringSelected), for: .normal)
        return button
    }()
    private let mapBtn: YPButton = {
        let button = YPButton(style: .mediumRadiusColorType)
        var attributeStringSelected = AttributedString("동네 지도")
        attributeStringSelected.font = .systemFont(ofSize: 16)
        button.setAttributedTitle(NSAttributedString(attributeStringSelected), for: .normal)
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addView()
        setupView()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    //
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func addView() {
        [introduceBtn, mapBtn].forEach {
            btnStackView.addArrangedSubview($0)
        }
        [townIcon, townTitle, townIntroduceTitle, JjimBtn, btnStackView].forEach {
            backView.addSubview($0)
        }
        contentView.addSubview(backView)
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            townIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            townIcon.widthAnchor.constraint(equalToConstant: 40),
            townIcon.heightAnchor.constraint(equalToConstant: 40),
            townIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            townTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            townTitle.leadingAnchor.constraint(equalTo: townIcon.trailingAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            townIntroduceTitle.topAnchor.constraint(equalTo: townTitle.bottomAnchor, constant: 5),
            townIntroduceTitle.leadingAnchor.constraint(equalTo: townIcon.trailingAnchor, constant: 20)
        ])

        NSLayoutConstraint.activate([
            JjimBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            JjimBtn.widthAnchor.constraint(equalToConstant: 25),
            JjimBtn.heightAnchor.constraint(equalToConstant: 25),
            JjimBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            btnStackView.topAnchor.constraint(equalTo: townIntroduceTitle.bottomAnchor, constant: 20),
            btnStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            btnStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            btnStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.heightAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    func setupView() {
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = .zero
        backView.layer.shadowOpacity = 0.2 // 투명도
        backView.layer.shadowRadius = 10 // 너비
    }

    func bind(_ model: Any) {
        guard let model = model as? TownModel else { return }
        townTitle.text = model.dong
        townIntroduceTitle.text = model.introduce
        
        introduceBtn.addTarget(self, action: #selector(introduceBtnAction), for: .touchUpInside)
        mapBtn.addTarget(self, action: #selector(mapBtnAction), for: .touchUpInside)
        JjimBtn.addTarget(self, action: #selector(JjimBtnAction), for: .touchUpInside)

        dong = model.dong ?? ""
    }
    
    @objc func introduceBtnAction(sender: UIButton!) {
        onTap?("동네 소개 \(dong)")
    }
    
    @objc func mapBtnAction(sender: UIButton!) {
        onTap?("동네 지도 \(dong)")
    }
    
    @objc func JjimBtnAction(sender: UIButton!) {
        JjimBtn.isSelected.toggle()
    }
}
