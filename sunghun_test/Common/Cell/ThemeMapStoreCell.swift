//
//  ThemeMapStoreCell.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/17.
//

import UIKit

class ThemeMapStoreCell: UICollectionViewCell {
    
    var onTap: ((String) -> Void)?
    private var title: String = ""
    
    private let backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let icon: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "circle.fill")
        return view
    }()
    
    private let name: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var iconNameStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
//        stackView.backgroundColor = .green
        stackView.spacing = 10
        return stackView
    }()
    
    private let address: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let time: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let updateBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("정보 수집요청", for: .normal)
        btn.setTitleColor(.black, for: .normal)
//        btn.backgroundColor = .red
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backView)
        
        iconNameStackView.addArrangedSubview(icon)
        iconNameStackView.addArrangedSubview(name)
        
        backView.addSubview(iconNameStackView)
        backView.addSubview(address)
        backView.addSubview(time)
        backView.addSubview(updateBtn)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            icon.widthAnchor.constraint(equalToConstant: 40),
            icon.heightAnchor.constraint(equalToConstant: 40),
            
            iconNameStackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
            iconNameStackView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20),
            
            address.topAnchor.constraint(equalTo: iconNameStackView.bottomAnchor, constant: 10),
            address.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20),
            
            time.topAnchor.constraint(equalTo: address.bottomAnchor, constant: 10),
            time.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20),
            
            updateBtn.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
            updateBtn.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        
    }
    
    func setLayout() {
        
    }
    
    func setupView() {
        
    }
    
    func bind(_ model: Any) {
        guard let model = model as? ThemeModel else { return }
        name.text = model.name
        address.text = model.address
        time.text = model.time
    }
}
