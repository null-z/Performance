//
//  LoopTests.swift
//  PerformanceTests
//
//  Created by Tony Dэ on 15.11.2022.
//

import XCTest

class LoopTest: MeasurementTest {
    
    let array = Array(repeating: 1, count: 10_000_000)
    
    func testReduce() throws {
        var sum = 0
        measurePerformance {
            sum = array.reduce(0, +)
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testForEach() throws {
        var sum = 0
        measurePerformance {
            sum = 0
            array.forEach { value in
                sum += value
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testFor() throws {
        var sum = 0
        measurePerformance {
            sum = 0
            for value in array {
                sum += value
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testForTupleIndex() throws {
        var sum = 0
        measurePerformance {
            sum = 0
            for (index, _) in array.enumerated() {
                sum += array[index]
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testForTupleValue() throws {
        var sum = 0
        measurePerformance {
            sum = 0
            for (_, value) in array.enumerated() {
                sum += value
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testIterating() {
        var sum = 0
        measurePerformance {
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
        measurePerformance {
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
        measurePerformance {
            sum = 0
            var i = 0
            repeat {
                sum += array[i]
                i += 1
            } while i < array.count
        }
        XCTAssertEqual(sum, array.count)
    }
    
    func testRecursion() throws {
        #if TEST && UNOPTIMIZED
        throw XCTSkip("Does't optimize tail recursion")
        #else
        var sum = 0
        measurePerformance {
            sum = recurseSum(array: array)
        }
        XCTAssertEqual(sum, array.count)
        #endif
    }
    
    func testLoop() throws {
        var sum = 0
        measurePerformance {
            sum = 0
            loop(count: array.count) { index in
                sum += array[index]
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
    
    func testLoopLICMoptimized() throws {
        var sum = 0
        measurePerformance {
            sum = 0
            loop(count: array.count) { index in
                sum += 1
            }
        }
        XCTAssertEqual(sum, array.count)
    }
    
}


fileprivate func loop(count: Int, block: (_ index: Int) -> Void) {
    var index = 0
    while index < count {
        block(index)
        index += 1
    }
}

fileprivate func recurseSum(array: [Int]) -> Int {
    func tailRecurseSum(index: Int, array: [Int], result: Int) -> Int {
        if index == array.count {
            return result
        } else {
            let result = result + array[index]
            return tailRecurseSum(index: index + 1, array: array, result: result)
        }
    }
    
    return tailRecurseSum(index: 0, array: array, result: 0)
}
