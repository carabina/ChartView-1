Pod::Spec.new do |s|
s.name     = 'LQChartView'
s.version  = '1.1.0'
s.platform = :ios, '9.0'
s.license  = 'MIT'
s.summary  = 'show performance chart view'
s.homepage = 'https://github.com/liuqing520it/ChartView'
s.author   = { "liuqing520it" => "330663384@qq.com" }
s.source   = { :git => 'https://github.com/liuqing520it/ChartView.git', :tag => s.version }

s.description = '一款简单的图表视图折线图或曲线图,每条竖线都可点击切换每天的数据,用来展示店员业绩;'
s.source_files = 'ChartView/*.{swift}'
s.requires_arc = true
end
