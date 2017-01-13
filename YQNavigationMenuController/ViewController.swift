//
//  ViewController.swift
//  YQNavigationMenuController
//
//  Created by 王叶庆 on 2017/1/12.
//  Copyright © 2017年 王叶庆. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
        print("Tag(\(self.view.tag)) load");
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(colorLiteralRed: Float(arc4random() % 255) / 255.0, green: Float(arc4random() % 255) / 255.0, blue: Float(arc4random() % 255) / 255.0, alpha: 1)
        print("Tag(\(self.view.tag)) didLoad");

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Tag(\(self.view.tag)) willAppear");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

