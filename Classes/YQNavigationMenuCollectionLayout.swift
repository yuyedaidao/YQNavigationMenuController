//
//  YQNavigationMenuCollectionLayout.swift
//  YQNavigationMenuController
//
//  Created by 王叶庆 on 2017/1/12.
//  Copyright © 2017年 王叶庆. All rights reserved.
//

import UIKit

class YQNavigationMenuCollectionLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        self.minimumLineSpacing = 0
        self.scrollDirection = .horizontal
        self.itemSize = (self.collectionView?.bounds.size)!
    }
}
