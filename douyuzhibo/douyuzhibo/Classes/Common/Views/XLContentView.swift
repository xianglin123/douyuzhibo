//
//  XLContentView.swift
//  douyuzhibo
//
//  Created by xianglin on 16/10/5.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

protocol XLContentViewDelegate : class {
    func contentView(contentView : XLContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let kContentViewCell = "kContentViewCell"
class XLContentView: UIView {
    private var childVcs: [UIViewController]
    private var parentController: UIViewController?
    private var startOffsetX : CGFloat = 0
    weak var delegate: XLContentViewDelegate?
    private var isForbidDelegate : Bool = false
    
    //MARK: - 自定义构造函数,根据不同控制器初始化
    init(frame: CGRect , childVcs: [UIViewController] , parentController: UIViewController?) {
        self.childVcs = childVcs
        self.parentController = parentController
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 设置UI
    private func setupUI() {
        // 1.将所有的子控制器添加父控制器中
        for childVc in childVcs{
            parentController?.addChildViewController(childVc)
        }
        
        // 2.添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
    //MARK: - 懒加载控件
    private lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建布局,设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self!.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        
        //2.创建collectionView,设置
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.pagingEnabled = true
        
        //3.注册cell
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentViewCell)
        
        return collectionView
    }()
}

//MARK: - collectionView的数据源和代理方法
extension XLContentView : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kContentViewCell, forIndexPath: indexPath)
        
        // 2.给Cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        //3.添加控制器的view到cell
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        isForbidDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if isForbidDelegate { return }
        //定义属性
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        var scrollProgress: CGFloat = 0
        
        //2.判断左滑/右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if startOffsetX < currentOffsetX {//左滑
            //1.计算当前页的滚动进度
            scrollProgress = currentOffsetX % scrollViewW / scrollViewW
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            // 4.当前页完全划完
            if currentOffsetX - startOffsetX == scrollViewW {
                scrollProgress = 1
                targetIndex = sourceIndex
            }
        }else {//右滑
            //1.计算当前页的滚动进度
            scrollProgress = 1 - currentOffsetX % scrollViewW / scrollViewW
            //2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        //代理方法
        delegate?.contentView(self, progress: scrollProgress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

// MARK:- 对外暴露的方法
extension XLContentView {
    func setContentViewWithIndex(currentIndex : Int) {
        
        // 1.是否禁止执行代理方法
        isForbidDelegate = true
        
        // 2.滚动
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}