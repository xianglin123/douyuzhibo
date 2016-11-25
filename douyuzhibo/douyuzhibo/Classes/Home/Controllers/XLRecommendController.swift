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

class XLRecommendController: UIViewController {
    //MARK: - 懒加载属性
    // 1. viewModel对象 请求和处理数据
    private lazy var recommendVM : XLRecommendVM = XLRecommendVM()
    // 2. connectionView 显示界面
    private lazy var collectionView : UICollectionView = {
        // 2.1 设置布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        
        // 2.2 设置collection
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.red
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return collectionView
    }()
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        recommendVM.requestData{
            print("请求结束")
        }
    }

}

//MARK: - collection dataSource/delegate
extension XLRecommendController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        return cell
    }
}
extension XLRecommendController : UICollectionViewDelegate {
    
}




