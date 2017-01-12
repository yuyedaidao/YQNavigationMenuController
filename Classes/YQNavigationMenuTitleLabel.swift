//
//  YQNavigationMenuTitleLabel.swift
//  YQNavigationMenuController
//
//  Created by 王叶庆 on 2017/1/12.
//  Copyright © 2017年 王叶庆. All rights reserved.
//

import UIKit

class YQNavigationMenuTitleLabel: UIView {
    
    var normalColor: UIColor
    var selectedColor: UIColor
    var text: String
    var font: UIFont
    var scale: CGFloat
    
    init(font: UIFont, normalColor: UIColor, selectedColor: UIColor, text: String, _ scale: CGFloat = 1) {
        self.font = font
        self.normalColor = normalColor
        self.selectedColor = selectedColor
        self.text = text
        self.scale = scale
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if let context = UIGraphicsGetCurrentContext() {
            context.textMatrix = CGAffineTransform.identity
            context.scaleBy(x: self.scale, y: self.scale)
            let path = CGMutablePath()
//            CGPathAddRect(path, nil, self.bounds)
            path.addRect(self.bounds)
            let attributedString = NSMutableAttributedString(string: self.text)
            attributedString.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(NSForegroundColorAttributeName, value: self.normalColor, range: NSMakeRange(0, attributedString.length))
            let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributedString.length), path, nil)
            CTFrameDraw(frame, context)
        }
        
    }
    
    func textSize() -> CGSize{
        var size = CGSize.zero
        UIGraphicsBeginImageContext(CGSize(width: 1000, height: 100))
        if let context = UIGraphicsGetCurrentContext() {
            context.textMatrix = CGAffineTransform.identity
            context.scaleBy(x: self.scale, y: self.scale)
            let path = CGMutablePath()
            //            CGPathAddRect(path, nil, self.bounds)
            path.addRect(self.bounds)
            let attributedString = NSMutableAttributedString(string: self.text)
            attributedString.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, attributedString.length))
            let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
            let restrictSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0) , nil, restrictSize, nil)
        }

        UIGraphicsEndImageContext()
        return size
    }
}
