//
//  BaseViewController.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/07.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setupView()
        setLayout()
        
        bindViewModel()
    }
    
    func addView() {}
    func setupView() {}
    func setLayout() {}
    
    func bindViewModel() {}
}
