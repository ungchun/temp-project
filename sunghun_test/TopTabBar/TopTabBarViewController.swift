//
//  TopTabBarViewController.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/10.
//

import UIKit

class TopTabBarViewController: BaseBottomSheetViewController, CustomMenuBarDelegate {
    
    private let customMenuBar = CustomMenuBar()
    private let pageCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: 0, height: 0),
            collectionViewLayout: collectionViewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addView() {
        super.addView()
        [customMenuBar, pageCollectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupView() {
        customMenuBar.delegate = self
        
        pageCollectionView.delegate = self
        pageCollectionView.dataSource = self
        pageCollectionView.showsHorizontalScrollIndicator = false
        pageCollectionView.isPagingEnabled = true
        pageCollectionView.register(
            PageCell.self, forCellWithReuseIdentifier: PageCell.reusableIdentifier
        )
    }
    
    override func setLayout() {
        super.setLayout()
        
        NSLayoutConstraint.activate([
            customMenuBar.topAnchor.constraint(
                equalTo: bottomSheetView.topAnchor, constant: 30
            ),
            customMenuBar.widthAnchor.constraint(equalToConstant: 320),
            customMenuBar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            pageCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pageCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pageCollectionView.bottomAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.bottomAnchor
            ),
            pageCollectionView.topAnchor.constraint(equalTo: self.customMenuBar.bottomAnchor)
        ])
    }
    
    func customMenuBar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.pageCollectionView.scrollToItem(
            at: indexPath, at: .centeredHorizontally, animated: true
        )
    }
}

extension TopTabBarViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PageCell.reusableIdentifier, for: indexPath
        ) as! PageCell
        cell.label.text = "\(indexPath.row + 1)번째 뷰"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
    -> Int {
        return 4
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        customMenuBar.customTabBarCollectionView.selectItem(
            at: indexPath, animated: true, scrollPosition: []
        )
    }
}

extension TopTabBarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: pageCollectionView.frame.width, height: pageCollectionView.frame.height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
