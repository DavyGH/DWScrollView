//
//  DWScrollViewFlowLayout.swift
//  DWScrollView
//
//  Created by Crazy Davy on 2019/1/11.
//  Copyright © 2019 Crazy Davy. All rights reserved.
//

import UIKit

class DWScrollViewFlowLayout: NSObject {
    
    /// 栏高
    var tooBarHeight = CGFloat(50)
    
    /// 背景颜色
    var toolBarBackgroundColor = UIColor.white
    
    /// 标题颜色
    var toolBarTitleColor = UIColor.lightGray
    
    /// 标题选中颜色
    var toolBarTitleSelectColor = UIColor.red
    
    /// 标题字体大小
    var toolBarTitleFont = UIFont.systemFont(ofSize: 17)
    
    /// 底部线颜色
    var toolBarBottomLineColor = UIColor.red
    
    /// 底部线宽
    var toolBarBottomLineWidth = CGFloat(50)
    
    /// 底部线高
    var toolBarBottomLineHeight = CGFloat(1)
    
    /// 底部线圆角
    var toolBarBottomLineCornerRadius = CGFloat(0)
}
