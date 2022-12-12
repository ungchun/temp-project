//
//  CustomMenuBar.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/10.
//

import UIKit

// reusableIdentifier extension
extension NSObject {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

protocol CustomMenuBarDelegate: AnyObject {
    func customMenuBar(scrollTo index: Int)
}

class CustomMenuBar: UIView {
    
    weak var delegate: CustomMenuBarDelegate?
    
    var indicatorViewLeadingConstraint:NSLayoutConstraint!
    var indicatorViewWidthConstraint: NSLayoutConstraint!
    
    var customTabBarCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                              collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addView()
        setLayout()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        self.addSubview(customTabBarCollectionView)
    }
    
    func setupView() {
        customTabBarCollectionView.delegate = self
        customTabBarCollectionView.dataSource = self
        customTabBarCollectionView.register(
            CustomCell.self, forCellWithReuseIdentifier: CustomCell.reusableIdentifier
        )
        
        let indexPath = IndexPath(item: 0, section: 0)
        customTabBarCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            customTabBarCollectionView.widthAnchor.constraint(equalToConstant: 320),
            customTabBarCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            customTabBarCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension CustomMenuBar: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCell.reusableIdentifier, for: indexPath
        ) as! CustomCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        return CGSize(width: self.frame.width / 4 , height: 55)
        return CGSize(width: 80 , height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.customMenuBar(scrollTo: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCell else {return}
        cell.label.textColor = .lightGray
    }
}

extension CustomMenuBar: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
