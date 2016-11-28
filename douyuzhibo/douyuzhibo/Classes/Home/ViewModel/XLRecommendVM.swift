//
//  XLRecommendVM.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/25.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

class XLRecommendVM: XLBaseViewModel {
    
    
    // 普通主播数组
    fileprivate lazy var normalGroup : XLAnchorGroup = XLAnchorGroup()
    // 颜值主播数组
    fileprivate lazy var prettyGroup : XLAnchorGroup = XLAnchorGroup()
}

//MARK: - 请求网络数据
extension XLRecommendVM {
    
    //MARK: - 请求推荐页面数据
    func requestData(_ finishCallback : @escaping () -> ()) {
        // 0.获取请求时的秒数
        let interval = Int(NSDate().timeIntervalSince1970)
        // 1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : "\(interval)"]
        // 2.创建Group
        let dGroup = DispatchGroup()
        
        dGroup.enter()
        // 1. 第一部分:请求热门数据
        XLNetworkManager.request(.get, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", paramters: ["time" : "\(interval)"]) { (result) in

            // 1.1 获取响应字典
            guard let responseDict = result as? [String : NSObject] else { return }
            
            // 1.2 取出数组data,内部都是字典,字典转模型
            guard let dataArray = responseDict["data"] as? [[String : NSObject]] else { return }
            
            // 1.3 设置组头
            self.normalGroup.tag_name = "热门"
            self.normalGroup.icon_name = "home_header_hot"
            
            // 1.4 字典转模型 并添加至普通主播数组
            for dict in dataArray {
               self.normalGroup.anchors.append(XLAnchorModel.init(dict: dict))
            }
            dGroup.leave()
        }
        
        dGroup.enter()
        // 2. 第二部分:请求颜值数据
        XLNetworkManager.request(.get, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", paramters: parameters) { (result) in
            // 2.1 获取响应字典
            guard let responseDict = result as? [String : NSObject] else { return }
            
            // 2.2 取出数组data,内部都是字典,字典转模型
            guard let dataArray = responseDict["data"] as? [[String : NSObject]] else { return }
            
            // 2.3 设置组头
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            // 2.4 字典转模型 并添加至数组
            for dict in dataArray {
                self.prettyGroup.anchors.append(XLAnchorModel.init(dict: dict))
            }
            dGroup.leave()
        }
        
        dGroup.enter()
        // 3. 第三部分:请求2组-12组数据
        XLNetworkManager.request(.get, url: "http://capi.douyucdn.cn/api/v1/getHotCate", paramters: parameters) { (result) in
            
            // 1.1 获取响应字典
            guard let responseDict = result as? [String : NSObject] else { return }
            
            // 1.2 取出数组data,内部都是字典,字典转模型
            guard let dataArray = responseDict["data"] as? [[String : NSObject]] else { return }
            
            // 1.4 字典转模型 并添加至普通主播数组
            for dict in dataArray {
                self.anchorModels.append(XLAnchorGroup.init(dict: dict))
            }
            
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorModels.insert(self.prettyGroup, at: 0)
            self.anchorModels.insert(self.normalGroup, at: 0)
            // 5.完成回调
            finishCallback()
        }
    }
}
