//
//  OverflowArithmeticsTest.swift
//  PerformanceTests
//
//  Created by Tony Dэ on 15.11.2022.
//

import XCTest

class OverflowArithmeticsTest: MeasurementTest {
    
    let number: Int64 = 2
    let count: Int64 = 100_000_000
    
    func testAddition() throws {
        var result: Int64 = 0
        measurePerformance {
            for _ in 1...count {
                result = result + number
            }
        }
    }
    
    func testAdditionOverflow() throws {
        var result: Int64 = 0
        measurePerformance {
            for _ in 1...count {
                result = result &+ number
            }
        }
    }
    
    func testSubtraction() throws {
        var result: Int64 = 0
        measurePerformance {
            for _ in 1...count {
                result = result - number
            }
        }
    }
    
    func testSubtractionOverflow() throws {
        var result: Int64 = 0
        measurePerformance {
            for _ in 1...count {
                result = result &- number
            }
        }
    }

    func testMultiplication() throws {
        var result: Int64 = 0
        measurePerformance {
            for _ in 1...count {
                result = result * number
            }
        }
    }
    
    func testMultiplicationOverflow() throws {
        var result: Int64 = 0
        measurePerformance {
            for _ in 1...count {
                result = result &* number
            }
        }
    }
    
}
