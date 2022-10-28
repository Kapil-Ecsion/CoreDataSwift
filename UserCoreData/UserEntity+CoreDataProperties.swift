//
//  UserEntity+CoreDataProperties.swift
//  UserCoreData
//
//  Created by phonestop on 10/27/22.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var uName: String?

}

extension UserEntity : Identifiable {

}
