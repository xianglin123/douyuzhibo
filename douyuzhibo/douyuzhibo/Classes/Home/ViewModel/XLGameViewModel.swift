//
//  XLGameViewModel.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/29.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

class XLGameViewModel: NSObject {

    var gameModels : [XLGameModel]?
    
    func requestData(_ finishCallBack : @escaping ()->()) {
        XLNetworkManager.request(.get, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail", paramters: ["shortName" : "game"]) { (result) in
            
        }
    }
    
}
