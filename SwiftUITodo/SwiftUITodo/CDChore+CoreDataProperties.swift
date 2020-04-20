//
//  CDChore+CoreDataProperties.swift
//  SwiftUITodo
//
//  Created by Ethan Hess on 4/19/20.
//  Copyright © 2020 Ethan Hess. All rights reserved.
//
//

import Foundation
import CoreData


extension CDChore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDChore> {
        return NSFetchRequest<CDChore>(entityName: "CDChore")
    }

    @NSManaged public var body: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var imageData: Data?
    @NSManaged public var uid: String?

}
