//
//  CoreDataManager.swift
//  Test tasks from Docusketch
//
//  Created by Виталий Троицкий on 14.07.2023.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()
    private let container = NSPersistentContainer(name: "CoreData")
    private let entityName = "DBTask"
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {}
    
    /// Регистрация контейнера
    func registerContainer() {
        container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                assertionFailure("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    ///Метод сохранения в БД
    func save(task: Task) {
        do {
            let dbTask = DBTask(context: context)
            dbTask.title = task.title
            dbTask.category = task.status
            dbTask.uuid = task.uuid
            try context.save()
        }
        catch {
            print("Save error")
        }
    }
    
    ///Метод выгрузки из БД
    func getTask(completion: @escaping ([DBTask]) -> Void) {
        context.perform { [weak self] in
            guard let self = self else { return }
            do {
                let request = NSFetchRequest<DBTask>(entityName: self.entityName)
                let task = try self.context.fetch(request)
                completion(task)
            }
            catch {
                completion([])
                print("Request error ")
            }
        }
    }
    
    ///Метод изменения в БД
    func change(taskId: Task) {
        do {
            let request = NSFetchRequest<DBTask>(entityName: self.entityName)
            let tasks = try self.context.fetch(request)
            if let task = tasks.first(where: { $0.uuid == taskId.uuid}) {
                task.category = taskId.status
                try context.save()
            }
        }
        catch {
            print("change error")
        }
    }
    
    
    ///Метод удаление из БД
    func delete(taskId: Task) {
        do {
            let request = NSFetchRequest<DBTask>(entityName: self.entityName)
            let tasks = try self.context.fetch(request)
            if let task = tasks.first(where: { $0.uuid == taskId.uuid}) {
                context.delete(task)
                try context.save()
            }
        }
        catch {
            print("Delete error")
        }
    }
}
