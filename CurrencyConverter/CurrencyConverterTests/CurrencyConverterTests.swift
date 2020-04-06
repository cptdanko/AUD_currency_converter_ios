//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Bhuman Soni on 20/2/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class CurrencyConverterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsMockDataWorking() {
        let mockData = MockData.getMockCurrencies()
        XCTAssertEqual(mockData.count, 7)
    }
    func testCorrectCurrencyDispStr() {
        let displayStr = MockData.getMockCurrencies()[0].toDisplayInUI()
        XCTAssertEqual(displayStr, "Euro (Europe)")
    }
    func testDoesCurrencyAPIReturnData() {
        let api = APIFactory.getCurrencyAPI()
        let currencyExpectation: XCTestExpectation = expectation(description: "Currencies Fetch")
        api.fetchExchangeRates { (currencies, err) in
            currencyExpectation.fulfill()
            
        }
        wait(for: [currencyExpectation], timeout: 5)
    }
    func testDoesAPIReturnEuro() {
        let api = APIFactory.getCurrencyAPI()
        let euroExpectation = expectation(description: "Expecting Euros to be returned")
        api.getExchangeRate(code: "Euro") { (currency, error) in
            euroExpectation.fulfill()
        }
        wait(for: [euroExpectation], timeout: 5)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
