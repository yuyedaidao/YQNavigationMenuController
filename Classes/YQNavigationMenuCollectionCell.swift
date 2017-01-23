//
//  YQNavigationMenuCollectionCell.swift
//  YQNavigationMenuController
//
//  Created by 王叶庆 on 2017/1/12.
//  Copyright © 2017年 王叶庆. All rights reserved.
//

import UIKit

class YQNavigationMenuCollectionCell: UICollectionViewCell {
    var controller: UIViewController?
    
    func add(controller: UIViewController, toParentController parentController: UIViewController) {
        if let oldController = self.controller {
            oldController.willMove(toParentViewController: nil)
            oldController.view.removeFromSuperview()
            oldController.didMove(toParentViewController: nil)
        }
        self.addSubview(controller.view)
        controller.view.fillSuperView()
        parentController.addChildViewController(controller)
        controller.didMove(toParentViewController: parentController)
    }

}
