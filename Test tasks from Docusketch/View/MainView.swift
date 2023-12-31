//
//  MainView.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 13.07.2023.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    /// Удалить задачу
    func deleteTask(index: Int)
    /// Пометить задачу как выполненая
    func taskCompleted(index: Int)
    ///  Пометить задачу как не выполненая
    func taskNotImplemented(index: Int)
}

/// view для main сцены
class MainView: UIView {
    
    /// Константы используемые в данном классе
    private enum Constants {
        static let backgroundImage = "012"
        static let cornerRadius: CGFloat = 10
        static let alpha: CGFloat = 0.8
        static let constraintConstant: CGFloat = 15
    }
    
    //MARK: - Proprties
    
    weak var delegate: MainViewDelegate?
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: Constants.backgroundImage)
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var table: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = Constants.cornerRadius
        table.alpha = Constants.alpha
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var modelTask: [Task] = []
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
        setupConstraints()
        setupTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupElements() {
        addSubview(backgroundImage)
        addSubview(table)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            table.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.constraintConstant),
            table.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.constraintConstant),
            table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTable() {
        table.delegate = self
        table.dataSource = self
        table.register(CellForTable.self, forCellReuseIdentifier: CellForTable.identifier)
    }
}

//MARK: - Extension - UITableViewDataSource

extension MainView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        modelTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellForTable.identifier, for: indexPath) as? CellForTable else {
            return UITableViewCell()
        }
        cell.setup(model: modelTask[indexPath.row])
        return cell
    }
    func setupModelForCell(model: [Task]) {
        modelTask = model
    }
}

//MARK: - Extension - UITableViewDelegate

extension MainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.taskCompleted(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, _ in
            self?.delegate?.deleteTask(index: indexPath.row)
        }
        actionDelete.image = UIImage(systemName: "trash")
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionSwipeInstance = UIContextualAction(style: .normal, title: "Not implemented") { [weak self] _,_,_ in
            self?.delegate?.taskNotImplemented(index: indexPath.row)
        }
        let actions = UISwipeActionsConfiguration(actions: [actionSwipeInstance])
        return actions
    }
}
