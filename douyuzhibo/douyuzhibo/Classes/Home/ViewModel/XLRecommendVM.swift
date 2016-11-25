//
//  XLRecommendVM.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/25.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

class XLRecommendVM: NSObject {

}

//MARK: - 请求网络数据
extension XLRecommendVM {
    
    //MARK: - 第一部分:请求推荐数据
    func requestData(_ finishCallback : @escaping () -> ()) {
        //1.获取请求时的秒数
        let interval = Int(NSDate().timeIntervalSince1970)
        
        //1. 请求热门数据
        XLNetworkManager.request(.get, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", paramters: ["time" : "\(interval)"]) { (result) in
//            print(result)
            // 2. 获取响应字典
            guard let responseDict = result as? [String : NSObject] else { return }
            // 3. 取出数组data,内部都是字典,字典转模型
            guard let dataArray = responseDict["data"] as? [[String : NSObject]] else { return }
            
            
            
            finishCallback()
        }
    }
}
