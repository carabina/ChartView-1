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
        for i in 0..<7{
          xValues.append(fomatter.string(from:Date(timeIntervalSinceNow:(24*60*60*Double(i)))))
          yValue.append(String(arc4random_uniform(1000)))
        }
        print(xValues)
        
        addSubViewsLayout()
    }
    
    private func addSubViewsLayout(){
        let chart = LQChartView(frame: CGRect(x: 0, y: 64, width:UIScreen.main.bounds.width , height: UIScreen.main.bounds.height * 0.5), dataSource: self)
        chart.showInView(view)
    }
    
    lazy var xValues = Array<String>()
    lazy var yValue = Array<String>()
    
}

extension ViewController: LQChartViewDataSource{
    func chatViewConfigXValue(_ chartView: LQChartView) -> Array<String> {
        return xValues
    }
    
    func chatViewConfigYValue(_ chartView: LQChartView) -> Array<String> {
        return yValue
    }
    
}
































