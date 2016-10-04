//
//  AppDelegate.swift
//  douyuzhibo
//
//  Created by xianglin on 16/10/4.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        return true
    }

}

