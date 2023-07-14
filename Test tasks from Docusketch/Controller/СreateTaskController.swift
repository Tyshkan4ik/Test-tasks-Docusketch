//
//  СreateTaskController.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 13.07.2023.
//

import UIKit

protocol СreateTaskControllerDelegate: AnyObject {
    func addNewTask(string: String?, uuid: UUID)
    func reloadNew()
}

class СreateTaskController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: СreateTaskControllerDelegate?
    
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(buttonSaveIsPressed))
        return button
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter a new task"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationItem()
        setupElements()
        setupConstraints()
        
    }
    
    
    private func setupNavigationItem() {
        title = "Create a task"
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc
    func buttonSaveIsPressed() {
        //delegate?.addNewTask(string: textField.text)
        CoreDataManager.shared.save(task: Task(title: textField.text ?? "ошибка", status: TaskStatus.planned, uuid: UUID()))
        delegate?.reloadNew()
        navigationController?.popViewController(animated: true)
    }
    
    private func setupElements() {
        view.addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    
}
