//
//  XLCycleViewCell.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/29.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

class XLCycleViewCell: UICollectionViewCell {

    
    @IBOutlet weak var cycleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel : XLCycleModel?{
        didSet{
            guard let cycleModel = cycleModel else { return }
            guard let url = URL(string: cycleModel.pic_url) else { return }
            cycleImage.kf.setImage(with: url)
            
            titleLabel.text = cycleModel.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
