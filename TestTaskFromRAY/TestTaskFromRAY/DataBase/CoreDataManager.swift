//
//  CoreDataManager.swift
//  TestTaskFromRAY
//
//  Created by Oleg Kalistratov on 31.05.23.
//

import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    internal func getAllItems() -> Result<[ImageModel], Error>{
        do {
            let items = try self.context.fetch(ImageModel.fetchRequest())
            return .success(items)
        } catch {
            return .failure(error.localizedDescription as! Error)
        }
    }
    
    internal func createItem(data: Data) {
        let newItem = ImageModel(context: self.context)
        newItem.imageData = data
        newItem.createdAt = Date()
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    internal func deleteItem(item: ImageModel) {
        self.context.delete(item)
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func updateItem(item: ImageModel, imageData: Data) {
        item.imageData = imageData
        
        do {
            try context.save()
        } catch {
            
        }
    }

}
