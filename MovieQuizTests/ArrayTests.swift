//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by Захар Панченко on 22.07.2024.
//

import Foundation
import XCTest
@testable import MovieQuiz

class ArrayTests: XCTestCase {
    func testGetValueInRange() throws {
        
        // Given
        let array = [1,1,2,3,5]
        
        // When
        let value = array[safe: 2]
        
        // Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 2)
    }
    
    func testGetValueOutOfRange() {
        
        // Given
        let array = [1,1,2,3,5]
        
        // When
        let value = array[safe: 2]
        
        // Then
        XCTAssertNil(value)
        
    }
}


/*extension Array {
    subscript(safe index: Index) -> Element? {
        indices ~= index ? self[index] : nil
    }
}*/
