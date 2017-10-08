//
//  FirstQuizView.swift
//  Quiz
//
//  Created by KomoriTakeshi on 2017/08/10.
//  Copyright © 2017年 KomoriTakeshi. All rights reserved.
//

import UIKit

protocol FirstQuizViewDelegate {
    func optionBtnTapped(point: Int)
}

class FirstQuizView: UIView {
    
    var delegate: FirstQuizViewDelegate!
    var answerView: UIView!
    var optionBtn_A: OptionButton!
    var optionBtn_B: OptionButton!
    var optionBtn_C: OptionButton!
    

    func setParts() {
        let topLabel = UILabel(frame: CGRect(x: (frame.width - 250) / 2, y: 100, width: 250, height: 50))
        topLabel.text = "第一問"
        topLabel.textAlignment = NSTextAlignment.center
        topLabel.font = UIFont.boldSystemFont(ofSize: 30)
        addSubview(topLabel)
        
        let quizLabel = UILabel(frame: CGRect(x: 40, y: topLabel.bottom + 20, width: frame.width - 80, height: 20))
        quizLabel.text = "パンはパンでも食べられないパンはなーんだ？"
        quizLabel.textAlignment = NSTextAlignment.center
        quizLabel.font = UIFont.boldSystemFont(ofSize: 15)
        quizLabel.textColor = UIColor.lightGray
        addSubview(quizLabel)
        
        optionBtn_A = OptionButton(frame: CGRect(x: quizLabel.left, y: quizLabel.bottom + 30, width: quizLabel.frame.width, height: 50))
        optionBtn_A.setTitle("A : フライパン", for: UIControlState.normal)
        optionBtn_A.setTitleColor(UIColor.white, for: UIControlState.normal)
        optionBtn_A.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        optionBtn_A.layer.cornerRadius = 4.0
        optionBtn_A.backgroundColor = UIColor.lightGray
        optionBtn_A.addTarget(self, action: #selector(btnTapped), for: UIControlEvents.touchUpInside)
        optionBtn_A.isAnswer = true
        addSubview(optionBtn_A)
        
        optionBtn_B = OptionButton(frame: CGRect(x: quizLabel.left, y: optionBtn_A.bottom + 20, width: quizLabel.frame.width, height: 50))
        optionBtn_B.setTitle("B : フライパン", for: UIControlState.normal)
        optionBtn_B.setTitleColor(UIColor.white, for: UIControlState.normal)
        optionBtn_B.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        optionBtn_B.layer.cornerRadius = 4.0
        optionBtn_B.backgroundColor = UIColor.lightGray
        optionBtn_B.addTarget(self, action: #selector(btnTapped), for: UIControlEvents.touchUpInside)
        optionBtn_B.isAnswer = false
        addSubview(optionBtn_B)
        
        optionBtn_C = OptionButton(frame: CGRect(x: quizLabel.left, y: optionBtn_B.bottom + 20, width: quizLabel.frame.width, height: 50))
        optionBtn_C.setTitle("C : フライパン", for: UIControlState.normal)
        optionBtn_C.setTitleColor(UIColor.white, for: UIControlState.normal)
        optionBtn_C.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        optionBtn_C.layer.cornerRadius = 4.0
        optionBtn_C.backgroundColor = UIColor.lightGray
        optionBtn_C.addTarget(self, action: #selector(btnTapped), for: UIControlEvents.touchUpInside)
        optionBtn_C.isAnswer = false
        addSubview(optionBtn_C)
    }
    
    func btnTapped(sender: OptionButton) {
        var point = 0
        if sender.isAnswer != true {
            sender.backgroundColor = UIColor.blue
            sender.setTitle("不正解", for: UIControlState.normal)
            sender.setTitleColor(UIColor.white, for: UIControlState.normal)
        } else {
            sender.backgroundColor = UIColor.green
            sender.setTitle("正解", for: UIControlState.normal)
            sender.setTitleColor(UIColor.white, for: UIControlState.normal)
            point = 1
        }
        optionBtnStateChangeFalse()
        delegate.optionBtnTapped(point: point)
    }
    
    func optionBtnStateChangeFalse() {
        optionBtn_A.isEnabled = false
        optionBtn_B.isEnabled = false
        optionBtn_C.isEnabled = false
    }
    
    func optionBtnStateChangeTrue() {
        optionBtn_A.isEnabled = true
        optionBtn_B.isEnabled = true
        optionBtn_C.isEnabled = true
    }
    
    func changeDefaultColorBtn() {
        optionBtn_A.backgroundColor = UIColor.lightGray
        optionBtn_A.setTitle("フライパン", for: UIControlState.normal)
        optionBtn_B.backgroundColor = UIColor.lightGray
        optionBtn_B.setTitle("フライパン", for: UIControlState.normal)
        optionBtn_C.backgroundColor = UIColor.lightGray
        optionBtn_C.setTitle("フライパン", for: UIControlState.normal)
    }

}
