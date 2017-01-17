//
//  YQNavigationMenuTitleLabel.swift
//  YQNavigationMenuController
//
//  Created by 王叶庆 on 2017/1/12.
//  Copyright © 2017年 王叶庆. All rights reserved.
//

import UIKit

class YQNavigationMenuTitleLabel: UIView {
    
    private let normalColor: UIColor
    private let selectedColor: UIColor
    private let normalColorRGB: [CGFloat]
    private let selectedColorRGB: [CGFloat]
    private let rgbDifference: [CGFloat]
    var text: String
    var font: UIFont
    var maxScale: CGFloat
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                self.label.transform = CGAffineTransform(scaleX: maxScale, y: maxScale)
                self.label.textColor = selectedColor
            } else {
                self.label.transform = CGAffineTransform.identity
                self.label.textColor = normalColor
            }
        }
    }
    
    private let label = UILabel()
    var progress: CGFloat = 0 {
        didSet {
            self.changeTransform()
        }
    }

    
    lazy var textSize: CGSize = {
        let attributes = [NSFontAttributeName: self.font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = self.text.boundingRect(with: CGSize(width: 1000, height: 100), options: option, attributes: attributes, context: nil)
        return rect.size
    }()
    init(font: UIFont, normalColor: UIColor, selectedColor: UIColor, text: String, maxScale: CGFloat = 1) {
        self.font = font
        self.normalColor = normalColor
        self.selectedColor = selectedColor
        self.text = text
        self.maxScale = maxScale
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        normalColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        self.normalColorRGB = [r, g, b]
        selectedColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        self.selectedColorRGB = [r, g, b]
        self.rgbDifference = [selectedColorRGB[0] - normalColorRGB[0], selectedColorRGB[1] - normalColorRGB[1], selectedColorRGB[2] - normalColorRGB[2]]
        super.init(frame: CGRect.zero)
        self.label.text = text
        self.label.font = font
        self.label.sizeToFit()
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
    }
    
    func changeTransform() {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        if self.isSelected {
            r = selectedColorRGB[0] - rgbDifference[0] * progress
            g = selectedColorRGB[1] - rgbDifference[1] * progress
            b = selectedColorRGB[2] - rgbDifference[2] * progress
        } else {
            r = normalColorRGB[0] + rgbDifference[0] * progress
            g = normalColorRGB[1] + rgbDifference[1] * progress
            b = normalColorRGB[2] + rgbDifference[2] * progress
        }
        self.label.textColor = UIColor(colorLiteralRed: Float(r), green: Float(g), blue: Float(b), alpha: 1)
        let scale = self.isSelected ?  maxScale - (maxScale - 1) * progress : 1 + (maxScale - 1) * progress
        self.label.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}
