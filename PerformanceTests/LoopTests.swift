//
//  LoopTests.swift
//  PerformanceTests
//
//  Created by Tony Dэ on 15.11.2022.
//

import XCTest

class LoopTests: XCTestCase {
    
    let array = Array(repeating: 1, count: 1_000_000)
    
    func testReduce() throws {
        var sum = 0
        measure(metrics: [XCTCPUMetric()]) {
            sum = array.reduce(0, +)
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testForEach() throws {
        var sum = 0
        measure(metrics: [XCTCPUMetric()]) {
            sum = 0
            array.forEach { value in
                sum += value
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testFor() throws {
        var sum = 0
        measure(metrics: [XCTCPUMetric()]) {
            sum = 0
            for value in array {
                sum += value
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testForTupleIndex() throws {
        var sum = 0
        measure(metrics: [XCTCPUMetric()]) {
            sum = 0
            for (index, _) in array.enumerated() {
                sum += array[index]
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testForTupleValue() throws {
        var sum = 0
        measure(metrics: [XCTCPUMetric()]) {
            sum = 0
            for (_, value) in array.enumerated() {
                sum += value
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testIterating() {
        var sum = 0
        measure(metrics: [XCTCPUMetric()]) {
            sum = 0
            var generator = array.makeIterator()
            var value: Int?
            
            repeat {
                value = generator.next()
                if let number = value {
                    sum += number
                }
            } while value != nil
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testWhile() throws {
        var sum = 0
        measure(metrics: [XCTCPUMetric()]) {
            sum = 0
            var i = 0
            while i != array.count {
                sum += array[i]
                i += 1
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testRepeat() throws {
        var sum = 0
        measure(metrics: [XCTCPUMetric()]) {
            sum = 0
            var i = 0
            repeat {
                sum += array[i]
                i += 1
            } while i < array.count
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testLoop() throws {
        var sum = 0
        measure(metrics: [XCTCPUMetric()]) {
            sum = 0
            loop(count: array.count) { index in
                sum += array[index]
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func loop(count: Int, block: (_ index: Int) -> Void) {
        var index = 0
        while index < count {
            block(index)
            index += 1
        }
    }
    
//    func testRecursion() throws {
//        measure(metrics: [XCTCPUMetric()]) {
//            var sum = 0
//            sum = recurseSum(index: 0, array: array)
//            print("recurse sum = " + String(sum))
//        }
//    }
//
//    func recurseSum(index: Int, array: [Int]) -> Int {
//        if index == array.count {
//            return 0
//        } else {
//            return array[index] + recurseSum(index: index + 1, array: array)
//        }
//    }
    
}
