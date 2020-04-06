//
//  CurrencyConverterUITests.swift
//  CurrencyConverterUITests
//
//  Created by Bhuman Soni on 20/2/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import XCTest

class CurrencyConverterUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testAllUIElementsExist() {
        
        let app = XCUIApplication()
        app.textFields["aud($) I have"].tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        app.buttons["CONVERT"].tap()
        app/*@START_MENU_TOKEN@*/.pickerWheels["Baht (Thailand)"]/*[[".pickers.pickerWheels[\"Baht (Thailand)\"]",".pickerWheels[\"Baht (Thailand)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["currency I get"].tap()
    }
    func testConversion() {
        let app = XCUIApplication()
        app.textFields["aud($) I have"].tap()
        let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        let key2 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        let converted = app.textFields["currency I get"].value
        XCTAssertNotNil(converted)
        
    }
    /*
     This test is not working properly and needs to be fixed
     This test is incomplete, need to finish it
     */
    func testValueChange() {
        let app = XCUIApplication()
        app.textFields["aud($) I have"].tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        app.toolbars["Toolbar"].buttons["Done"].tap()
        let value = app.textFields["currency I get"].value
        print(value!)
        app.pickerWheels["Baht (Thailand)"].press(forDuration: 2.4);
        app.textFields["currency I get"].tap()
        //app/*@START_MENU_TOKEN@*/.pickerWheels["Baht (Thailand)"].press(forDuration: 1.2);/*[[".pickers.pickerWheels[\"Baht (Thailand)\"]",".tap()",".press(forDuration: 1.2);",".pickerWheels[\"Baht (Thailand)\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        //app/*@START_MENU_TOKEN@*/.pickerWheels["Dirham (United Arab Emirates)"]/*[[".pickers.pickerWheels[\"Dirham (United Arab Emirates)\"]",".pickerWheels[\"Dirham (United Arab Emirates)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let val2 = app.textFields["currency I get"].value
        print(val2!)
        
    }
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
