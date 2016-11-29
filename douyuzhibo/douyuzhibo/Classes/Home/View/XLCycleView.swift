//
//  XLCycleView.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/29.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class XLCycleView: UIView {

    // 属性
    @IBOutlet weak var cycleConnectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    // 计时器
    var timer : Timer?
    
    // 数据源
    var cycleModels : [XLCycleModel]? {
        didSet{
            pageControl.numberOfPages = cycleModels?.count ?? 0
            // 添加定时器 并启动
            startTimer()
            scrollToNext()
            // 刷新数据
            cycleConnectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        // 注册cell
        cycleConnectionView.register(UINib(nibName:"XLCycleViewCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = cycleConnectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = cycleConnectionView.bounds.size
    }
    // 快速创建类方法
    class  func cycleView() -> XLCycleView{
        return Bundle.main.loadNibNamed("XLCycleView", owner: nil, options: nil)?.first as! XLCycleView
    }
    // 开启定时器
    func startTimer() {
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
    // 注销定时器
    func invalidTimer() {
        timer?.invalidate()
        timer = nil
    }
    // 定时滚动
    func scrollToNext() {
        let offset = cycleConnectionView.contentOffset.x
        let scrollX = offset + cycleConnectionView.bounds.size.width
        
        cycleConnectionView.setContentOffset(CGPoint(x: scrollX ,y: 0), animated: true)
    }
}

//MARK: - collectionView代理/数据源
extension XLCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! XLCycleViewCell
        cell.cycleModel = cycleModels?[((indexPath as NSIndexPath).item % cycleModels!.count)]
        return cell
        
    }
    
}
extension XLCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offset / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invalidTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
}







