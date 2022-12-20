//
//  CollectionViewController.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/17.
//

import UIKit
import RxSwift
import RxCocoa

struct SearchCategoryModel {
    let kind: String?
}

struct ThemeModel {
    let category: String?
    let name: String?
    let address: String?
    let time: String?
}

class CollectionViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let themeModel: [ThemeModel] = [
        ThemeModel(category: "food", name: "혼밥잘하는집 신림점", address: "서울시 관악구 호암로26", time: "10:00-21:00"),
        ThemeModel(category: "food", name: "혼밥잘하는집 신림점", address: "서울시 관악구 호암로26", time: "10:00-21:00"),
        ThemeModel(category: "food", name: "혼밥잘하는집 신림점", address: "서울시 관악구 호암로26", time: "10:00-21:00"),
        ThemeModel(category: "food", name: "혼밥잘하는집 신림점", address: "서울시 관악구 호암로26", time: "10:00-21:00")
    ]
    
    private let themeCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 80)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ThemeMapStoreCell.self, forCellWithReuseIdentifier: "ThemeMapStoreCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(themeCollectionView)
        themeCollectionView.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            themeCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            themeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            themeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            themeCollectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        Observable.just(themeModel)
            .bind(to: themeCollectionView.rx.items(cellIdentifier: "ThemeMapStoreCell", cellType: ThemeMapStoreCell.self)) { index, model, cell in
                cell.bind(model)
            }
            .disposed(by: disposeBag)
        
        themeCollectionView.rx.modelSelected(ThemeModel.self)
            .subscribe { model in
                print("tap \(model.map {$0.name})")
            }
            .disposed(by: disposeBag)
        
        themeCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 120, height: 160)
    }
}
