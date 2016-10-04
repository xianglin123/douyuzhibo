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

    private lazy var channelView : XLChannelView = {[weak self] in
        let frame = CGRectMake(0, kStatusBarH + kNaviBarH, kScreenW, kChannelH)
        let channels : [String] = ["推荐", "游戏", "娱乐", "趣玩"]
        let channelView = XLChannelView(frame: frame, channels: channels)
        
        return channelView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置导航栏
        setupNavi()
        
        //添加channel标题栏
        view.addSubview(channelView)
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
