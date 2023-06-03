//
//  TestTaskFromRAYUITest.swift
//  TestTaskFromRAYUITests
//
//  Created by Oleg Kalistratov on 3.06.23.
//

import XCTest

final class TestTaskFromRAYUITest: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testSearchAndAddedImage() throws {
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.exists)
        
        let searchButtonInTabBar = tabBar.buttons["Search"]
        XCTAssertTrue(searchButtonInTabBar.exists)
        
        let searchTextField = app.textFields["Search ..."]
        XCTAssertTrue(searchTextField.exists)
        searchTextField.tap()
        searchTextField.typeText("Gggg")
        
        let searchButton = app.buttons.containing(.staticText, identifier: "Search").element
        XCTAssertTrue(searchButton.exists, "Not found the button")
        XCTAssertTrue(searchButton.isEnabled)
        searchButton.tap()
        
        let addToFavoriteButton = app.buttons["Add to favorite"]
        XCTAssertTrue(addToFavoriteButton.exists, "Not found the button")
        XCTAssertTrue(addToFavoriteButton.isEnabled)
        addToFavoriteButton.tap()
        
        XCTAssertFalse(searchButton.isEnabled)
        XCTAssertFalse(addToFavoriteButton.isEnabled)
        
        let alert = app.alerts.staticTexts["Picture successfully added to favorites"]
        XCTAssertTrue(alert.waitForExistence(timeout: 1), "Not found alert")
        
        let okButtonInAlert = app.alerts.buttons["Ok"]
        XCTAssertTrue(okButtonInAlert.exists, "Not found the button")
        okButtonInAlert.tap()
        
    }
    
    func testDeleteImageFromFavoriteScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["Search ..."]
        XCTAssertTrue(searchTextField.exists)
        searchTextField.tap()
        searchTextField.typeText("Ttt")
        
        let searchButton = app.buttons.containing(.staticText, identifier: "Search").element
        XCTAssertTrue(searchButton.exists, "Not found the button")
        XCTAssertTrue(searchButton.isEnabled)
        searchButton.tap()
        
        let addToFavoriteButton = app.buttons["Add to favorite"]
        XCTAssertTrue(addToFavoriteButton.exists, "Not found the button")
        XCTAssertTrue(addToFavoriteButton.isEnabled)
        addToFavoriteButton.tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        XCTAssertTrue(tabBar.exists)
        
        let favoriteButtonInTabBar = tabBar.buttons["Favorite"]
        XCTAssertTrue(favoriteButtonInTabBar.exists)
        favoriteButtonInTabBar.tap()
        
        let tableViewCell = app.tables.children(matching: .cell).firstMatch
        XCTAssertTrue(tableViewCell.exists, "Not found cell")
        
        let deleteButtonOnCell = tableViewCell.buttons["trash"]
        XCTAssertTrue(deleteButtonOnCell.exists)
        deleteButtonOnCell.tap()
        
    }
    
    func testShowErrorAlert() throws {
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["Search ..."]
        XCTAssertTrue(searchTextField.exists)
        searchTextField.tap()
        searchTextField.typeText(" ваорпапр")
        
        let searchButton = app.buttons.containing(.staticText, identifier: "Search").element
        XCTAssertTrue(searchButton.exists, "Not found the button")
        XCTAssertTrue(searchButton.isEnabled)
        searchButton.tap()
        
        let alert =  app.alerts["Request URL is not valid"]
        XCTAssertTrue(alert.waitForExistence(timeout: 0.5), "Not found alert")
        
        let okButtonInAlert = app.alerts.buttons["Ok"]
        XCTAssertTrue(okButtonInAlert.exists, "Not found the button")
        okButtonInAlert.tap()
        
    }
    
    func testShowLimitedAlert() throws {
        let app = XCUIApplication()
        app.launch()
        
        let limitCount = 5
        let requestLimitText = app.staticTexts["Request limit: \(limitCount)"]
        XCTAssertTrue(requestLimitText.exists, "Request limit: \(limitCount) - not found")
        
        Array(0...limitCount).forEach({_ in
            let searchTextField = app.textFields["Search ..."]
            XCTAssertTrue(searchTextField.exists)
            searchTextField.tap()
            searchTextField.typeText("Ttt")
            
            let searchButton = app.buttons.containing(.staticText, identifier: "Search").element
            XCTAssertTrue(searchButton.exists, "Not found the button")
            XCTAssertTrue(searchButton.isEnabled)
            searchButton.tap()
        })
        
        XCTAssertTrue(app.staticTexts["Request limit: 0"].exists, "Request limit: 0 - not found")
        
        let alert = app.alerts.staticTexts["Request limit exceeded"]
        XCTAssertTrue(alert.waitForExistence(timeout: 0.5), "Not found alert")
        
        let okButtonInAlert = app.alerts.buttons["Ok"]
        XCTAssertTrue(okButtonInAlert.exists, "Not found the button")
        okButtonInAlert.tap()
        
    }
    
}
