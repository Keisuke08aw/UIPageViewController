//
//  MenuViewCell.swift
//  UIPageViewController
//
//  Created by Umezawa Keisuke on 2021/01/13.
//  Copyright © 2021 Umezawa Keisuke. All rights reserved.
//

import UIKit

class MenuViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // メニューによってテキストと背景色を変える
    func configure(title: String, color: UIColor, active: Bool) {
        nameLabel.text = title
        nameLabel.backgroundColor = color
        focusCell(active: active)
    }

    func focusCell(active: Bool) {
        let color = active ? UIColor.white : UIColor.lightGray
        nameLabel.textColor = color
    }

}
