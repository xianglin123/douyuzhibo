//
//  XLChannelView.swift
//  douyuzhibo
//
//  Created by xianglin on 16/10/4.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit
//MARK: - 定义协议
protocol XLChannelViewDelegate : class {

    func channelView(titleView : XLChannelView, selectedIndex : Int)
    
}
//MARK: - 定义一些常量
private let kLineViewH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class XLChannelView: UIView {

    //MARK: - 定义属性
    //1.标题数组
    private var channels: [String]
    //2.当前的label的索引
    private var currentIndex: Int = 0
    //3.代理
    weak var delegate : XLChannelViewDelegate?
    
    //MARK: - 系统回调
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
        scrollView.frame = bounds
        //2.创建标签
        creatChannelLabel()
        //3.添加底部lineView
        creatBottomView()
    }
    
    //MARK: - 创建channel标签
    private func creatChannelLabel() {
        
        let labelW : CGFloat = frame.width / CGFloat(channels.count)
        let labelH : CGFloat = frame.height - kLineViewH
        let labelY : CGFloat = 0
        
        //0.根据channels长度创建label
        for (index , title) in channels.enumerate() {
            let label = UILabel()
            //1.设置属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFontOfSize(16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .Center

            //2.设置frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //3.添加到父控件/数组
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //4.给Label添加手势
            label.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.channelLabelClick(_:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    //MARK: - 创建底部line/滑块
    private func creatBottomView() {
        //1.创建line
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.创建滑块
        // 2.1.获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        // 2.2.设置lineView的属性
        scrollView.addSubview(lineView)
        lineView.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kLineViewH, width: firstLabel.frame.width, height: kLineViewH)
    }
    
    //MARK: - 懒加载控件
    //1.scrollView滚动标题
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    //2.标题名称标签
    private lazy var titleLabels : [UILabel] = [UILabel]()
    //3.标题底部横线
    private lazy var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.orangeColor()
        return lineView
    }()
}

//MARK: - 标签手势点击方法
extension XLChannelView {
    @objc private func channelLabelClick(tap : UITapGestureRecognizer) {
//        print("点击标题")
        //1.拿到点击的label(tag值)
        guard let currentLabel = tap.view as? UILabel else {return}
        
        //2.如果点击同一个label,直接return
        if currentLabel.tag == currentIndex {return}
        
        //3.点击之前label
        let oldLabel = titleLabels[currentIndex]
        
        //4.改变label颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //5.保存新索引
        currentIndex = currentLabel.tag
        
        //6.滚动条位置发生改变
        let lineViewX = CGFloat(currentIndex) * lineView.frame.width
        UIView.animateWithDuration(0.1) {
            self.lineView.frame.origin.x = lineViewX
        }
        
        //7.实现二级联动效果,切换视图,使用代理
        delegate?.channelView(self, selectedIndex: currentIndex)
    }
}

//MARK: - 根据contentView改变channelView的方法
extension XLChannelView {
    func setChannelView (progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
    }
}
