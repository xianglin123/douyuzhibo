//
//  XLRecommendNormalCell.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/28.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

class XLRecommendNormalCell: XLCollectionViewBaseCell {
    
    @IBOutlet weak var roomName: UILabel!
    
    override var anchorModel: XLAnchorModel? {
        didSet{
            // 先完成父类设置
            super.anchorModel = anchorModel
            
            // 再设置房间名
            roomName.text = anchorModel?.room_name
        }
    }
}
