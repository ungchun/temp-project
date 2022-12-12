//
//  CustomCell.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/10.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Tab"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet{
            print("Changed")
            self.label.textColor = isSelected ? .black : .lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
