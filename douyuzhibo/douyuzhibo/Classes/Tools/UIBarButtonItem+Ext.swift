//
//  UIBarButtonItem+Ext.swift
//  douyuzhibo
//
//  Created by xianglin on 16/10/4.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(normalImageName : String , highImageName : String = "" , size : CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: normalImageName), for: UIControlState())
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        }
        self.init(customView : btn)
    }
}
