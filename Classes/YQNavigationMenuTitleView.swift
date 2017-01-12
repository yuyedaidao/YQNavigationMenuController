//
//  YQNavigationMenuTitleView.swift
//  YQNavigationMenuController
//
//  Created by 王叶庆 on 2017/1/12.
//  Copyright © 2017年 王叶庆. All rights reserved.
//

import UIKit

class YQNavigationMenuTitleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var scrollView: UIScrollView
    var titles:[String] = [] {
        didSet {
            self.layoutTitleLabels()
        }
    }
    var font: UIFont
    var normalColor: UIColor
    var selectedColor: UIColor
    
    init(font: UIFont, normalColor: UIColor, selectedColor: UIColor) {
        self.font = font
        self.normalColor = normalColor
        self.selectedColor = selectedColor
        self.scrollView = UIScrollView()
        super.init(frame: CGRect.zero)
        
        self.prepareViews()
    }
    
    func prepareViews() {
        self.addSubview(self.scrollView)
        self.scrollView.fillSuperView()
    }
    
//    override init(frame: CGRect) {
//        self.scrollView = UIScrollView()
//        super.init(frame: frame)
//        self.addSubview(scrollView)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutTitleLabels() {
        for (index, title) in titles.enumerated() {
            let label = YQNavigationMenuTitleLabel(font: font, normalColor: normalColor, selectedColor: selectedColor, text: title)
            print(label.textSize())
        }
    }
    
}
