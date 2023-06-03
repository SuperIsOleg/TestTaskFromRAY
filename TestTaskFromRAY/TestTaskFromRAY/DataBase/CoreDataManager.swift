//
//  CoreDataManager.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import UIKit

protocol CoreDataManagerProtocol {
    func getAllItems() -> Result<[ImageModel], Error>
    func createItem(data: Data, imageUrl: URL)
    func deleteItem(item: ImageModel)
    func updateItem(item: ImageModel, imageData: Data, imageUrl: URL)
}

class CoreDataManager: CoreDataManagerProtocol {

    static let shared = CoreDataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    internal func getAllItems() -> Result<[ImageModel], Error> {
        do {
            let items = try self.context.fetch(ImageModel.fetchRequest())
            return .success(items)
        } catch {
            return .failure(error.localizedDescription as! Error)
        }
    }
    
    internal func createItem(data: Data, imageUrl: URL) {
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
    
    internal func deleteItem(item: ImageModel) {
        self.context.delete(item)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateItem(item: ImageModel, imageData: Data, imageUrl: URL) {
        item.imageData = imageData
        item.createdAt = Date()
        item.imageUrl = imageUrl
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

}
