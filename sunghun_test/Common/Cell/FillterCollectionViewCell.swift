//
//  FillterCollectionViewCell.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/18.
//

import UIKit
import RxSwift

class FillterCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    //
    var onTap: ((String) -> Void)?
    private var kind: String = ""
    private let cellDisposeBag = DisposeBag()
    
    // MARK: Views
    //
    private var searchCategoryBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .white
        let image = UIImage(systemName: "chevron.down")
//        let newImage = image!.resize(withSize: CGSize(width: 10, height: 10), contentMode: .contentAspectFit)
        configuration.image = image
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 10
        configuration.background.strokeColor = UIColor.gray.withAlphaComponent(0.3)
        configuration.background.strokeWidth = 1
        configuration.background.cornerRadius = 30
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 12, leading: 10, bottom: 12, trailing: 10
        )
        btn.configuration = configuration
        return btn
    }()
    
    // MARK: Life Cycle
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(searchCategoryBtn)
        
        searchCategoryBtn.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        searchCategoryBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        searchCategoryBtn.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        searchCategoryBtn.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    //
//    @objc func buttonAction(sender: UIButton!) {
//        onTap?(kind)
//    }
//
    func bind(_ model: Any) {
        guard let model = model as? SearchCategoryModel else { return }
        kind = model.kind ?? ""
        searchCategoryBtn.setTitle(model.kind, for: .normal)
//        searchCategoryBtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}

// UIImage image 크기 설정해주는 extension
// UIGraphicsBeginImageContextWithOptions -> 리사이징 하자있음
// WWDC에서 리사이징 < 다운샘플링 오피셜 -> 킹피셔에 다운샘플링 지원해줌
extension UIImage {
    enum ContentMode {
        case contentFill
        case contentAspectFill
        case contentAspectFit
    }
    
    func resize(withSize size: CGSize, contentMode: ContentMode = .contentAspectFill) -> UIImage? {
        let aspectWidth = size.width / self.size.width
        let aspectHeight = size.height / self.size.height
        
        switch contentMode {
        case .contentFill:
            return resize(withSize: size)
        case .contentAspectFit:
            let aspectRatio = min(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        case .contentAspectFill:
            let aspectRatio = max(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        }
    }
    
    private func resize(withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
