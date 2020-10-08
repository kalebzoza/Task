//
//  Task+Convenience..swift
//  Task
//
//  Created by Kaleb  Carrizoza on 9/16/20.
//  Copyright © 2020 Kaleb  Carrizoza. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    convenience init(name: String, notes: String, due: Date?, isComplete: Bool, context:NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = isComplete
    }
}
