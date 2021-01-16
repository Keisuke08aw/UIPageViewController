//
//  PageViewController.swift
//  UIPageViewController
//
//  Created by Umezawa Keisuke on 2021/01/16.
//  Copyright © 2021 Umezawa Keisuke. All rights reserved.
//

import UIKit

@objc protocol PageViewControllerDelegate: class {
    func pageViewScroll(indexPath: NSIndexPath)
}

class PageViewController: UIPageViewController {
    weak var pageViewDelegate: PageViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentViewController = storyboard!.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        contentViewController.setIndex(index: 0)
        self.setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)

        self.dataSource = self
        self.delegate = self
    }



    func getFirst() -> ContentViewController {
        return storyboard!.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    // ひとつ前のページを返すDelegateメソッド
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let prevVc = viewController as? ContentViewController else {
            fatalError("not ContentViewController")
        }

        guard let prevPageIndex = prevVc.index.flatMap({ $0 - 1 }), 0 <= prevPageIndex else {
            return nil
        }

        let vc = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        vc.index = prevPageIndex
        return vc
    }

    // ひとつ先のページを返すDelegateメソッド
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let nextVc = viewController as? ContentViewController else {
            fatalError("not ContentViewController")
        }

        guard let nextPageIndex = nextVc.index.flatMap({ $0 + 1 }), nextPageIndex < ViewModelManager.sharedInstance.data.count else {
            return nil
        }

        let vc = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        vc.index = nextPageIndex
        return vc
    }
}

extension PageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

                //現在表示しているContentViewControllerを取得
        guard let currentVc = pageViewController.viewControllers?.first as? ContentViewController else {
            fatalError("not ContentViewController")
        }

        guard let index = currentVc.index else {
            fatalError("fail to get ContentViewController.index")
        }

        // MenuViewControllerの特定のセルにフォーカスをあてる
        let indexPath = NSIndexPath(item: index, section: 0)
        pageViewDelegate?.pageViewScroll(indexPath: indexPath)
    }
}
