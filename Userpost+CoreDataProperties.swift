//
//  Userpost+CoreDataProperties.swift
//  
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Userpost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Userpost> {
        return NSFetchRequest<Userpost>(entityName: "Userpost");
    }

    @NSManaged public var postid: Int16
    @NSManaged public var userid: Int16
    @NSManaged public var postTitle: String?
    @NSManaged public var postDescription: String?

}
