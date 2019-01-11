//
//  DWScrollView.swift
//  DWScrollView
//
//  Created by Crazy Davy on 2019/1/11.
//  Copyright © 2019 Crazy Davy. All rights reserved.
//

import UIKit

protocol DWScrollViewDelegate {
    func dw_ScrollView(didSelectItemAt index:Int) /// 点击事件
}

class DWScrollView: UIView {
    var superViewController: UIViewController?
    var viewControllers = [UIViewController]()
    var flowLayout = DWScrollViewFlowLayout()
    var delegate: DWScrollViewDelegate?
    var toolBarView: DWToolBarView?
    var scrollView: UIScrollView?
    var titles = [String]()
    
    /// 重新刷新视图(这里处理视图frame变化错乱问题)
    func uploadView(frame:CGRect) {
        self.frame = frame
        self.toolBarView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: flowLayout.tooBarHeight)
        self.scrollView?.frame = CGRect(x: 0, y: flowLayout.tooBarHeight, width: frame.width, height: frame.height - flowLayout.tooBarHeight)
    }

    init(frame: CGRect ,superViewController:UIViewController ,viewControllers: [UIViewController] ,titles:[String] ,flowLayout: DWScrollViewFlowLayout?) {
        super.init(frame: frame)
        self.superViewController = superViewController
        self.viewControllers = viewControllers
        self.titles = titles
        if flowLayout != nil {
            self.flowLayout = flowLayout!
        }
        setupUI()
        getData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        getData()
    }
    
    private func setupUI() {
        toolBarView = DWToolBarView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: flowLayout.tooBarHeight), titles: titles, flowLayout: flowLayout)
        toolBarView?.delegate = self
        addSubview(toolBarView!)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: flowLayout.tooBarHeight, width: bounds.width, height: bounds.height - flowLayout.tooBarHeight))
        scrollView?.contentSize = CGSize(width: bounds.width*CGFloat(titles.count), height: bounds.height - flowLayout.tooBarHeight)
        scrollView?.backgroundColor = flowLayout.backgroundColor
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.isPagingEnabled = true
        scrollView?.delegate = self
        
        addSubview(scrollView!)
    }
    
    private func getData() {
        for vc in viewControllers {
            superViewController?.addChildViewController(vc)
        }
        
        scrollViewDidEndScrollingAnimation(scrollView!)
    }
}

extension DWScrollView: UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let index = Int(offsetX/bounds.width)
        let vc = superViewController?.childViewControllers[index]
        if vc?.isViewLoaded == false {
            vc?.view.frame = CGRect(x: offsetX, y: 0, width: bounds.width, height: bounds.height - flowLayout.tooBarHeight)
            scrollView.addSubview((vc?.view)!)
        }
        
        var frame = toolBarView?.bottomLine?.frame
        let W = bounds.width/CGFloat(titles.count)
        frame?.origin.x = (W - flowLayout.toolBarBottomLineWidth)/2 + W*CGFloat(index)
        
        UIView.animate(withDuration: 0.2) {
            self.toolBarView?.bottomLine?.frame = frame!
        }
        
        toolBarView?.currentIndex = index
        toolBarView?.collectionView?.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
}

extension DWScrollView: DWToolBarProtocol {
    func dw_ToolBarView(didSelectItemAt index: Int) {
        scrollView?.setContentOffset(CGPoint(x: bounds.width*CGFloat(index), y: 0), animated: true)
        delegate?.dw_ScrollView(didSelectItemAt: index)
    }
}
