//
//  DBTask.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 14.07.2023.
//

import CoreData

@objc(DBTask)

class DBTask: NSManagedObject {
    
//    enum Status: Int {
//        case planned
//        case completed
//    }
    
    @NSManaged var categoryEnum: Int16

    var category: TaskStatus {
        get {
            return TaskStatus(rawValue: Int(categoryEnum))!
        }
        set {
            self.categoryEnum = Int16(newValue.rawValue)
        }
    }
    @NSManaged var title: String
    @NSManaged var uuid: UUID
}
