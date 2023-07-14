//
//  CellForTable.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 13.07.2023.
//

import UIKit

/// Ячейка для таблицы
class CellForTable: UITableViewCell {
    
    /// Константы используемые в данном классе
    private enum Constants {
        static let symbolLableСonstraint: CGFloat = 15
        static let taskLableLeadingСonstraint: CGFloat = 20
        static let constantConstraint: CGFloat = 10
        static let completed = "\u{25C9}"
        static let planned = "\u{25CB}"
    }
    
    //MARK: - Properties
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let symbolLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let taskLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
        selectionStyle = .none
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
            symbolLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.symbolLableСonstraint),
            symbolLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            taskLable.leadingAnchor.constraint(equalTo: symbolLable.trailingAnchor, constant: Constants.taskLableLeadingСonstraint),
            taskLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.constantConstraint),
            taskLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.constantConstraint),
            taskLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.constantConstraint)
        ])
        symbolLable.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func setup(model: Task) {
        taskLable.text = model.title
        if model.status == .completed {
            taskLable.textColor = .lightGray
            symbolLable.textColor = .lightGray
            symbolLable.text = Constants.completed
        } else {
            taskLable.textColor = .black
            symbolLable.textColor = .black
            symbolLable.text = Constants.planned
        }
    }
}
