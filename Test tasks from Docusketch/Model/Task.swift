//
//  Task.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 13.07.2023.
//

import Foundation

enum TaskStatus: Int {
    case planned
    case completed
}

protocol TaskProtocol {
    var title: String { get set }
    var status: TaskStatus { get set }
}

struct Task: TaskProtocol {
    var title: String
    var status: TaskStatus
    var uuid: UUID
}
