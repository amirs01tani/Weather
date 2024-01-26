//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Amir on 1/22/24.
//

import XCTest
import Weather

final class WeatherTests: XCTestCase {

    func test_drawSin_returnsMinusOneForMinus90() {
        let sut = Drawer()
        let startAngle: Double = -Double.pi/2
        let endAngle: Double = 3 * Double.pi/2
        
        let arcView = sut.draw(from: startAngle, to: endAngle)
        guard let x = arcView.first?.x else {
            XCTFail("x of the start point should has value but it is nil")
            return
        }
        XCTAssertEqual(Double(x), startAngle)
        XCTAssertEqual(arcView.last?.y.rounded(), -1)
        
    }
    
    func test_drawDashedSin_returnsTheFirstPointForMinus90() {
        let sut = Drawer()
        let startAngle: Double = -Double.pi/2
        let endAngle: Double = 3 * Double.pi/2
        let ignorePoints = 4
        let strides = 0.01
        
        let arcView = sut.drawDashed(from: startAngle, to: endAngle, strides: strides, ignorePoints: ignorePoints)
        
        
        guard let firstPoint = arcView.first?.x else {
            XCTFail("x of the start point should has value but it is nil")
            return }
        XCTAssertEqual(Double(firstPoint), startAngle)
        XCTAssertEqual(arcView.first?.y, sin(startAngle))
        
    }
    
    func test_drawDashedSin_returnsTheSecondPointForNextStride() {
        let sut = Drawer()
        let startAngle: Double = -Double.pi/2
        let endAngle: Double = 3 * Double.pi/2
        let ignorePoints = 4
        let strides = 0.01
        
        let arcView = sut.drawDashed(from: startAngle, to: endAngle, strides: strides, ignorePoints: ignorePoints)
        
        guard let x = arcView.dropFirst().first?.x else {
            XCTFail("x of the start point should has value but it is nil")
            return }
        XCTAssertEqual(Double(x), startAngle + strides)
        XCTAssertEqual(arcView.dropFirst().first?.y, sin(startAngle + strides))
        
    }
    
    func test_drawDashedSin_returnsTheFirstPointForTheNextVisibleLine() {
        let sut = Drawer()
        let startAngle: Double = -Double.pi/2
        let endAngle: Double = 3 * Double.pi/2
        let ignorePoints = 4
        let strides = 0.01
        
        let arcView = sut.drawDashed(from: startAngle, to: endAngle, strides: strides, ignorePoints: ignorePoints)
        
        let receivedX = arcView[ignorePoints].x
        let expectedX = startAngle + strides * Double(ignorePoints) * 2
        XCTAssertEqual(Double(receivedX), expectedX)
        XCTAssertEqual(arcView[ignorePoints].y, sin(expectedX))
        
    }

}
