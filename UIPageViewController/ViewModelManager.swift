//
//  ViewModelManager.swift
//  UIPageViewController
//
//  Created by Umezawa Keisuke on 2021/01/13.
//  Copyright © 2021 Umezawa Keisuke. All rights reserved.
//

import Foundation
import UIKit

class ViewModelManager {
    typealias ViewModel = (menuTitle: String, content: String, themeColor: UIColor)

    static let sharedInstance = ViewModelManager()

    let data: [ViewModel] = [
        (menuTitle: "メニュー1", content: "コンテンツ1",  themeColor: UIColor.red),
        (menuTitle: "メニュー2", content: "コンテンツ2",  themeColor: UIColor.green),
        (menuTitle: "メニュー3", content: "コンテンツ3",  themeColor: UIColor.purple),
        (menuTitle: "メニュー4", content: "コンテンツ4",  themeColor: UIColor.yellow),
        (menuTitle: "メニュー5", content: "コンテンツ5",  themeColor: UIColor.cyan),
        (menuTitle: "メニュー6", content: "コンテンツ6",  themeColor: UIColor.orange)
    ]
}
