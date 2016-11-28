//
//  XLCollectionHeaderView.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/28.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

class XLCollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var anchorGroup : XLAnchorGroup? {
        didSet{
            iconImageView.image = UIImage(named: anchorGroup?.icon_name ?? "home_header_normal")
            headerName.text = anchorGroup?.tag_name
        }
    }
    
    
    
}
// MARK:- 从Xib中快速创建的类方法
extension XLCollectionHeaderView {
    class func collectionHeaderView() -> XLCollectionHeaderView {
        return Bundle.main.loadNibNamed("XLCollectionHeaderView", owner: nil, options: nil)?.first as! XLCollectionHeaderView
    }
}
