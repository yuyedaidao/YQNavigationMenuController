//
//  UIView+YQNMCExtension.swift
//  YQNavigationMenuController
//
//  Created by 王叶庆 on 2017/1/12.
//  Copyright © 2017年 王叶庆. All rights reserved.
//

import UIKit

extension UIView {
    func fillSuperView(_ inset: UIEdgeInsets = UIEdgeInsets.zero) -> Void {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let superView = self.superview {
            superView.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: .leading, multiplier: 1, constant: inset.left))
            superView.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: superView, attribute: .width, multiplier: 1, constant: -inset.left - inset.right))
            superView.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: inset.top))
            superView.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: superView, attribute: .height, multiplier: 1, constant: -inset.top - inset.bottom))
        } else {
            assert(false, "在调用fillSuperView方法前请保证当时视图已经添加在父视图上了")
        }
        
    }
}
