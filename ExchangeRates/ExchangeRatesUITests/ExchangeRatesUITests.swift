//
//  ExchangeRatesUITests.swift
//  ExchangeRatesUITests
//
//  Created by Mariano Manuel on 4/10/21.
//

import XCTest

class ExchangeRatesUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testRatesLayout() {
        let navTitle = app.staticTexts["Rates"]
        let baseRateTitle = app.staticTexts["Base Rate"]
        let baseRateDescription = app.staticTexts["🇪🇺 -> 🇺🇸"]
        let latestRateTitle = app.staticTexts["Latest Rate"]
        let visualTitle = app.staticTexts["Visual"]
        let graphTitle = app.staticTexts["Exchange Rates Last Year"]
        let showRatesButton = app.buttons["Show Rates"]
        let rateSamplesButton = app.buttons["Sample"]
        
        XCTAssert(navTitle.exists)
        XCTAssert(baseRateTitle.exists)
        XCTAssert(baseRateDescription.exists)
        XCTAssert(latestRateTitle.exists)
        XCTAssert(visualTitle.exists)
        XCTAssert(graphTitle.exists)
        XCTAssert(showRatesButton.exists)
        XCTAssert(rateSamplesButton.exists)
    }
    
    func testNextViewLayout() {
        let SampleButton = app.buttons["Sample"]
        
        SampleButton.tap()
        let _ = app.waitForExistence(timeout: 5)
        
        let navTitle = app.staticTexts["Rate Sampling"]
        let convertingRatesTitle = app.staticTexts["Converting Rates"]
        let Japan = app.staticTexts["🇯🇵"]
        let GreatBritain = app.staticTexts["🇬🇧"]
        let Mexico = app.staticTexts["🇲🇽"]
        let UnitedStates = app.staticTexts["🇺🇸"]
        let Canada = app.staticTexts["🇨🇦"]
        let datePicker = app.datePickers.element
        
        XCTAssert(navTitle.exists)
        XCTAssert(convertingRatesTitle.exists)
        XCTAssert(Japan.exists)
        XCTAssert(GreatBritain.exists)
        XCTAssert(Mexico.exists)
        XCTAssert(UnitedStates.exists)
        XCTAssert(Canada.exists)
        XCTAssert(datePicker.exists)
        
        let RateButton = app.buttons["Rates"]
        XCTAssert(RateButton.exists)
        RateButton.tap()
    }
}
