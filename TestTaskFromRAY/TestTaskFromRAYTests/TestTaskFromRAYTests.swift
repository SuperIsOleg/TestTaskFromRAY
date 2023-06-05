//
//  TestTaskFromRAYTests.swift
//  TestTaskFromRAYTests
//
//  Created by Oleg Kalistratov on 30.05.23.
//


import XCTest
@testable import TestTaskFromRAY

class TestTaskFromRAYTests: XCTestCase {
    
    var imageCoreDataManager: ImageCoreDataManagerProtocol!
    
    override func setUp() {
        super.setUp()
        imageCoreDataManager = ImageCoreDataManager.shared
    }
    
    override func tearDown() {
        imageCoreDataManager = nil
        super.tearDown()
    }
    
    func testCreateImageModel() {
        let imageUrl = URL(string: "https://example.com/image.jpg")!
        let imageData = Data("testImageData".utf8)
        
        imageCoreDataManager.createImageModel(data: imageData, imageUrl: imageUrl)
        
        let imagesResult = imageCoreDataManager.getAllImages()
        switch imagesResult {
        case .success(let images):
            XCTAssertFalse(images.isEmpty, "Изображение должно быть создано в CoreData")
            if let createdImage = images.first {
                XCTAssertEqual(createdImage.imageUrl, imageUrl, "URL должны совпадать")
                XCTAssertEqual(createdImage.imageData, imageData, "Данные должны быть одинаковыми")
            }
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDeleteImageModel() {
        let imageUrl = URL(string: "https://example.com/image.jpg")!
        let imageData = Data("testImageData".utf8)
        
        imageCoreDataManager.createImageModel(data: imageData, imageUrl: imageUrl)
        
        let imagesResult = imageCoreDataManager.getAllImages()
        var initialCount = 0
        
        switch imagesResult {
        case .success(let images):
            initialCount = images.count
            if let imageToDelete = images.first {
                imageCoreDataManager.deleteImageModel(item: imageToDelete)
            } else {
                XCTFail("Должно быть хотя бы одно изображение для удаления")
            }
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
        
        let imagesAfterDeletionResult = imageCoreDataManager.getAllImages()
        switch imagesAfterDeletionResult {
        case .success(let imagesAfterDeletion):
            XCTAssertEqual(imagesAfterDeletion.count, initialCount - 1, "Количество изображений должно уменьшиться на 1")
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
    
    func testPerformanceExample() throws {
        self.measure { }
    }
    
}
