## LQChartView
>This is my first assignment for my second job, to make a chart showing the salesmen's performance;It was implemented with OC, and now I use swift to realize it. I mainly want to leave something to remember...

![image](https://github.com/liuqing520it/ChartView/raw/master/others/demo.gif)
![image](https://github.com/liuqing520it/ChartView/raw/master/others/chart.gif)

### Installation

CocoaPods

1. install CocoaPods
```
$ gem install cocoapods
```
2. config Podfile
```
pod 'LQChartView','~>1.1.1'
```
3. install ChartView
```
$ pod install
```
4. init ChartView
```
let chart = LQChartView(frame: CGRect(x: 0, y: 64, width:UIScreen.main.bounds.width , height: UIScreen.main.bounds.height * 0.5), dataSource: self)
chart.showInView(view)
```
5. 实现代理方法返回 x轴及y轴对应的数据
```
// 返回的数组里装的是日期字符串 :2017-9-24
func chatViewConfigXValue(_ chartView: LQChartView) -> Array<String> {
    return xValues
}
//返回y 坐标业绩数据
func chatViewConfigYValue(_ chartView: LQChartView) -> Array<Float> {
    return yValues
}
```

