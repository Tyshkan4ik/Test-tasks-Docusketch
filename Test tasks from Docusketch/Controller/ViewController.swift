//
//  ViewController.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 13.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    /// Константы используемые в данном классе
    private enum Constants {
        static let title = "To-do List"
    }
    
    //MARK: - Properties
    
    let mainView = MainView()
    
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAddIsPressed))
        return button
    }()
    
    var arrayModelTask: [Task] = []
    
    //MARK: - Methods
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTask()
        mainView.delegate = self
        setupNavigationItem()
        mainView.setupModelForCell(model: arrayModelTask)
    }
    
    @objc
    func buttonAddIsPressed() {
        let controller = СreateTaskController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func setupNavigationItem() {
        title = Constants.title
        navigationItem.rightBarButtonItem = rightButton
    }
    
    /// Выгружаем задачи из CoreData в массив array
    private func getTask() {
        CoreDataManager.shared.getTask { [weak self] tasks in
            
            guard let self = self else { return }
            self.arrayModelTask = tasks.map { Task(title: $0.title, status: $0.category, uuid: $0.uuid)
            }
            self.mainView.modelTask = self.arrayModelTask
            self.mainView.table.reloadData()
        }
    }
    
    func taskSorting() -> [Task] {
        let sortedModel = arrayModelTask.sorted { task1, task2 in
            task1.status.rawValue < task2.status.rawValue
        }
        return sortedModel
    }
}

//MARK: - Extensions - СreateTaskControllerDelegate

extension ViewController: СreateTaskControllerDelegate {
    
    /// Обновляем таблицу после добавления новой задачи
    func reloadNew() {
        getTask()
    }
    
    func addNewTask(string: String?, uuid: UUID) {
        if let newTask = string, newTask != "" {
            arrayModelTask.append(Task(title: newTask, status: .planned, uuid: uuid))
            mainView.setupModelForCell(model: arrayModelTask)
            mainView.table.reloadData()
        }
    }
}

//MARK: - Extensions - MainViewDelegate

extension ViewController: MainViewDelegate {
    func taskNotImplemented(index: Int) {
        if arrayModelTask[index].status == .completed {
            arrayModelTask[index].status = .planned
            arrayModelTask = taskSorting()
            CoreDataManager.shared.change(taskId: arrayModelTask[index])
            mainView.setupModelForCell(model: arrayModelTask)
            mainView.table.reloadData()
        }
    }
    
    func deleteTask(index: Int) {
        CoreDataManager.shared.delete(taskId: (arrayModelTask[index]))
        arrayModelTask.remove(at: index)
        mainView.setupModelForCell(model: arrayModelTask)
        mainView.table.reloadData()
    }
    
    func taskCompleted(index: Int) {
        if arrayModelTask[index].status != .completed {
            arrayModelTask[index].status = .completed
            arrayModelTask = taskSorting()
            CoreDataManager.shared.change(taskId: arrayModelTask[index])
            mainView.setupModelForCell(model: arrayModelTask)
            mainView.table.reloadData()
        }
    }
}
