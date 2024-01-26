//
//  SinDrawer.swift
//  Weather
//
//  Created by Amir on 1/23/24.
//

import Foundation

protocol SinDrawer {
    func draw(from startAngle: CGFloat, to endAngle: CGFloat, strides: CGFloat) -> [CGPoint]
    func drawDashed(from startAngle: CGFloat, to endAngle: CGFloat, strides: CGFloat, ignorePoints: Int) -> [CGPoint]
    
}

public class Drawer: SinDrawer {
    
    public init() {}
    
    public func draw(from startAngle: CGFloat, to endAngle: CGFloat, strides: CGFloat = 0.01) -> [CGPoint] {
        var sinDots = [CGPoint]()
        for i in stride(from: startAngle, through: endAngle, by: strides) {
            sinDots.append(CGPoint(x: i, y: sin(i)))
        }
        return sinDots
    }
    
    public func drawDashed(from startAngle: CGFloat, to endAngle: CGFloat, strides: CGFloat = 0.01, ignorePoints: Int) -> [CGPoint] {
        var sinDots = [CGPoint]()
        var itterator = 0
        for i in stride(from: startAngle, through: endAngle, by: strides) {
            let point = CGPoint(x: i, y: sin(i))
            if (itterator / ignorePoints) % 2 == 0 {
                sinDots.append(point)
            }
            itterator += 1
        }
        return sinDots
    }

}

