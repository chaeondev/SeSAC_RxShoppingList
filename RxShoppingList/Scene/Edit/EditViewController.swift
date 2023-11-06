//
//  EditViewController.swift
//  RxShoppingList
//
//  Created by Chaewon on 2023/11/07.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class EditViewController: UIViewController {
    
    let textField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        return view
    }()
    
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
        setNavigationBar()
    }
    
    func configure() {
        view.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    func setNavigationBar() {
        title = "품목 수정하기"
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.setRightBarButton(saveButton, animated: true)
        
    }
    
    @objc private func saveButtonClicked() {
        guard let text = textField.text else { return }
        completionHandler?(text)
        navigationController?.popViewController(animated: true)
    }
    
}
