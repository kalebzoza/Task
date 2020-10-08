//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Kaleb  Carrizoza on 9/17/20.
//  Copyright © 2020 Kaleb  Carrizoza. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate{
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchResultsController.delegate = self
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return TaskController.shared.fetchResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.fetchResultsController.sections?[section].objects?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else {return UITableViewCell()}

        let task = TaskController.shared.fetchResultsController.object(at: indexPath)
        
        
        cell.task = task
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.shared.fetchResultsController.object(at: indexPath)
            TaskController.shared.removeTask(task: taskToDelete)
        }
    }
    //MARK: - TableView HeaderSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TaskController.shared.fetchResultsController.sectionIndexTitles[section] == "0" ? "InComplete" : "Complete"
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        //Identifier
        if segue.identifier == "taskToDetailVC" {
            //Index
            guard let indexPath = tableView.indexPathForSelectedRow,
            //Destination
                let destinationVC = segue.destination as? TaskDetailTableViewController else {return}
            //Object to send
            let taskToSend = TaskController.shared.fetchResultsController.object(at: indexPath)
            //Object to receive
            destinationVC.taskToReceive = taskToSend
        }
    }
}// end of class

//MARK: - Extensions
extension TaskDetailTableViewController: NSFetchedResultsControllerDelegate {
    func buttonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        TaskController.shared.fetchResultsController.object(at: indexPath)
        
    }
}//end of extension

extension TaskDetailTableViewController: NSFetchedResultsControllerDelegate {
func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    self.tableView.beginUpdates()
}

func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    
    switch type {
    case .insert:
        let indexSet = IndexSet(integer: sectionIndex)
        tableView.insertSections(indexSet, with: .automatic)
        
    case .delete:
        let indexSet = IndexSet(integer: sectionIndex)
        tableView.deleteSections(indexSet, with: .automatic)
        
    default:
        break
    }
}

func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
    switch type {
    case .delete:
        guard let indexPath = indexPath else {return}
        tableView.deleteRows(at: [indexPath], with: .fade)
    case .insert:
        guard let newIndexPath = newIndexPath else {return}
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    case .move:
        guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
        tableView.moveRow(at: oldIndexPath, to: newIndexPath)
    case .update:
        guard let indexPath = indexPath else {return}
        tableView.reloadRows(at: [indexPath], with: .automatic)
    @unknown default:
        fatalError()
    }
}

func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
}
}
