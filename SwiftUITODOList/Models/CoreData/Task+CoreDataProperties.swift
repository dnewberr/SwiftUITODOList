//
//  Task+CoreDataProperties.swift
//  SwiftUITODOList
//
//  Created by Deborah Newberry on 6/20/19.
//  Copyright © 2019 Deborah Newberry. All rights reserved.
//
//

import Foundation
import CoreData

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var dateAdded: Date
    @NSManaged public var id: UUID
    @NSManaged public var isComplete: Bool
    @NSManaged public var taskDescription: String
}
