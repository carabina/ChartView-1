# LQChartView
>这是我第二份工作的第一个任务,做一个图表展示店员的业绩;
当初是用OC实现的,现在我用swift去实现.主要是想留下一点东西顺便回忆一下...

![image](https://github.com/liuqing520it/ChartView/raw/master/others/demo.gif)
![image](https://github.com/liuqing520it/ChartView/raw/master/others/chart.gif)

### 如何使用

#### 导入工程

1. 初始化
```
let chart = LQChartView(frame: CGRect(x: 0, y: 64, width:UIScreen.main.bounds.width , height: UIScreen.main.bounds.height * 0.5), dataSource: self)
chart.showInView(view)
```
2. 实现代理方法返回 x轴及y轴对应的数据
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

