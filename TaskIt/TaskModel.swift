//
//  TaskModel.swift
//  TaskIt
//
//  Created by Brown Magic on 3/25/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import Foundation
import CoreData

class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
