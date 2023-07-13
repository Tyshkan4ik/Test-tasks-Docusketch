//
//  ViewController.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 13.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Proprties
    
    private let mainView = MainView()
    
    //MARK: - Methods
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .yellow
        mainView.delegate = self
    }


}

//MARK: - Extensions - MainViewDelegate

extension ViewController: MainViewDelegate {
    
}

