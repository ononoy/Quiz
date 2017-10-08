//
//  FinalView.swift
//  Quiz
//
//  Created by KomoriTakeshi on 2017/08/11.
//  Copyright © 2017年 KomoriTakeshi. All rights reserved.
//

import UIKit

class FinalView: UIView {
    
    var pointLabel: UILabel!
    
    func setParts() {
        let topLabel = UILabel(frame: CGRect(x: (frame.width - 250) / 2, y: 100, width: 250, height: 100))
        topLabel.text = "あなたの点数は....."
        topLabel.textAlignment = NSTextAlignment.center
        topLabel.font = UIFont.boldSystemFont(ofSize: 30)
        addSubview(topLabel)
        
        pointLabel = UILabel(frame: CGRect(x: (frame.width - 100) / 2, y: topLabel.bottom + 20, width: 100, height: 50))
        pointLabel.text = ""
        pointLabel.textAlignment = NSTextAlignment.center
        pointLabel.font = UIFont.boldSystemFont(ofSize: 30)
        addSubview(pointLabel)
        
    }
}
