//
//  User+CoreDataProperties.swift
//  
//
//  Created by Elluminati Mac Mini 1 on 10/04/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var address: String?
    @NSManaged public var conformpassword: String?
    @NSManaged public var email: String?
    @NSManaged public var link: String?
    @NSManaged public var mobileno: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var selectCity: String?
    @NSManaged public var selectCountry: String?
    @NSManaged public var status: Bool
    @NSManaged public var userid: Int16
    @NSManaged public var posts: NSSet?

}

// MARK: Generated accessors for posts
extension User {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: Posts)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: Posts)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}
