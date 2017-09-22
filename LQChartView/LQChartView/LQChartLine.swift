//
//  LQChartLine.swift
//  LQChartView
//
//  Created by liuqing on 2017/9/21.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

///y轴默认分5等份
private let kYEqualPaths: Int = 5

class LQChartLine: UIView {
    ///x轴数据
    var xValues = Array<String>(){
        didSet{
            
        chartLineTheXAxisSpan = (UIScreen.main.bounds.width - chartLineStartX * 2.0) / CGFloat(xValues.count - 1)
        chartLineTheYAxisSpan = (frame.size.height - chartLineStartY * 2.0) / CGFloat(kYEqualPaths)
        drawVertical()
        }
    }
  
    ///y轴数据
    var yValues = Array<String>(){
        didSet{
            drawHorizontal()
        }
    }
    ///每根竖线之间的距离
    var chartLineTheXAxisSpan : CGFloat = 0
    ///每根横线之间的距离
    var chartLineTheYAxisSpan : CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    //MARK: - 内部控制方法
    /// 画横线
    private func drawHorizontal(){
        let path = UIBezierPath()
        let slayer = CAShapeLayer()
        
        //计算横线 结束点 x的坐标
        let pointX = chartLineStartX * 2.0 + CGFloat(xValues.count - 1) * chartLineTheXAxisSpan
        
        for i in 0...kYEqualPaths{
            //这里只显示 第一根和最后一根
//            if i == 0 || i == kYEqualPaths {
            
                path.move(to: CGPoint(x: 0, y: chartLineTheYAxisSpan * CGFloat(i) + chartLineStartY))
                path.addLine(to: CGPoint(x: pointX, y: chartLineTheYAxisSpan * CGFloat(i) + chartLineStartY))
                path.close()
                slayer.path = path.cgPath
                slayer.strokeColor = UIColor(red: 255.0 / 255.0, green: 125.0/255.0, blue: 95.0/255.0, alpha: 1.0).cgColor
                slayer.fillColor = UIColor.white.cgColor
                slayer.lineWidth = 0.5
                layer.addSublayer(slayer)
//            }
        }
    }
    
    ///画竖线
    private func drawVertical(){
        let path = UIBezierPath()
        let slayer = CAShapeLayer()
        
        //计算 竖线结束点的 y坐标
        let pointY = chartLineTheYAxisSpan * CGFloat(kYEqualPaths) + chartLineStartY
        
        for i in 0..<xValues.count{
                path.move(to: CGPoint(x: chartLineStartX + chartLineTheXAxisSpan * CGFloat(i), y: chartLineStartY))
                path.addLine(to: CGPoint(x: chartLineStartX + chartLineTheXAxisSpan * CGFloat(i), y: pointY))
                path.close()
                slayer.path = path.cgPath
                slayer.strokeColor = UIColor(red: 255.0 / 255.0, green: 125.0/255.0, blue: 79.0/255.0, alpha: 1.0).cgColor
                slayer.fillColor = UIColor(red: 255.0 / 255.0, green: 125.0/255.0, blue: 79.0/255.0, alpha: 1.0).cgColor
                slayer.lineWidth = 0.5
                layer.addSublayer(slayer)
        }
    }
    
    ///添加移动小圆点
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
        btn.center = CGPoint(x: point.x, y: chartLineTheYAxisSpan * CGFloat(kYEqualPaths) * 0.5 + chartLineStartY)
        btn.tag = index
        btn.addTarget(self, action: #selector(circleButtonClick(btn:)), for: .touchUpInside)
        addSubview(btn)
    }
    
    ///添加x轴 文字
    private func addXLabel(point : CGPoint, index : NSInteger){
        //项目中只展示头尾视图
        if index == 0 || index == xValues.count - 1{
            let xLabel = UILabel()
            xLabel.textColor = UIColor.white
            xLabel.font = UIFont.systemFont(ofSize: 12)
            xLabel.textAlignment = NSTextAlignment.center
            let str = xValues[index].suffix(5)
            xLabel.text = String(str)
            xLabel.sizeToFit()
            xLabel.center = CGPoint(x: point.x, y: chartLineTheYAxisSpan * CGFloat(kYEqualPaths) + 10 + chartLineStartY)
            addSubview(xLabel)
        }
    }
    
    ///开始绘制图表
    func startDrawLines(){
        //x轴方向 点坐标
        for i in 0..<xValues.count{
            pointXArray.append(chartLineStartX + chartLineTheXAxisSpan * CGFloat(i))
        }
        //y轴方向 点坐标
        //取出y轴里最大的那个数
        let maxValue = (yValues.max()! as NSString).floatValue
        //取出y轴方向总大小
        let yHeight = chartLineTheYAxisSpan * CGFloat(kYEqualPaths)
        for i in 0..<yValues.count{
            //计算y轴方向坐标点
            pointYArray.append(CGFloat((yValues[i] as NSString).floatValue) * 0.95 /  CGFloat(maxValue) * yHeight + chartLineStartY)
        }
        
        for i in 0..<pointXArray.count{
            let point = CGPoint(x: pointXArray[i], y: pointYArray[i])
            points.append(point)
        }
        
        print(points)
        
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
            let point = points[i]
            if i == 0{
                bezierLine.move(to: point)
            }
            else{
                bezierLine.addLine(to: point)
            }
            addCircle(point: point, index: i)
            addXLabel(point: point, index: i)
        }
        ///设置图层
        shapeLayer.path = bezierLine.cgPath
        
        let pathAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        pathAnimation.duration = Double(points.count) * 0.5
        pathAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.autoreverses = false
        shapeLayer.add(pathAnimation, forKey: "strokeEndAnimation")
        
        shapeLayer.strokeEnd = 1.0
        
        ///添加移动小圆点
        moveButton.center = points.last!
        addSubview(moveButton)
        //添加titleView
        addSubview(titleView)
        //titleView 添加点击事件
        titleView.forwardDay.addTarget(self, action: #selector(forwardDayClick(btn:)), for: .touchUpInside)
        titleView.afterDay.addTarget(self, action: #selector(afterDayClick(btn:)), for: .touchUpInside)
    }
    
    private func calculateCirclePointX() -> Int{
        return Int((moveButton.center.x - chartLineStartX) / chartLineTheXAxisSpan)
    }
    
    //MARK: - 点击事件
    @objc private func forwardDayClick(btn : UIButton){
        
        let move = calculateCirclePointX()
        print(move)
        UIView.animate(withDuration: 0.25) {
            if move > 1{
                self.moveButton.center = self.points[move - 1]
            }
            else if move == 1{
                self.moveButton.center = self.points[move - 1]
                self.titleView.forwardDay.isEnabled = false
            }
        }
        
        let saleCount = (yValues[move] as NSString).floatValue        
        
        titleView.changeTitleLabelText(dateString:xValues[move] , saleCount: String(format: "%0.2f",saleCount))
        
    }
    
    @objc private func afterDayClick(btn : UIButton){
        
    }
    
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
    ///移动的小圆点
    private lazy var moveButton : UIButton = {
       let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor.init(white: 1.0, alpha: 0.7)
        btn.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        return btn
    }()
    ///顶部titleView
    private lazy var titleView = LQChartHeaderTitle(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: chartLineStartY))
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
