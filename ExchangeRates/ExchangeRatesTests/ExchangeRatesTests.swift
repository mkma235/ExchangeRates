//
//  ExchangeRatesTests.swift
//  ExchangeRatesTests
//
//  Created by Mariano Manuel on 4/10/21.
//

import XCTest
@testable import ExchangeRates

class ExchangeRatesTests: XCTestCase {
    var session: URLSession!
    let latestRateURL = URL(string: "http://data.fixer.io/api/latest?access_key=6fed17b8bdf432a8e7961275b7b5c2c0&base=EUR&symbols=USD")
    let historicalRateURL = URL(string: "http://data.fixer.io/api/2021-04-10?access_key=6fed17b8bdf432a8e7961275b7b5c2c0&base=EUR&symbols=USD")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        session = nil
        super.tearDown()
    }

    func testValidHTTPStatusCode200() {
        let promise = expectation(description: "Status Code: 200")
        let dataTask = session.dataTask(with: latestRateURL!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func testAPICallCompletes() {
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = session.dataTask(with: historicalRateURL!) { data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
