//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Kaleb  Carrizoza on 9/17/20.
//  Copyright © 2020 Kaleb  Carrizoza. All rights reserved.
//

import UIKit

//MARK: - protocols
protocol ButtonTableViewDelegate: AnyObject {
    func buttonTapped(_ sender: ButtonTableViewCell)
}

class ButtonTableViewCell: UITableViewCell {
    //MARK: -Outlets
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    //MARK: - Properties
    var task: Task?
    
    weak var delegate: ButtonTableViewDelegate?
    
    //MARK: -Actions
    @IBAction func buttonTapped(_ sender: Any) {
        
    }
    
    //MARK: - Helper Functions
    func update(withTask task: Task) {
        primaryLabel.text = task.name
        if task.isComplete {
            if let task = task.name {
                completeButton.setImage(UIImage(named: task), for: .normal)
            }else {
                completeButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
            }
        }
    }
    
    
    
   

}//end of class
