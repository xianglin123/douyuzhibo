//
//  XLHomeViewController.swift
//  douyuzhibo
//
//  Created by xianglin on 16/10/4.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

private let kChannelH : CGFloat = 40

class XLHomeViewController: UIViewController {

    //MARK: - 懒加载控件
    //1.标题栏
    private lazy var channelView : XLChannelView = {[weak self]
        in
        let frame = CGRect(x: 0, y: kStatusBarH + kNaviBarH, width: kScreenW, height: kChannelH)
        let channels = ["推荐", "游戏", "娱乐", "趣玩"]
        let channelView = XLChannelView(frame: frame, channels: channels)
        channelView.delegate = self
        return channelView
    }()
    //2.内容视图
    private lazy var contentView : XLContentView = {[weak self] in
        
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNaviBarH - kChannelH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNaviBarH + kChannelH, width: kScreenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = XLContentView(frame: contentFrame, childVcs: childVcs, parentController: self)
        contentView.delegate = self
        return contentView
        }()
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI
        setupUI()
        
    }
    
    //MARK: - 设置UI
    private func setupUI() {
        //是否自动调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //设置导航栏
        setupNavi()
        
        //添加channel标题栏
        view.addSubview(channelView)
        
        //添加内容视图
        view.addSubview(contentView)
    }
    
    //MARK: - 设置导航栏
    private func setupNavi() {
        //1.设置左侧item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(normalImageName: "logo")
        
        //2.设置右侧items
        let size = CGSizeMake(40, 40)
        let historyItem = UIBarButtonItem(normalImageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let codeItem = UIBarButtonItem(normalImageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        let searchItem = UIBarButtonItem(normalImageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        self.navigationItem.rightBarButtonItems = [searchItem, codeItem, historyItem]
    }
}

//MARK: - channelView的代理方法
extension XLHomeViewController : XLChannelViewDelegate{
    func channelView(titleView: XLChannelView, selectedIndex: Int) {
        //切换contentView
        contentView.setCurrentIndex(selectedIndex)
    }
}

//MARK: - contentView的代理方法
extension XLHomeViewController : XLContentViewDelegate{
    func contentView(contentView: XLContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //切换channel
        channelView.setChannelView(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}