//
//  XLCollectionViewBaseCell.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/28.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit
import Kingfisher

class XLCollectionViewBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var anchorImage: UIImageView!
    @IBOutlet weak var anchorName: UILabel!
    @IBOutlet weak var onlineButton: UIButton!
    
    var anchorModel : XLAnchorModel? {
        didSet{
            guard let anchorModel = anchorModel else { return }
            
            // 设置房间图片
            guard let url = URL(string: anchorModel.vertical_src) else { return }
            anchorImage.kf.setImage(with: url)
            
            // 设置主播名
            anchorName.text = anchorModel.nickname
            
            // 设置在线人数
            var onlineStr = ""            
            if anchorModel.online >= 10000 {
                onlineStr = "\(Int(anchorModel.online / 10000))万人在线"
            }else {
                onlineStr = "\(Int(anchorModel.online))人在线"
            }
            onlineButton.setTitle(onlineStr, for: .normal)
        }
    }
    
}
