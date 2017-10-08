//
//  StartView.swift
//  Quiz
//
//  Created by KomoriTakeshi on 2017/08/11.
//  Copyright © 2017年 KomoriTakeshi. All rights reserved.
//

import UIKit

class StartView: UIView {

    func setParts() {
        let topLabel = UILabel(frame: CGRect(x: (frame.width - 250) / 2, y: 200, width: 250, height: 50))
        topLabel.text = "みんなのクイズ"
        topLabel.textAlignment = NSTextAlignment.center
        topLabel.font = UIFont.boldSystemFont(ofSize: 30)
        addSubview(topLabel)
        
        let smallLabel = UILabel(frame: CGRect(x: (frame.width - 250) / 2, y: topLabel.bottom + 20, width: 250, height: 20))
        smallLabel.text = "~次へを押すとクイズ開始~"
        smallLabel.textAlignment = NSTextAlignment.center
        smallLabel.font = UIFont.boldSystemFont(ofSize: 17)
        smallLabel.textColor = UIColor.lightGray
        addSubview(smallLabel)
    }

}
