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
        self.scrollView.fillSuperView()
//        self.bottomLine.backgroundColor = lineColor
//        self.scrollView.addSubview(bottomLine)
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
        var originX: CGFloat = 0
        for (index, title) in titles.enumerated() {
            let label = YQNavigationMenuTitleLabel(font: font, normalColor: normalColor, selectedColor: selectedColor, text: title, maxScale: maxScale)
            label.tag = index
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
}
