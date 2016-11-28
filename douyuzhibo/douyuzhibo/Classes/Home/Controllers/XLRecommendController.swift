//
//  XLRecommendController.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/25.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"


class XLRecommendController: XLBaseViewController {
    //MARK: - 懒加载属性
    // 1. viewModel对象 请求和处理数据
    fileprivate lazy var recommendVM : XLRecommendVM = XLRecommendVM()
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        baseViewModel = recommendVM
        recommendVM.requestData{
            self.collectionView.reloadData()
            
            
        }
    }

}

extension XLRecommendController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! XLPrettyCollectionCell
            prettyCell.anchorModel = baseViewModel.anchorModels[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }else {
            
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
    }
}




