//
//  ContentViewController.swift
//  UIPageViewController
//
//  Created by Umezawa Keisuke on 2021/01/13.
//  Copyright © 2021 Umezawa Keisuke. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let index = index {
            self.view.backgroundColor = ViewModelManager.sharedInstance.data[index].themeColor
        }

    }
    
    func setIndex(index:Int){
        self.index = index
    }
}
