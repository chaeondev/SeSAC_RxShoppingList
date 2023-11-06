//
//  ShoppingListTableViewCell.swift
//  RxShoppingList
//
//  Created by Chaewon on 2023/11/06.
//

import UIKit
import SnapKit

class ShoppingListTableViewCell: UITableViewCell {
    
    static let identifier = "ShoppingListTableViewCell"
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 10
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(item: ShoppingItem) {
        self.contentLabel.text = item.title
        
        let checkImage = item.completed ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        checkButton.setImage(checkImage, for: .normal)
        
        let starImage = item.favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        starButton.setImage(starImage, for: .normal)
    }
    
    private func configure() {
        contentView.addSubview(checkButton)
        contentView.addSubview(contentLabel)
        contentView.addSubview(starButton)
        
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(30)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(checkButton.snp.trailing).offset(16)
            make.trailing.equalTo(starButton.snp.leading).offset(-16)
        }
        
        starButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(30)
        }
        
        
    }
    
}
