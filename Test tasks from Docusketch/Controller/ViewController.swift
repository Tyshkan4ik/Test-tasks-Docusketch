//
//  ViewController.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 13.07.2023.
//

import UIKit



class ViewController: UIViewController {
    
    //MARK: - Properties
    
    let mainView = MainView()
    
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAddIsPressed))
        return button
    }()
    
    var array: [Task] = []
    
    //MARK: - Methods
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTask()
        mainView.delegate = self
        
        setupNavigationItem()
        mainView.setupModelForCell(model: array)

    }
    
    @objc
    func buttonAddIsPressed() {
        let controller = СreateTaskController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }

    private func setupNavigationItem() {
        title = "To-do List"
        navigationItem.rightBarButtonItem = rightButton
    }
    
    /// Выгружаем задачи из CoreData в массив array
    private func getTask() {
        CoreDataManager.shared.getTask { [weak self] tasks in
            
            guard let self = self else { return }
            self.array = tasks.map { Task(title: $0.title, status: $0.category, uuid: $0.uuid)
            }
            self.mainView.modelTask = self.array
            self.mainView.table.reloadData()
        }
    }
    func taskSorting() -> [Task] {
    let sortedModel = array.sorted { task1, task2 in
            task1.status.rawValue < task2.status.rawValue
        }
        return sortedModel
    }
}

//MARK: - Extensions - СreateTaskControllerDelegate

extension ViewController: СreateTaskControllerDelegate {
    
    func reloadNew() {
        getTask()
    }
    
    func addNewTask(string: String?, uuid: UUID) {
        if let newTask = string, newTask != "" {
            array.append(Task(title: newTask, status: .planned, uuid: uuid))
            mainView.setupModelForCell(model: array)
            mainView.table.reloadData()
        }
    }
}

//MARK: - Extensions - MainViewDelegate

extension ViewController: MainViewDelegate {
    func taskNotImplemented(index: Int) {
        if array[index].status == .completed {
            array[index].status = .planned
            array = taskSorting()
            CoreDataManager.shared.change(taskId: array[index])
            mainView.setupModelForCell(model: array)
            mainView.table.reloadData()
        }
    }
    
    func deleteTask(index: Int) {
        CoreDataManager.shared.delete(taskId: (array[index]))
        array.remove(at: index)
        mainView.setupModelForCell(model: array)
        mainView.table.reloadData()
    }
    
    func taskCompleted(index: Int) {
        if array[index].status != .completed {
            array[index].status = .completed
            array = taskSorting()
            CoreDataManager.shared.change(taskId: array[index])
            mainView.setupModelForCell(model: array)
            mainView.table.reloadData()
        }
    }
    
    
    
}
