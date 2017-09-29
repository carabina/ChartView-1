//
//  UIBezierPath+curve.swift
//  LQChartView
//
//  Created by liuqing on 2017/9/29.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

typealias CGPathApplierBlock = @convention(block) (CGPathElement) -> Void
extension CGPath {
   fileprivate func apply(body: CGPathApplierBlock) {
        self.apply(info: unsafeBitCast(body, to: UnsafeMutableRawPointer.self)) { (info, element) in
            let block2 = unsafeBitCast(info, to: CGPathApplierBlock.self)
            block2(element.pointee)
        }
    }
}

extension UIBezierPath {
    
   fileprivate func pointsFromBezierPath() -> [CGPoint]
    {
        var bezierPoints = [CGPoint]()
        
        cgPath.apply(body: { (element: CGPathElement) in
            
            let numberOfPoints: Int = {
                switch element.type {
                case .moveToPoint, .addLineToPoint: // contains 1 point
                    return 1
                case .addQuadCurveToPoint: // contains 2 points
                    return 2
                case .addCurveToPoint: // contains 3 points
                    return 3
                case .closeSubpath:
                    return 0
                }
            }()
            for index in 0..<numberOfPoints {
                let point = element.points[index]
                bezierPoints.append(point)
            }
        })
        return bezierPoints
    }
    
    ///画曲线
    func smoothedPathWithGranularity(_ granularity: NSInteger) -> UIBezierPath{
        var granularity = granularity
        if granularity < 20 {
            granularity = 20
        }
        var points = pointsFromBezierPath()
        
        if points.count < 4 {
            return self.copy() as! UIBezierPath
        }
        
        points.insert(points.first!, at: 0)
        points.append(points.last!)
        
        let smoothedPath = self.copy() as! UIBezierPath
        smoothedPath.removeAllPoints()
        smoothedPath.move(to: points.first!)
        
        for index in 1..<points.count - 2{
            let p0 = points[index - 1]
            let p1 = points[index]
            let p2 = points[index + 1]
            let p3 = points[index + 2]
            for i in 1..<granularity{
                let t = CGFloat(i) * (1.0 / CGFloat(granularity))
                let tt = t * t
                let ttt = tt * t
                var pi : CGPoint = .zero
                
                let pointX1 = 2 * p1.x + (p2.x - p0.x) * t
                let pointX2 = (2 * p0.x - 5 * p1.x + 4 * p2.x - p3.x) * tt
                let pointX3 = (3 * p1.x - p0.x - 3 * p2.x + p3.x) * ttt
                pi.x = (pointX1 + pointX2 + pointX3) * 0.5
                
                let pointY1 = 2 * p1.y + (p2.y - p0.y) * t
                let pointY2 = (2 * p0.y - 5 * p1.y + 4 * p2.y - p3.y) * tt
                let pointY3 = (3 * p1.y - p0.y - 3 * p2.y + p3.y) * ttt
                pi.y = (pointY1 + pointY2 + pointY3) * 0.5
                smoothedPath.addLine(to: pi)
                print(pi)
            }
            smoothedPath.addLine(to: p2)
        }
        smoothedPath.addLine(to: points[points.count - 1])
        return smoothedPath
    }
    
}
