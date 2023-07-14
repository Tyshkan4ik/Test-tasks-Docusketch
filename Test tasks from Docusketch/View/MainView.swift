//
//  MainView.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 13.07.2023.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func deleteTask(index: Int)
}

/// view для main сцены
class MainView: UIView {
    
    //MARK: - Proprties
    
    weak var delegate: MainViewDelegate?
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "012")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var table: UITableView = {
       let table = UITableView()
        table.layer.cornerRadius = 10
        table.alpha = 0.8
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
            table.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            table.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            table.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTable() {
        table.delegate = self
        table.dataSource = self
        table.register(CellForTable.self, forCellReuseIdentifier: CellForTable.identifier)
    }
}

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

extension MainView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        modelTask[indexPath.row].status = .completed
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let actionDelete = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, _ in
            self?.modelTask.remove(at: indexPath.row)
            self?.table.reloadData()
            }
        actionDelete.image = UIImage(systemName: "trash")
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        
        
        return actions
    }
}
