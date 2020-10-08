//
//  TaskController.swift
//  Task
//
//  Created by Kaleb  Carrizoza on 9/16/20.
//  Copyright © 2020 Kaleb  Carrizoza. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()
    
    //var tasks: [Task] = []
    
   var fetchResultsController: NSFetchedResultsController<Task>
    
    init() {
    let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
           fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
       
           let resultController: NSFetchedResultsController<Task> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
           
           fetchResultsController = resultController
           
           do {
               try fetchResultsController.performFetch()
           }catch {
               print("\(error.localizedDescription)")
               
           }
    }
    
    //MARK: - CRUD
    func addTaskWith(name: String, notes: String, due: Date?) {
        _ = Task(name: name, notes: notes, due: Date(), isComplete: true)
        saveToPersistence()
    }
    
    func updateTaskWith(task: Task) {
        saveToPersistence()
    }
    
    func removeTask(task: Task) {
        let moc = CoreDataStack.context
        moc.delete(task)
        saveToPersistence()
    }
    
    //MARK: - Persistence
    func saveToPersistence() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        }catch let error {
            print("\(error.localizedDescription)")
        }
    }
    
    func fetchTask() -> [Task] {
        return mockTask
    }
    
    var mockTask: [Task] = {
        let mockDate  = Date(timeIntervalSinceNow: 432000) // 5 days
        let tasks = [Task(name: "Do chores", notes: "Clean bedroom", due: mockDate, isComplete: false),
        Task(name: "Go to store", notes: "Buy milk", due: mockDate, isComplete: true)]
        
        return tasks
    }()
    
}//end of class
