//
//  TaskModel.swift
//  TaskIt!
//
//  Created by Scott Brady on 11/30/14.
//  Copyright (c) 2014 Spider Monkey Tech. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var isComplete: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
