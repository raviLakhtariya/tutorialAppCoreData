//
//  Jobs+CoreDataProperties.swift
//  
//
//  Created by Elluminati Mac Mini 1 on 10/04/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Jobs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Jobs> {
        return NSFetchRequest<Jobs>(entityName: "Jobs");
    }

    @NSManaged public var applylink: String?
    @NSManaged public var companyid: Int16
    @NSManaged public var experience: String?
    @NSManaged public var jobdesc: String?
    @NSManaged public var jobId: Int16
    @NSManaged public var jobname: String?
    @NSManaged public var location: String?
    @NSManaged public var salery: String?
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension Jobs {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Company)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Company)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}
