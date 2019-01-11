# DWScrollView
滑动、点击切换控制器

使用方法

override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = UIColor.white
        title = "滚动切换控制器"
        
        var array = [UIViewController]()
        var titles = [String]()
        for i in 0..<4 {
            let vc = VC()
            array.append(vc)
            titles.append("标题\(i)")
        }
        
        let flowLayout = DWScrollViewFlowLayout()
        flowLayout.toolBarBottomLineHeight = 4
        flowLayout.toolBarBottomLineWidth = 60
        flowLayout.toolBarTitleFont = UIFont.systemFont(ofSize: 15)
        flowLayout.toolBarTitleSelectColor = UIColor.blue
        flowLayout.toolBarBottomLineColor = UIColor.green
        flowLayout.toolBarBackgroundColor = UIColor.red
        flowLayout.toolBarBottomLineCornerRadius = 2
        
        let scrollView = DWScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), superViewController: self, viewControllers: array, titles: titles, flowLayout: flowLayout)
        scrollView.delegate = self
        view.addSubview(scrollView)
    }
    
    DWScrollViewDelegate 点击事件回调
    
    func dw_ScrollView(didSelectItemAt index: Int) {
        print(index)
    }
