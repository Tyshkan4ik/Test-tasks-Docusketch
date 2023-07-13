//
//  ViewController.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 13.07.2023.
//

import UIKit



class ViewController: UIViewController {
    
    //MARK: - Properties
    
    private let mainView = MainView()
    
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAddIsPressed))
        return button
    }()
    
    var array: [Task] = []
    //[Task(title: "Чего какого", status: .planned), Task(title: "Купить хлеб", status: .completed)]
    
    //MARK: - Methods
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mainView.delegate = self
        setupNavigationItem()
        mainView.setupModelForCell(model: array)
    }
    
    @objc
    func buttonAddIsPressed() {
        let controller = СreateTaskController()
        navigationController?.pushViewController(controller, animated: true)
    }

    private func setupNavigationItem() {
        title = "To-do List"
        navigationItem.rightBarButtonItem = rightButton
    }

}

//MARK: - Extensions - MainViewDelegate

//extension ViewController: MainViewDelegate {
    
    
    
//}

