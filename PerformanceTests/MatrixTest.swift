//
//  MatrixTest.swift
//  PerformanceTests
//
//  Created by Tony Dэ on 21.12.2022.
//

import XCTest

final class MatrixTest: MeasurementTest {
    
    let count = 5_000
        
    func testClassMatrix() throws {
        let matrix = ClassMatrix(count: count)
        measurePerformance {
            iterateMatrix(count: count) { x, y in
                matrix.increment(x: x, y: y)
            }
        }
    }
    
    func testStructMatrix() throws {
        var matrix = StructMatrix(count: count)
        measurePerformance {
            iterateMatrix(count: count) { x, y in
                matrix.increment(x: x, y: y)
            }
        }
    }
        
}

fileprivate func iterateMatrix(count: Int, block: (_ x: Int, _ y: Int) -> Void) {
    for x in 0..<count {
        for y in 0..<count {
            block(x, y)
        }
    }
}

fileprivate struct StructMatrix {
    private var values: [[Int]]
    
    init(count: Int) {
        values = Array.init(repeating: Array(repeating: 0, count: count), count: count)
    }
    
    mutating func increment(x: Int, y: Int) {
        if values.indices.contains(x) && values.indices.contains(y) {
            values[x][y] = values[x][y] + 1
        }
    }
}

fileprivate final class ClassMatrix {
    private var values: [[Int]]
    
    init(count: Int) {
        values = Array.init(repeating: Array(repeating: 0, count: count), count: count)
    }
    
    func increment(x: Int, y: Int) {
        if values.indices.contains(x) && values.indices.contains(y) {
            values[x][y] = values[x][y] + 1
        }
    }
}
