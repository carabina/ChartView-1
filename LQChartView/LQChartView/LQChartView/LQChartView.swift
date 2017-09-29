//
//  LQChartView.swift
//  LQChartView
//
//  Created by liuqing on 2017/9/21.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

protocol LQChartViewDataSource : NSObjectProtocol {
    ///y轴数据 业绩
    func chatViewConfigYValue(_ chartView : LQChartView) -> Array<Float>
    ///x轴数据 日期
    func chatViewConfigXValue(_ chartView : LQChartView) -> Array<String>
}

///全局变量 竖线距离屏幕两边的宽度
let chartLineStartX : CGFloat = 20.0
///横线距离顶部的 长度
let chartLineStartY : CGFloat = 44.0

class LQChartView: UIView {
    ///直线点是否为曲线
    var curve : Bool = false
    ///代理
    private weak var dataSource : LQChartViewDataSource?
    ///初始化方法
    init(frame : CGRect, dataSource : LQChartViewDataSource) {
        super.init(frame: frame)
        self.dataSource = dataSource
        backgroundColor = UIColor(red: 255.0/255.0, green: 79.0/255.0, blue: 38.0/255.0, alpha: 1.0)
    }
    //将图表添加到视图
    func showInView(_ view : UIView){
        startDraw()
        view.addSubview(self)
    }
    ///开始绘制
    private func startDraw(){
        ///如果x轴和y轴没有值 则返回不进行下一步操作
        guard let yArray = dataSource?.chatViewConfigYValue(self), let xArray = dataSource?.chatViewConfigXValue(self) else{
            return
        }
        chartLine.frame = bounds
        addSubview(chartLine)
        ///设置数据源
        chartLine.xValues = xArray
        chartLine.yValues = yArray
        
        chartLine.curve = curve
        ///开始绘图
        chartLine.startDrawLines()
    }
    //MARK: - 懒加载
    private lazy var chartLine = LQChartLine()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
