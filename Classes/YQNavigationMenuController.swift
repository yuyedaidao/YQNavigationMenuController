//
//  YQNavigationMenuController.swift
//  YQNavigationMenuController
//
//  Created by 王叶庆 on 2017/1/12.
//  Copyright © 2017年 王叶庆. All rights reserved.
//

import UIKit

class YQNavigationMenuController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private var collectionView: UICollectionView!
    private var titleView: YQNavigationMenuTitleView!
    
    
    private lazy var collectionLayout: YQNavigationMenuCollectionLayout = {
        return YQNavigationMenuCollectionLayout()
    }()
    
    var selectIndex: Int = 0
    var items:[UIViewController] = []
    var titleBarHeight: CGFloat = 28.0
    var titleBarColor: UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    var titleNormalColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    var titleSelectedColor: UIColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    var titleColumnSpace: CGFloat = 8.0
    var titleBarLineColor: UIColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    var titleBarLineHeight: CGFloat = 4.0
    
    
    private var collectionTopSpaceConstraint: NSLayoutConstraint!
    private var titleBarHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // collectionView
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.collectionLayout)
        self.collectionView.register(YQNavigationMenuCollectionCell.self, forCellWithReuseIdentifier: "\(YQNavigationMenuCollectionCell.self)")
        self.collectionView.isPagingEnabled = true
        self.view.addSubview(collectionView)
        
        self.titleView = YQNavigationMenuTitleView(font: titleFont, normalColor: titleNormalColor, selectedColor: titleSelectedColor)
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - collection
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: YQNavigationMenuCollectionCell.self), for: indexPath) as! YQNavigationMenuCollectionCell
        cell.add(controller: self.items[indexPath.item], toParentController: self)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
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
