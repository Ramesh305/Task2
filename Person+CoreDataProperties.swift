//
//  Person+CoreDataProperties.swift
//  Task
//
//  Created by Ramesh Mishra on 25/12/19.
//  Copyright © 2019 ramesh.mishra. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var userName: String?
    @NSManaged public var mobileNumber: String?
    @NSManaged public var emailId: String?
    @NSManaged public var street: String?
    @NSManaged public var city: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var website: String?
    @NSManaged public var companyName: String?

}
