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
        
        bindTableView()
        addItem()
    }
    
    func bindTableView() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: ShoppingListTableViewCell.identifier, cellType: ShoppingListTableViewCell.self)) { (row, element, cell) in
                cell.configureCell(item: element)
                
                cell.checkButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        var item = owner.data[row]
                        item.completed.toggle()
                        owner.data[row] = item
                        owner.items.onNext(owner.data)
                    }
                    .disposed(by: cell.disposeBag)
                
                cell.starButton.rx.tap
                    .subscribe(with: self) { owner, _ in
                        var item = owner.data[row]
                        item.favorite.toggle()
                        owner.data[row] = item
                        owner.items.onNext(owner.data)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
    }
    
    func addItem() {
        addButton.rx.tap
            .withLatestFrom(searchBar.rx.text.orEmpty) { _, text in
                return text
            }
            .subscribe(with: self) { owner, text in
                if text.isEmpty {
                    owner.alertMessage(title: "추가할 품목을 적어주세요!")
                } else {
                    let item = ShoppingItem(title: text, completed: false, favorite: false)
                    owner.data.insert(item, at: 0)
                    owner.items.onNext(owner.data)
                    owner.searchBar.rx.text.onNext("")
                }
            }
            .disposed(by: disposeBag)
        
        //추가하고 나서는 검색창 텍스트 지워주기 -> 어떻게?
        //-> searchBar에 onNext로 보냈는데..맞는지는 모르겠음..
    }
    
    private func alertMessage(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okay)
        present(alert, animated: true)
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
