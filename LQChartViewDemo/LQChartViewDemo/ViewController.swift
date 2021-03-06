//
//  ViewController.swift
//  LQChartView
//
//  Created by liuqing on 2017/9/21.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    
    private func initData(){
        let fomatter = DateFormatter()
        fomatter.dateFormat = "YYYY-MM-dd"
        fomatter.locale = Locale(identifier: "en")
        for i in (0..<7).reversed(){
          xValues.append(fomatter.string(from:Date(timeIntervalSinceNow:(-24*60*60*Double(i)))))
            yValues.append(Float(arc4random()%200))
        }
        print(yValues)
        addSubViewsLayout()
    }
    
    private func addSubViewsLayout(){
        let chart = LQChartView(frame: CGRect(x: 0, y: 64, width:UIScreen.main.bounds.width , height: UIScreen.main.bounds.height * 0.5), dataSource: self)
        chart.curve = true
        chart.showInView(view)
    }

    lazy var xValues = Array<String>()
    lazy var yValues = Array<Float>()

}

extension ViewController: LQChartViewDataSource{
    
    func chatViewConfigXValue(_ chartView: LQChartView) -> Array<String> {
        return xValues
    }
    
    func chatViewConfigYValue(_ chartView: LQChartView) -> Array<Float> {
        return yValues
    }
    
}
