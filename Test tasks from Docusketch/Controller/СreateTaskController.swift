//
//  СreateTaskController.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 13.07.2023.
//

import UIKit

class СreateTaskController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(buttonSaveIsPressed))
        return button
    }()
    
    //MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        title = "Create a task"
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc
    func buttonSaveIsPressed() {
        
    }
    
}
