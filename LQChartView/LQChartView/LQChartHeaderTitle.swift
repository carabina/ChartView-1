//
//  LQChartHeaderTitle.swift
//  LQChartView
//
//  Created by liuqing on 2017/9/22.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class LQChartHeaderTitle: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViewAndLayout()
    }
    
    //MARK: - 外部控制方法
    func changeTitleLabelText(dateString: String ,saleCount: String) {
        let weekString = dateString.weekDayFrom()
        
        let textString = String(dateString.suffix(5)) + weekString + "销售额:" + "￥" + saleCount
        
        let attribute = NSMutableAttributedString(string: textString)
        
        attribute.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.init(white: 1.0, alpha: 0.4)], range: NSMakeRange((textString as NSString).length - 2, 2))
        attribute.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.init(white: 1.0, alpha: 1.0)], range: NSMakeRange(0, (textString as NSString).length - 2))
        
        titleLabel.attributedText = attribute
        
        titleLabel.sizeToFit()
    }
    
    //MARK: - 内部控制方法
    ///添加子控件
    private func addSubViewAndLayout(){
        addSubview(forwardDay)
        addSubview(titleLabel)
        addSubview(afterDay)
    }
    
    ///布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        forwardDay.frame = CGRect(x: 0, y: 0, width: 64, height: frame.size.height)
        titleLabel.center = center
        afterDay.frame = CGRect(x: frame.maxX - 64, y: 0 , width: 64, height: frame.size.height)
    }
    
    //MARK: - 懒加载
    lazy var forwardDay : UIButton = {
       let btn = UIButton(type: .custom)
        btn.setTitle("前1天", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitleColor(UIColor.init(white: 1.0, alpha: 0.4), for: .disabled)
        btn.backgroundColor = UIColor.green
        btn.tag = 1
        return btn
    }()
    
    lazy var afterDay : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("后1天", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitleColor(UIColor.init(white: 1.0, alpha: 0.4), for: .disabled)
        btn.backgroundColor = UIColor.green
        btn.tag = 2
        return btn
    }()
    
    private lazy var titleLabel : UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
