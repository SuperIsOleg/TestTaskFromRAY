//
//  CoreDataManager.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import UIKit

import CoreData

protocol ImageCoreDataManagerProtocol {
    func getAllImages() -> Result<[ImageModel], Error>
    func createImageModel(data: Data, imageUrl: URL)
    func deleteImageModel(item: ImageModel)
    func updateImageModel(item: ImageModel, imageData: Data, imageUrl: URL)
}

@objc(ImageModel)
public class ImageModel: NSManagedObject {

}

extension ImageModel {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageModel> {
        return NSFetchRequest<ImageModel>(entityName: "ImageModel")
    }

    @NSManaged public var imageUrl: URL
    @NSManaged public var imageData: Data
    @NSManaged public var createdAt: Date

}

extension ImageModel : Identifiable {

}

class ImageCoreDataManager: ImageCoreDataManagerProtocol {

    static let shared = ImageCoreDataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    internal func getAllImages() -> Result<[ImageModel], Error> {
        do {
            let items = try self.context.fetch(ImageModel.fetchRequest())
            return .success(items)
        } catch {
            return .failure(error.localizedDescription as! Error)
        }
    }
    
    internal func createImageModel(data: Data, imageUrl: URL) {
        let newItem = ImageModel(context: self.context)
        newItem.imageData = data
        newItem.imageUrl = imageUrl
        newItem.createdAt = Date()
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    internal func deleteImageModel(item: ImageModel) {
        self.context.delete(item)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateImageModel(item: ImageModel, imageData: Data, imageUrl: URL) {
        item.imageData = imageData
        item.imageUrl = imageUrl
        item.createdAt = Date()
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

}
