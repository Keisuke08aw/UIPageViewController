//
//  ContainerViewController.swift
//  UIPageViewController
//
//  Created by Umezawa Keisuke on 2021/01/13.
//  Copyright © 2021 Umezawa Keisuke. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    var menuViewController: MenuViewController?
    var pageViewController: PageViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedMenuViewController" {
            menuViewController = segue.destination as? MenuViewController
            menuViewController?.delegate = self
        } else if segue.identifier == "embedPageViewController" {

            pageViewController = segue.destination as? PageViewController
//            pageViewController = vc
            pageViewController?.pageViewDelegate = self
        }
    }
}



extension ContainerViewController: MenuViewControllerDelegate {
    func menuViewController(viewController: MenuViewController, at index: Int) {

        print(pageViewController?.viewControllers)
        // 現在表示されているViewControllerを取得する
        guard let currentVc = pageViewController?.viewControllers?.first as? ContentViewController,
            let currentIndex = currentVc.index else {
                fatalError("not ContentViewController")
        }

        // 選択したindexが表示しているコンテンツと同じなら処理を止める
        guard currentIndex != index else { return }

        // 選択したindexと現在表示されているindexを比較して、ページングの方法を決める
        let direction: UIPageViewController.NavigationDirection = currentIndex < index ? .forward : .reverse
        let vc = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        vc.index = index
        // 新しくViewControllerを設定する　※　下のスワイプと組み合わせる時はanimatedはfalseに設定しておいたほうが無難
        pageViewController?.setViewControllers([vc], direction: direction, animated: true) { _ in }
    }
}

extension ContainerViewController: PageViewControllerDelegate {
    func pageViewScroll(indexPath: NSIndexPath) {
        menuViewController?.focusCell(indexPath: indexPath)
    }
}
