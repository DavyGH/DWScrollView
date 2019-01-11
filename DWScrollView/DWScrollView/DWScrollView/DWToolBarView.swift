//
//  DWToolBarView.swift
//  DWScrollView
//
//  Created by Crazy Davy on 2019/1/10.
//  Copyright © 2019 Crazy Davy. All rights reserved.
//

import UIKit

protocol DWToolBarProtocol {
    func dw_ToolBarView(didSelectItemAt index:Int) /// 点击事件
}

class DWToolBarView: UIView {
    var flowLayout: UICollectionViewFlowLayout?
    var collectionView: UICollectionView?
    var dwFlowLayout = DWScrollViewFlowLayout()
    var delegate: DWToolBarProtocol?
    var bottomLine: UIView?
    var titles = [String]()
    var currentIndex = 0

    init(frame: CGRect ,titles:[String]? ,flowLayout:DWScrollViewFlowLayout?) {
        super.init(frame: frame)
        self.titles = titles!
        if flowLayout != nil {
            self.dwFlowLayout = flowLayout!
        }
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = dwFlowLayout.toolBarBackgroundColor
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout?.scrollDirection = .horizontal
        flowLayout?.minimumInteritemSpacing = 0
        flowLayout?.minimumLineSpacing = 0
        flowLayout?.itemSize = CGSize(width: bounds.width/CGFloat(titles.count), height: bounds.height)
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout!)
        collectionView?.register(DWToolBarCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.backgroundColor = dwFlowLayout.toolBarBackgroundColor
        collectionView?.dataSource = self
        collectionView?.delegate = self
        addSubview(collectionView!)
        
        bottomLine = UIView(frame: CGRect(x: ((bounds.width)/CGFloat(titles.count) - dwFlowLayout.toolBarBottomLineWidth)/2, y: bounds.height - dwFlowLayout.toolBarBottomLineHeight, width: dwFlowLayout.toolBarBottomLineWidth, height: dwFlowLayout.toolBarBottomLineHeight))
        bottomLine?.backgroundColor = dwFlowLayout.toolBarBottomLineColor
        bottomLine?.layer.cornerRadius = dwFlowLayout.toolBarBottomLineCornerRadius
        bottomLine?.layer.masksToBounds = true
        addSubview(bottomLine!)
    }
}

extension DWToolBarView: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DWToolBarCollectionViewCell
        cell.contentView.backgroundColor = dwFlowLayout.toolBarBackgroundColor
        if indexPath.row == currentIndex {
            cell.titleLab?.textColor = dwFlowLayout.toolBarTitleSelectColor
            cell.titleLab?.font = dwFlowLayout.toolBarTitleSelectFont
        }else{
            cell.titleLab?.textColor = dwFlowLayout.toolBarTitleColor
            cell.titleLab?.font = dwFlowLayout.toolBarTitleFont
        }
        cell.titleLab?.text = titles[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.dw_ToolBarView(didSelectItemAt: indexPath.row)
        currentIndex = indexPath.row
        collectionView.reloadData()
    }
}

class DWToolBarCollectionViewCell: UICollectionViewCell {
    var titleLab: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        titleLab = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        titleLab?.textAlignment = .center
        contentView.addSubview(titleLab!)
    }
}
