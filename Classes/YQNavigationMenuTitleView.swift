//
//  YQNavigationMenuTitleView.swift
//  YQNavigationMenuController
//
//  Created by 王叶庆 on 2017/1/12.
//  Copyright © 2017年 王叶庆. All rights reserved.
//

import UIKit

class YQNavigationMenuTitleView: UIView, YQNavigationMenuTitleLabelDelegate {

    var tapTitleClosure: ((_ index: Int, _ titleView: YQNavigationMenuTitleView) -> Void)?
    var scrollView: UIScrollView
    var titles: [String] = [] {
        didSet {
            self.layoutTitleLabels()
        }
    }
    var titleLabels: [YQNavigationMenuTitleLabel] = []
    var font: UIFont
    var normalColor: UIColor
    var selectedColor: UIColor
    var columnSpace: CGFloat
    var maxScale: CGFloat
    var lineColor: UIColor
    var lineHeight: CGFloat
    
    private var bottomLine: UIView
    
    init(font: UIFont, normalColor: UIColor, selectedColor: UIColor, columnSpace: CGFloat, maxScale: CGFloat, lineColor: UIColor, lineHeight: CGFloat) {
        self.font = font
        self.normalColor = normalColor
        self.selectedColor = selectedColor
        self.columnSpace = columnSpace
        self.maxScale = maxScale
        self.lineColor = lineColor
        self.lineHeight = lineHeight
        self.scrollView = UIScrollView()
        self.bottomLine = UIView()
        super.init(frame: CGRect.zero)
        self.prepareViews()
    }
    
    func prepareViews() {
        self.addSubview(self.scrollView)
        self.scrollView.bounces = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.fillSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutTitleLabels() {
        var originX: CGFloat = 0
        for (index, title) in titles.enumerated() {
            let label = YQNavigationMenuTitleLabel(font: font, normalColor: normalColor, selectedColor: selectedColor, text: title, maxScale: maxScale)
            label.tag = index
            label.delegate = self
            let width = label.textSize.width + self.columnSpace
            label.frame = CGRect(x: originX, y: 0, width: width, height: 0)//高之所以是0是因为这时候还没法确定高
            self.scrollView.addSubview(label)
            self.titleLabels.append(label)
            originX += width
        }
        self.scrollView.contentSize = CGSize(width: originX, height: self.bounds.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for label in self.titleLabels {
            label.frame.size.height = self.bounds.height
        }
//        if let label = self.titleLabels.first {
//        self.bottomLine.frame = CGRect(x: label.frame.minX + , y: label.bounds.height - self.lineHeight, width: label.bounds.width, height: self.lineHeight)
//        }
    }
    
    //MARK: - delegate label
    func didTapLabel(_ label: YQNavigationMenuTitleLabel) {
        if let closure = self.tapTitleClosure {
            closure(label.tag, self)
        }
    }
}
