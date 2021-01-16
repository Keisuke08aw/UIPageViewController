//
//  MenuViewController.swift
//  UIPageViewController
//
//  Created by Umezawa Keisuke on 2021/01/13.
//  Copyright © 2021 Umezawa Keisuke. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

@objc protocol MenuViewControllerDelegate: class {
    func menuViewController(viewController: MenuViewController, at index: Int)
}

class MenuViewController: UICollectionViewController {

    weak var delegate: MenuViewControllerDelegate? // 追加
    
    // 現在選択されている位置を状態として記憶しておくためのプロパティを作る
    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK:- UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewModelManager.sharedInstance.data.count
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // セルの設定
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuViewCellId", for: indexPath) as! MenuViewCell
        let data = ViewModelManager.sharedInstance.data[indexPath.row]
        let active = (indexPath.row == selectedIndex)
        cell.configure(title: data.menuTitle, color: data.themeColor, active: active)
        return cell
    }


    //セルがタップされると呼ばれる
    //1.メニューをタップすると、タップされたものが真ん中に来るこ機能
    //2.タップされたことをContainerに伝える機能
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //1.メニューをタップすると、タップされたものが真ん中に来る昨日
        focusCell(indexPath: indexPath as NSIndexPath)
        //2.タップされたことをContainerに伝える機能
        delegate?.menuViewController(viewController: self, at: indexPath.row) // 追加
    }

    // 指定したindexPathのセルを選択状態にして移動させる。(collectionViewなので表示されていないセルは存在しない)
    func focusCell(indexPath: NSIndexPath) {
        // 以前選択されていたセルを非選択状態にする(collectionViewなので表示されていないセルは存在しない)
        if let previousCell = collectionView?.cellForItem(at: NSIndexPath(item: selectedIndex, section: 0) as IndexPath) as? MenuViewCell {
            previousCell.focusCell(active: false)
        }

        // 新しく選択したセルを選択状態にする(collectionViewなので表示されていないセルは存在しない)
        if let nextCell = collectionView?.cellForItem(at: indexPath as IndexPath) as? MenuViewCell {
            nextCell.focusCell(active: true)
        }

        // 現在選択されている位置を状態としてViewControllerに覚えさせておく
        selectedIndex = indexPath.row

        // .CenteredHorizontallyでを指定して、CollectionViewのboundsの中央にindexPathのセルが来るようにする
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    //セルのサイズ（CGSize）を指定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 63)
    }

    //縦横両方0にしないとセル同士を詰められない
    //横の間隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //左右の余白は0
        return 0.0
    }
    //縦のスペース
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
