//
//  DateHelper.swift
//  Task
//
//  Created by Kaleb  Carrizoza on 9/17/20.
//  Copyright © 2020 Kaleb  Carrizoza. All rights reserved.
//

import Foundation


extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        return formatter.string(from: self)
    }
    
}

