//
//  ViewController.swift
//  DWScrollView
//
//  Created by Crazy Davy on 2019/1/10.
//  Copyright © 2019 Crazy Davy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
}

// MARK: DWScrollViewDelegate
extension ViewController: DWScrollViewDelegate {
    func dw_ScrollView(didSelectItemAt index: Int) {
        print(index)
    }
}

