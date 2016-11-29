//
//  XLGameViewController.swift
//  douyuzhibo
//
//  Created by xianglin on 16/11/29.
//  Copyright © 2016年 xianglin. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50

private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class XLGameViewController: UIViewController {

    lazy var gameViewModel : XLGameViewModel = XLGameViewModel()
    
    fileprivate lazy var gameConnection : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        // 2.创建UICollectionView
        let gameConnection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        gameConnection.backgroundColor = UIColor.white
        gameConnection.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        gameConnection.register(UINib(nibName: "XLGameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
//        gameConnection.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        gameConnection.dataSource = self
 
        return gameConnection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        view.addSubview(gameConnection)
    }

}

//MARK: - 数据源/代理
extension XLGameViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.gameModels?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! XLGameCollectionCell
        
        return cell
    }
}

