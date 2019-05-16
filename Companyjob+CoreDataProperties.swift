//
//  Companyjob+CoreDataProperties.swift
//  
//
//  Created by Elluminati Mac Mini 1 on 07/04/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Companyjob {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Companyjob> {
        return NSFetchRequest<Companyjob>(entityName: "Companyjob");
    }

    @NSManaged public var companyid: Int16
    @NSManaged public var jobid: Int16
    @NSManaged public var jobname: String?
    @NSManaged public var experience: String?
    @NSManaged public var applylink: String?
    @NSManaged public var salery: String?
    @NSManaged public var location: String?
    @NSManaged public var jobdec: String?

}
