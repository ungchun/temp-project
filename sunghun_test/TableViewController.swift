//
//  TableViewController.swift
//  sunghun_test
//
//  Created by 김성훈 on 2022/12/07.
//

import UIKit
import RxCocoa
import RxSwift

struct TownModel {
    let dong: String?
    let introduce: String?
}

class TableViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let townModel: [TownModel] = [
        TownModel(dong: "신림동", introduce: "자취생들이 많이 사는 동네"),
        TownModel(dong: "신림동", introduce: "자취생들이 많이 사는 동네"),
        TownModel(dong: "신림동", introduce: "자취생들이 많이 사는 동네"),
        TownModel(dong: "신림동", introduce: "자취생들이 많이 사는 동네"),
        TownModel(dong: "신림동", introduce: "자취생들이 많이 사는 동네"),
        TownModel(dong: "신림동", introduce: "자취생들이 많이 사는 동네"),
    ]
    
    private let townTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CardDongneCell.self, forCellReuseIdentifier: CardDongneCell.identifier)
        
        // 최초 기본값, 처음에는 이걸로 지정되었다가 autolayout을 통해 리사이징
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(townTableView)
        
        NSLayoutConstraint.activate([
            townTableView.topAnchor.constraint(equalTo: view.topAnchor),
            townTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            townTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            townTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        // cell height 값 지정하기위한 delegate set, rx
        townTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        Observable.just(townModel)
            .bind(to: townTableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: CardDongneCell.identifier, for: IndexPath(row: row, section: 0)) as! CardDongneCell
                cell.bind(item)
                cell.onTap = { dong in
                    print("dong \(dong)")
                }
                cell.selectionStyle = .none
                return cell
            }
            .disposed(by: disposeBag)
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
