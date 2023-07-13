//
//  CellForTable.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 13.07.2023.
//

import UIKit

class CellForTable: UITableViewCell {
    
    //MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let symbolLable: UILabel = {
        let label = UILabel()
        label.text = "\u{25CB}"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let taskLable: UILabel = {
        let label = UILabel()
        label.text = "Ufufuffss"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupSubviews() {
        contentView.addSubview(symbolLable)
        contentView.addSubview(taskLable)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            symbolLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            symbolLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        
            taskLable.leadingAnchor.constraint(equalTo: symbolLable.trailingAnchor, constant: 20),
            taskLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            taskLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            taskLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        symbolLable.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func setup(model: Task) {
        taskLable.text = model.title
        if model.status == .completed {
            taskLable.textColor = .lightGray
            symbolLable.textColor = .lightGray
            symbolLable.text = "\u{25C9}"
        } else {
            taskLable.textColor = .black
            symbolLable.textColor = .black
            symbolLable.text = "\u{25CB}"
        }
    }
}
