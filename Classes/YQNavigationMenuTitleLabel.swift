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
//        UIGraphicsBeginImageContext(CGSize(width: 1000, height: 100))
//        if let context = UIGraphicsGetCurrentContext() {
//            context.textMatrix = CGAffineTransform.identity
//            let path = CGMutablePath()
//            path.addRect(self.bounds)
//            let attributedString = NSMutableAttributedString(string: self.text)
//            attributedString.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, attributedString.length))
//            let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
//            let restrictSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
//            size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0) , nil, restrictSize, nil)
//        }
//        
//        UIGraphicsEndImageContext()
        //计算文字大小
      
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
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//        if let context = UIGraphicsGetCurrentContext() {
//            context.textMatrix = CGAffineTransform.identity
//            let scale = self.isSelected ?  maxScale - (maxScale - 1) * progress : 1 + (maxScale - 1) * progress
//            print("scale :\(scale)")
//            context.translateBy(x: (self.bounds.width - self.textSize.width * scale) / 2, y: self.bounds.height + (self.bounds.height - self.textSize.height * scale) / 2)
//            context.scaleBy(x: scale, y: -scale)
//            let path = CGMutablePath()
//            path.addRect(self.bounds)
//            let attributedString = NSMutableAttributedString(string: self.text)
//            attributedString.addAttribute(NSFontAttributeName, value: self.font, range: NSMakeRange(0, attributedString.length))
//            attributedString.addAttribute(NSForegroundColorAttributeName, value: self.normalColor, range: NSMakeRange(0, attributedString.length))
//            let framesetter = CTFramesetterCreateWithAttributedString(attributedString)
//            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributedString.length), path, nil)
//            CTFrameDraw(frame, context)
//        }
//        
//    }
    
}
