//
//  XLRecommendController.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/25.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

class XLRecommendController: XLBaseViewController {
    //MARK: - 懒加载属性
    fileprivate lazy var recommendVM : XLRecommendVM = XLRecommendVM()
    fileprivate lazy var cycleView : XLCycleView = {
        let cycleView = XLCycleView.cycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH, width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加collectionView
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH, left: 0, bottom: 0, right: 0)
        // 赋值根VM
        baseViewModel = recommendVM
        // 请求推荐数据
        recommendVM.requestData{
            // 刷新表格
            self.collectionView.reloadData()
        }
        // 请求轮播数据
        recommendVM.requestCycleData{
            // 赋值模型数组
            self.cycleView.cycleModels = self.recommendVM.cycleModels
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
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}




