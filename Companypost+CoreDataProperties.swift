//
//  Companypost+CoreDataProperties.swift
//  
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Companypost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Companypost> {
        return NSFetchRequest<Companypost>(entityName: "Companypost");
    }

    @NSManaged public var companyid: Int16
    @NSManaged public var postid: Int16
    @NSManaged public var postTitle: String?
    @NSManaged public var postDescription: String?

}
