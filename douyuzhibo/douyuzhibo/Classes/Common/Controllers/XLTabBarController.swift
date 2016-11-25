//
//  XLTabBarController.swift
//  douyuzhibo
//
//  Created by xianglin on 16/10/4.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

class XLTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //添加子控制器
        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Focus")
        addChildVC("Myself")

    }

    fileprivate func addChildVC(_ storyboardName : String) {
        
        let childVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
        
        addChildViewController(childVc!)
    }
}
