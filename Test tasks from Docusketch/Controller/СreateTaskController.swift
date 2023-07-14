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
    
    /// Константы используемые в данном классе
    private enum Constants {
        static let placeholder = "Enter a new task"
        static let title = "Create a task"
        static let leadingTrailingConstraint: CGFloat = 20
        static let topConstraint: CGFloat = 30
    }
    
    //MARK: - Properties
    
    weak var delegate: СreateTaskControllerDelegate?
    
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(buttonSaveIsPressed))
        return button
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = Constants.placeholder
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
        gestureRecognizer()
    }
    
    /// Распознаватель жестов (для сварачивания клавиатуры по tap)
    private func gestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAround))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func tapAround() {
        view.endEditing(true)
    }
    
    private func setupNavigationItem() {
        title = Constants.title
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc
    func buttonSaveIsPressed() {
        CoreDataManager.shared.save(task: Task(title: textField.text ?? "", status: TaskStatus.planned, uuid: UUID()))
        delegate?.reloadNew()
        navigationController?.popViewController(animated: true)
    }
    
    private func setupElements() {
        view.addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingTrailingConstraint),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingTrailingConstraint),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topConstraint)
        ])
    }
}
