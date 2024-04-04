//
//  Numerics_ParsingTests.swift
//  Numerics ParsingTests
//
//  Created by Zac Cohan on 5/4/2024.
//

import XCTest
@testable import Numerics_Parsing

final class Numerics_ParsingTests: XCTestCase {


    func testXApplesSoldYesterday() {
        
        guard let result = NumericsParser.parse(expression: "10 apples sold yesterday") else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(result.number, 10.0)
        XCTAssertTrue(Calendar.current.isDateInYesterday(result.date))
        
    }

    
    func testXApplesSoldOnDate() {
        
        guard let result = NumericsParser.parse(expression: "20 apples sold on 1st April") else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(result.number, 20.0)
        let dateComponents = Calendar.current.dateComponents([.month, .day], from: result.date)
        XCTAssertEqual(dateComponents.month, 4)
        XCTAssertEqual(dateComponents.day, 1)
        
    }
    
    
    func testNoSpaceBetweenNumberAndWord() {
        
        guard let result = NumericsParser.parse(expression: "20apples sold on 1st April") else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(result.number, 20.0)
        let dateComponents = Calendar.current.dateComponents([.month, .day], from: result.date)
        XCTAssertEqual(dateComponents.month, 4)
        XCTAssertEqual(dateComponents.day, 1)
        
    }

    
    
    func testAQuantityOfApplesThatLooksLikeAYear() {
        
        guard let result = NumericsParser.parse(expression: "1970 apples sold on 1st April") else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(result.number, 1970)
        let dateComponents = Calendar.current.dateComponents([.month, .day], from: result.date)
        XCTAssertEqual(dateComponents.month, 4)
        XCTAssertEqual(dateComponents.day, 1)
        
    }
    
    
    func testAQuantityOfApplesXDaysAgo() {
        
        guard let result = NumericsParser.parse(expression: "30 apples sold 9 days ago") else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(result.number, 30)
        
    }

 

}
