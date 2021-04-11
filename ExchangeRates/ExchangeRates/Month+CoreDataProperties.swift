//
//  Month+CoreDataProperties.swift
//  ExchangeRates
//
//  Created by Mariano Manuel on 4/10/21.
//
//

import Foundation
import CoreData


extension Month {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Month> {
        return NSFetchRequest<Month>(entityName: "Month")
    }

    @NSManaged public var rate: Double
    @NSManaged public var id: Int16
    @NSManaged public var date: String

}

extension Month : Identifiable {

}
