//
//  XLCycleModel.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/29.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

class XLCycleModel: NSObject {
    // 标题
    var title : String = ""
    // 图片
    var pic_url : String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
