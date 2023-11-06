//
//  ShoppingListViewController.swift
//  RxShoppingList
//
//  Created by Chaewon on 2023/11/06.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ShoppingListViewController: UIViewController {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "무엇을 구매하실 건가요?"
        view.searchBarStyle = .minimal
        view.searchTextField.borderStyle = .none
        view.backgroundColor = .systemGray6
        view.searchTextField.backgroundColor = .systemGray6
        view.tintColor = .systemGray6
        view.setImage(UIImage(), for: .search, state: .normal)
        view.layer.cornerRadius = 10
        return view
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.identifier)
        view.rowHeight = 55
        view.separatorStyle = .singleLine
        return view
    }()
    
    var data: [ShoppingItem] = [
        ShoppingItem(title: "그립톡 구매하기", completed: true, favorite: true),
        ShoppingItem(title: "사이다 구매", completed: false, favorite: false),
        ShoppingItem(title: "아이패드 최저가 알아보기", completed: false, favorite: true),
        ShoppingItem(title: "양말", completed: false, favorite: false)
    ]
    
    lazy var items = BehaviorSubject(value: data)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setConstraints()
        
        bind()
    }
    
    func bind() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: ShoppingListTableViewCell.identifier, cellType: ShoppingListTableViewCell.self)) { (row, element, cell) in
                cell.configureCell(item: element)
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.addSubview(searchBar)
        searchBar.addSubview(addButton)
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(70)
        }
        
        addButton.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(15)
            make.width.equalTo(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
    }
    
}

//
//#Preview {
//    ShoppingListViewController()
//}
