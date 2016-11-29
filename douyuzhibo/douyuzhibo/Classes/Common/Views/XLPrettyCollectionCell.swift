//
//  XLPrettyCollectionCell.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/28.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

class XLPrettyCollectionCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var loactionBtn: UIButton!
    
    var anchorModel: XLAnchorModel? {
        didSet{
            guard let anchorModel = anchorModel else { return }
            
            // 设置房间图片
            guard let url = URL(string: anchorModel.vertical_src) else { return }
            iconImageView.kf.setImage(with: url)
            // 设置名称
            nickName.text = anchorModel.nickname
            // 设置房间名
            loactionBtn.setTitle(anchorModel.anchor_city, for: .normal)
        }
    }
}
