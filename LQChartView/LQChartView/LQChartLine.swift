//
//  LQChartLine.swift
//  LQChartView
//
//  Created by liuqing on 2017/9/21.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

private let kYEqualPaths: Int = 5

class LQChartLine: UIView {

    ///x轴数据
    var xValues = Array<String>(){
        didSet{
            
        }
    }
  
    ///y轴数据
    var yValues = Array<String>(){
        didSet{
            
        }
    }
    ///每根竖线之间的距离
    var chartLineTheXAxisSpan : CGFloat = 0
    ///每根横线之间的距离
    var chartLineTheYAxisSpan : CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func addCircle(point : CGPoint , index : NSInteger){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 4))
        view.center = point
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        addSubview(view)
        
        let btn = UIButton(type: .custom)
        
        btn.frame = CGRect(x: 0, y: 0, width: 15, height: chartLineTheYAxisSpan * CGFloat(kYEqualPaths))
        btn.backgroundColor = UIColor.clear
        btn.center = CGPoint(x: point.x, y: chartLineTheYAxisSpan * CGFloat(kYEqualPaths) * 0.5)
        btn.tag = index
        btn.addTarget(self, action: #selector(circleButtonClick(btn:)), for: .touchUpInside)
        addSubview(btn)
        
    }
    
    ///开始绘制图表
    func startDrawLines(){
        for i in 0..<xValues.count{
            pointXArray.append(chartLineStartX + chartLineTheXAxisSpan * CGFloat(i))
        }
        
        for i in 0..<yValues.count{
            pointYArray.append(chartLineTheYAxisSpan * CGFloat(kYEqualPaths) - CGFloat((yValues[i] as NSString).floatValue) * 0.8 / chartLineTheYAxisSpan * CGFloat(kYEqualPaths))
        }
        
        for i in 0..<pointXArray.count{
            let point = CGPoint(x: pointXArray[i], y: pointYArray[i])
            points.append(point)
        }
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.speed = 2
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = UIColor.init(white: 1.0, alpha: 0.5).cgColor
        layer.addSublayer(shapeLayer)
        
        let bezierLine = UIBezierPath()
        
        for i in 0..<points.count{
            if i == 0{
                bezierLine.move(to: points[i])
            }
            else{
                bezierLine.addLine(to: points[i])
            }
        }
        
    }
    
    //MARK: - 点击事件
    
    @objc private func circleButtonClick(btn:UIButton){
        
        
        
    }
    
    //MARK: - 懒加载
    ///x轴数据数组
    private lazy var pointXArray = Array<CGFloat>()
    ///y轴数据数组
    private lazy var pointYArray = Array<CGFloat>()
    ///点 坐标
    private lazy var points = Array<CGPoint>()
    
    ///图层
    private lazy var shapeLayer = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
