//
//  XLChannelView.swift
//  douyuzhibo
//
//  Created by xianglin on 16/10/4.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

//MARK: - 定义一些常量
private let kLineViewH : CGFloat = 2

class XLChannelView: UIView {

    //标题数组
    private var channels: [String]
    
    init(frame: CGRect , channels: [String]) {
        self.channels = channels
        super.init(frame: frame)
        //设置UI
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - 设置UI
    private func setupUI() {
        //1.添加scrollView
        addSubview(scrollView)
        //2.创建标签
        creatChannelLabel()
        //3.添加底部lineView
    }
    
    //MARK: - 创建channel标签
    private func creatChannelLabel() {
        
        let labelW : CGFloat = frame.width / CGFloat(channels.count)
        let labelH : CGFloat = frame.height - kLineViewH
        let labelY : CGFloat = 0
        
        //0.根据channels长度创建label
        for (index , title) in channels.enumerate() {
            let label = UILabel()
            //1.设置内容
            label.text = title
            label.tag = index
            label.font = UIFont.systemFontOfSize(16)
            label.textColor = UIColor.blackColor()
            label.textAlignment = .Center
            
            //2.设置frame
            let labelX : CGFloat = CGFloat(index) * labelW
            label.frame = CGRectMake(labelX, labelY, labelW, labelH)
            
            //3.添加到父控件/数组
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    //MARK: - 懒加载控件
    private lazy var scrollView : UIScrollView = {[weak self] in
        let scrollView = UIScrollView()
        scrollView.frame = self!.bounds
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var titleLabels = [UILabel]()
    
    private lazy var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.orangeColor()
        return lineView
    }()
    
}
