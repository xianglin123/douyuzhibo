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

let kPrettyCellID = "kPrettyCellID"
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPrettyItemH = kNormalItemW * 4 / 3

class XLRecommendController: XLBaseViewController {
    //MARK: - 懒加载属性
    // 1. viewModel对象 请求和处理数据
    fileprivate lazy var recommendVM : XLRecommendVM = XLRecommendVM()
    // 2. connectionView 显示界面
    lazy var collectionView : UICollectionView = { [unowned self] in
        // 2.1 设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.2 设置collection
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // 2.3 注册cell
        collectionView.register(UINib(nibName: "XLRecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "XLPrettyCollectionCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "XLCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        recommendVM.requestData{
            self.collectionView.reloadData()
        }
    }

}

//MARK: - collection dataSource/delegate
extension XLRecommendController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorModels.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.anchorModels[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! XLPrettyCollectionCell
            prettyCell.anchorModel = recommendVM.anchorModels[indexPath.section].anchors[indexPath.item]
            return prettyCell
        }else {
            
            let normalCell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! XLRecommendNormalCell
            
            normalCell.anchorModel = recommendVM.anchorModels[indexPath.section].anchors[indexPath.item]
            return normalCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! XLCollectionHeaderView
        
        headerView.anchorGroup = recommendVM.anchorModels[indexPath.section]
        
        return headerView
    }
}
extension XLRecommendController : UICollectionViewDelegate {
    
}




