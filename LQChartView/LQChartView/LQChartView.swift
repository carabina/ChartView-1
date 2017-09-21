//
//  LQChartView.swift
//  LQChartView
//
//  Created by liuqing on 2017/9/21.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

protocol LQChartViewDataSource : NSObjectProtocol {
    ///y轴数据
    func chatViewConfigYValue(_ chartView : LQChartView) -> Array<String>
    ///x轴数据
    func chatViewConfigXValue(_ chartView : LQChartView) -> Array<String>
}

///全局变量 竖线距离屏幕的距离
let chartLineStartX :CGFloat = 20

class LQChartView: UIView {

    ///代理
    weak var dataSource : LQChartViewDataSource?
    ///初始化方法
    init(frame : CGRect, dataSource : LQChartViewDataSource) {
        super.init(frame: frame)
        self.dataSource = dataSource
        
    }
    
    func showInView(_ view : UIView){
        startDraw()
        view.addSubview(self)
    }
    
    ///开始绘制
    private func startDraw(){
        chartLine.frame = frame
        addSubview(chartLine)
        
        guard let yArray = dataSource?.chatViewConfigYValue(self), let xArray = dataSource?.chatViewConfigXValue(self) else{
            return
        }
        chartLine.xValues = xArray
        chartLine.yValues = yArray
        chartLine.startDrawLines()
    }
    
    //MARK: - 懒加载
    
    private lazy var chartLine = LQChartLine()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
