//
//  ImageModel+CoreDataProperties.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//
//

import Foundation
import CoreData


extension ImageModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageModel> {
        return NSFetchRequest<ImageModel>(entityName: "ImageModel")
    }

    @NSManaged public var imageUrl: URL?
    @NSManaged public var imageData: Data?
    @NSManaged public var createdAt: Date?

}

extension ImageModel : Identifiable {

}
