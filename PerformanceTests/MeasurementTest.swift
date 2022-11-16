//
//  PerfomanceTest.swift
//  PerformanceTests
//
//  Created by Tony Dэ on 15.11.2022.
//

import XCTest

/// abstract superclass
class MeasurementTest: XCTestCase {
    
    //let metrics: [XCTMetric] = [XCTClockMetric()]
    let metrics: [XCTMetric] = [XCTClockMetric(), XCTCPUMetric(), XCTMemoryMetric()]
    let options: XCTMeasureOptions = XCTMeasureOptions()
    
    override func setUp() {
        options.iterationCount = 10
    }
    
    func measurePerformance(block: () -> Void) {
        measure(metrics: metrics, options: options) {
            block()
        }
    }

}
