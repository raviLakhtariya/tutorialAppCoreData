//
//  Posts+CoreDataProperties.swift
//  
//
//  Created by Elluminati Mac Mini 1 on 10/04/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Posts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Posts> {
        return NSFetchRequest<Posts>(entityName: "Posts");
    }

    @NSManaged public var comapnyid: Int16
    @NSManaged public var postdescriptions: String?
    @NSManaged public var postid: Int16
    @NSManaged public var posttitle: String?
    @NSManaged public var userid: Int16
    @NSManaged public var companypost: NSSet?
    @NSManaged public var userpost: NSSet?

}

// MARK: Generated accessors for companypost
extension Posts {

    @objc(addCompanypostObject:)
    @NSManaged public func addToCompanypost(_ value: Company)

    @objc(removeCompanypostObject:)
    @NSManaged public func removeFromCompanypost(_ value: Company)

    @objc(addCompanypost:)
    @NSManaged public func addToCompanypost(_ values: NSSet)

    @objc(removeCompanypost:)
    @NSManaged public func removeFromCompanypost(_ values: NSSet)

}

// MARK: Generated accessors for userpost
extension Posts {

    @objc(addUserpostObject:)
    @NSManaged public func addToUserpost(_ value: User)

    @objc(removeUserpostObject:)
    @NSManaged public func removeFromUserpost(_ value: User)

    @objc(addUserpost:)
    @NSManaged public func addToUserpost(_ values: NSSet)

    @objc(removeUserpost:)
    @NSManaged public func removeFromUserpost(_ values: NSSet)

}
