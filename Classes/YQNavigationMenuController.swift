//
//  YQNavigationMenuController.swift
//  YQNavigationMenuController
//
//  Created by 王叶庆 on 2017/1/12.
//  Copyright © 2017年 王叶庆. All rights reserved.
//

import UIKit

open class YQNavigationMenuController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var collectionView: UICollectionView!
    private var titleView: YQNavigationMenuTitleView!
    
    private lazy var collectionLayout: YQNavigationMenuCollectionLayout = {
        return YQNavigationMenuCollectionLayout()
    }()
    
    var selectIndex: Int = 0 {
        didSet {
            if selectIndex < self.items.count {
                let selectedLabel = self.titleView.titleLabels[selectIndex]
                if !self.isDeltaEnabled {
                    UIView.animate(withDuration: 0.25, animations: { 
                        selectedLabel.isSelected = true
                    })
                } else {
                    selectedLabel.isSelected = true
                }

                self.titleView.scrollView.setContentOffset(CGPoint(x: min(self.titleView.scrollView.contentSize.width - self.titleView.frame.width, max(0, selectedLabel.frame.midX - self.titleView.scrollView.frame.midX)), y: 0), animated: true)
            }
        }
    }
    
    var currentIndex: Int = 0
    private var items:[UIViewController] = [] {
        didSet {
            if self.isViewLoaded {
                self.prepareViews()
            }
        }
    }
    var titleBarHeight: CGFloat = 36.0
    var titleBarColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    var titleNormalColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    var titleSelectedColor: UIColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    var titleColumnSpace: CGFloat = 28.0
    var titleBarLineColor: UIColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    var titleBarLineHeight: CGFloat = 4.0
    var titleMaxScale: CGFloat = 1.1

    private var collectionTopSpaceConstraint: NSLayoutConstraint!
    private var titleBarHeightConstraint: NSLayoutConstraint!
    private var lastOffsetX: CGFloat = 0
    private var isDeltaEnabled = true
    public func setItems(_ items: [UIViewController]) {
        self.items = items
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        if self.items.count > 0 {
            self.prepareViews()
        }
    }
    
    func prepareViews() {
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionLayout)
        self.collectionView.register(YQNavigationMenuCollectionCell.self, forCellWithReuseIdentifier: "\(YQNavigationMenuCollectionCell.self)")
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.bounces = false
        self.view.addSubview(collectionView)
        
        self.titleView = YQNavigationMenuTitleView(font: titleFont, normalColor: titleNormalColor, selectedColor: titleSelectedColor, columnSpace: titleColumnSpace, maxScale: titleMaxScale, lineColor: titleBarLineColor, lineHeight: titleBarLineHeight)
        self.titleView.tapTitleClosure = { (index, titleView) in
            if self.selectIndex != index {
//                titleView.titleLabels[self.selectIndex].isSelected = false
                self.isDeltaEnabled = false
                self.collectionView.setContentOffset(CGPoint(x: CGFloat(index) * self.view.bounds.width, y: 0), animated: true)
            }
        }
        self.view.addSubview(titleView)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: titleView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: titleView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: titleView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0))
        self.titleBarHeightConstraint = NSLayoutConstraint(item: titleView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.titleBarHeight)
        self.titleView.addConstraint(self.titleBarHeightConstraint)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints =  false
        self.view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0))
        self.collectionTopSpaceConstraint = NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: self.titleBarHeight)
        self.view.addConstraint(collectionTopSpaceConstraint)
        self.view.addConstraint(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 0))
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    
        self.titleView.titles = self.items.map({ (vc) -> String in
            return vc.title!
        })
        assert(self.selectIndex < self.items.count, "您选中的视图序号不在范围内")
        self.titleView.titleLabels[self.selectIndex].isSelected = true
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - collection
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: YQNavigationMenuCollectionCell.self), for: indexPath) as! YQNavigationMenuCollectionCell
        cell.add(controller: self.items[indexPath.item], toParentController: self)
        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard isDeltaEnabled else {
            return
        }
        let index = self.getScrollIndex(scrollView)
        let delta = (scrollView.contentOffset.x - lastOffsetX) / scrollView.frame.width;
        self.titleView.titleLabels[self.selectIndex].progress = min(abs(delta), 1)
        if delta > 0 {
            if self.selectIndex + 1 < self.items.count {
                self.titleView.titleLabels[self.selectIndex + 1].progress = min(abs(delta), 1)
            }
        }
        if delta < 0 {
            if self.selectIndex > 0 {
                self.titleView.titleLabels[self.selectIndex - 1].progress = min(abs(delta), 1)
            }
        }
        if currentIndex != index {
            currentIndex = index
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.changeSelectItem(withScrollView: scrollView)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            self.changeSelectItem(withScrollView: scrollView)
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.currentIndex = self.getScrollIndex(scrollView)
        self.changeSelectItem(withScrollView: scrollView)
        self.isDeltaEnabled = true
    }
    
    func changeSelectItem(withScrollView scrollView: UIScrollView) {
        self.lastOffsetX = scrollView.contentOffset.x;
        func cancelSelected() {
            for index in -1 ... 1 {
                if self.selectIndex != currentIndex {
                    let idx = self.selectIndex + index
                    if idx >= 0 && idx < self.items.count {
                        self.titleView.titleLabels[idx].isSelected = false
                    }
                }
            }
        }
        if !self.isDeltaEnabled {
            UIView.animate(withDuration: 0.25, animations: { 
                cancelSelected()
            })
        } else {
            cancelSelected()
        }
        self.selectIndex = self.currentIndex;
    }
    
    func getScrollIndex(_ scrollView: UIScrollView) -> Int{
        let centerX = scrollView.contentOffset.x + scrollView.frame.midX
        return Int(centerX / scrollView.frame.width)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
