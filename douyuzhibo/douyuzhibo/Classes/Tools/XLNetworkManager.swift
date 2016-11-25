//
//  XLNetworkManager.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/25.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit
import Alamofire


//MARK: - 请求方法
enum requestMethod {
    case get
    case post
}

//MARK: - 封装网络请求
class XLNetworkManager {

    class func request(_ type : requestMethod , url : String , paramters : [String : Any]? = nil , finishedCallback : @escaping (_ result : Any) -> ()) {
        
        // 1.获取请求方法
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(url, method: method, parameters: paramters).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
}
