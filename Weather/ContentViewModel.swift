//
//  ContentViewModel.swift
//  Weather
//
//  Created by Amir on 1/23/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    let startAngle = -Double.pi/2
    let endAngle = 3 * Double.pi/2
    let xOffset: CGFloat = 2
    let yOffset: CGFloat = 2
    let xMultiplier: CGFloat = 50
    let yMultiplier: CGFloat = 50
    let ignorePointCountsInDashMode = 4
    
    @Published var dashPoints = [CGPoint]()
    @Published var arcPoints = [CGPoint]()
    var timer: Timer?
    
    init() {
        dashPoints = Drawer().drawDashed(from: startAngle, to: endAngle, ignorePoints: ignorePointCountsInDashMode).map { CGPoint(x: ($0.x + xOffset)*xMultiplier, y: (-$0.y + yOffset)*yMultiplier) }
    }
    
    func startAnimating(percent: CGFloat) {
        guard timer == nil else { return }
        self.arcPoints.removeAll()
        let allPoints = Drawer().draw(from: startAngle, to: endAngle).map { CGPoint(x: ($0.x + xOffset)*xMultiplier, y: (-$0.y + yOffset)*yMultiplier) }
        let endLimit = Int(CGFloat(allPoints.count) * percent)
        setupTimer(points: allPoints, endLimit: endLimit)
        
    }
    
    func setupTimer(points: [CGPoint], endLimit: Int) {
        var iteration = 0
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){ [weak self] timer in
            guard iteration < endLimit else {
                timer.invalidate()
                self?.timer = nil
                return
            }
            self?.arcPoints.append(points[iteration])
            iteration += 1
        }
        self.timer?.fire()
    }
}
