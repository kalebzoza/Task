//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Kaleb  Carrizoza on 9/16/20.
//  Copyright © 2020 Kaleb  Carrizoza. All rights reserved.
//

import UIKit
import CoreData

class TaskDetailTableViewController: UITableViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDueTextField: UITextField!
    @IBOutlet weak var taskNotesTextField: UITextView!
    @IBOutlet var toDatePicker: UIDatePicker!
    
    
    
    var taskToReceive: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        
    }
    
    //MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let date = sender.date
        taskToReceive?.due = date
        taskDueTextField.text = date.stringValue()
    }
    
    @IBAction func userTappedView(_ sender: UITapGestureRecognizer) {
        taskNameTextField.resignFirstResponder()
        taskNotesTextField.resignFirstResponder()
        taskDueTextField.resignFirstResponder()
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text,
            let due = taskDueTextField.text,
            let notes = taskNameTextField.text,
        !name.isEmpty && !due.isEmpty && !notes.isEmpty else { return }
        if let task = taskToReceive {
        TaskController.shared.addTaskWith(name: name, notes: notes, due: Date())
        }else {
            let task = TaskController.shared.addTaskWith(name: name, notes: notes, due: Date())
            print(task)
        }
        navigationController?.popViewController(animated: true)
    }
        
        
    
    
    func updateViews() {
        guard let task = taskToReceive else { return }
        taskNameTextField.text = task.name
        taskDueTextField.text = (task.due as Date?)?.stringValue()
        taskNotesTextField.text = task.notes
    }
    
}// end of class





   
