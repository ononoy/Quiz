//
//  ViewController.swift
//  Quiz
//
//  Created by KomoriTakeshi on 2017/08/10.
//  Copyright © 2017年 KomoriTakeshi. All rights reserved.
//

/*

 
 let entranceFee: Int = 1200
 
 func halfPrice(_ price: Int) -> Int {
    return price /2 
 }
 
 func fetPrice(age: Int) -> Int {
 if age <= 15 {
    let kidsEntranceFee: Int = halfPrice(entranceFee)
    return kidsEntranceFee
    }
    retrun entranceFee
}
 
 print ("23歳の入場料は、\(getPrice(age:23)円です""
 
 

 func hello(name: String) [
    print(message(name))
    ]
 func message(_ name:String) -> String [
    return "\(name)さん、こんにちは"
    ]
 hello(name: "鈴木")
 
 
 
 
 func add(_ numbers: Int...) -> Int {
    var sam: Int = 0
    for number in numbers {
        sum += number
    }
    return sum
    }
 print(add(5,7,1,8))

 
 let numbers: [Int] = [2,3,5,7]
 print(numbers.count)
 
 
 
func printArray(numbers: Int...) {
 print(numbers)
 }
 printArray(numbers:2,3,5,7,)

func printArray(_ numbers:Int...) {
 print(numbers)
 }
 printArray(2,3,5,7)
 
 
 
func add(_ a: Int, _ b: Int) -> Int {
    return a + b
 }
 func add(_ a:Double, _ b:Double) -> Double {
    return a + b
 }
add(5, 7)
add(3.1, 7.5)
 
 
func add(_ a:Int, b:Int) -> Int {
 return a + b
 }
 add(5,7)
 
 
func add ( num1 a: Int, num2 b: Int) -> {
    return a + b
 }
print (add(num1: 5, num2: 7))
 
 
let message : String = "成人です"
let age : Int = 23
 if age >= 20 {
 print(message)
 }

 func judge(score: Int) -> String {
 if score >= 60 {
 return "合格です"
 } {
 return "不合格です"
ptint(judge(score: 82))

 
 point (oub
 
*/

import UIKit

class BaseQuizViewController: UIViewController, UIScrollViewDelegate, FirstQuizViewDelegate, SecondQuizViewDelegate, ThirdQuizViewDelegate {
    
    var baseScrollView: UIScrollView!
    var startView: StartView!
    var firstQuizView: FirstQuizView!
    var secondQuizView: SecondQuizView!
    var thirdQuizView: ThirdQuizView!
    var finalView: FinalView!
    var scrollCount: CGFloat = 1
    var quizPoint: Int = 0
    var isFinished: Bool!
    var rightBarBtnItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBaseSetting()
        setUpBaseScrollView()
        setUpStartView()
        setUpQuizView()
        setUpFinalView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let naviHeight = navigationController?.navigationBar.frame.height
        let statusbarHeight = UIApplication.shared.statusBarFrame.height
        baseScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: naviHeight! + statusbarHeight, right: 0)
    }
    
    func setUpBaseSetting() {
        navigationItem.title = "Quiz"
        rightBarBtnItem = UIBarButtonItem(title: "次へ", style: UIBarButtonItemStyle.plain, target: self, action: #selector(tapNextBtn))
        rightBarBtnItem.tintColor = UIColor.white
        rightBarBtnItem.isEnabled = true
        navigationItem.rightBarButtonItem = rightBarBtnItem
        
        let leftBarBtnItem = UIBarButtonItem(title: "Reset", style: UIBarButtonItemStyle.plain, target: self, action: #selector(gameReset))
        leftBarBtnItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = leftBarBtnItem
        
         isFinished = false
    }
    
    func tapNextBtn() {
        if scrollCount == 5 {
            isFinished = true
            gameFinishAlert()
        }
        if !isFinished {
            UIView.animate(withDuration: 0.3) {
                self.baseScrollView.contentOffset = CGPoint(x: self.baseScrollView.frame.width * self.scrollCount, y: 0)
                self.finalView.pointLabel.text = "\(self.quizPoint)"
                self.rightBarBtnItem.isEnabled = false
            }
            self.scrollCount += 1
        }
    }
    
    func gameReset() {
        if scrollCount == 1 {
            gameNotStartingAlert()
        } else {
            quizPoint = 0
            scrollCount = 1
            isFinished = false
            rightBarBtnItem.isEnabled = true
            firstQuizView.changeDefaultColorBtn()
            firstQuizView.optionBtnStateChangeTrue()
            secondQuizView.changeDefaultColorBtn()
            secondQuizView.optionBtnStateChangeTrue()
            thirdQuizView.changeDefaultColorBtn()
            thirdQuizView.optionBtnStateChangeTrue()
            UIView.animate(withDuration: 0.3) {
                self.baseScrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
        }
    }
    
    func setUpBaseScrollView() {
        baseScrollView = UIScrollView(frame: view.frame)
        baseScrollView.contentSize = CGSize(width: view.frame.width * 5, height: view.frame.height)
        baseScrollView.isScrollEnabled = false
        baseScrollView.delegate = self
        view.addSubview(baseScrollView)
    }
    
    func setUpStartView() {
        startView = StartView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        startView.setParts()
        baseScrollView.addSubview(startView)
    }
    
    func setUpQuizView() {
        firstQuizView = FirstQuizView(frame: CGRect(x: baseScrollView.frame.width, y: 0, width: baseScrollView.frame.width, height: baseScrollView.frame.height))
        firstQuizView.setParts()
        firstQuizView.delegate = self
        baseScrollView.addSubview(firstQuizView)
        
        secondQuizView = SecondQuizView(frame: CGRect(x: baseScrollView.frame.width * 2, y: 0, width: baseScrollView.frame.width, height: baseScrollView.frame.height))
        secondQuizView.setParts()
        secondQuizView.delegate = self
        baseScrollView.addSubview(secondQuizView)
        
        thirdQuizView = ThirdQuizView(frame: CGRect(x: baseScrollView.frame.width * 3, y: 0, width: baseScrollView.frame.width, height: baseScrollView.frame.height))
        thirdQuizView.setParts()
        thirdQuizView.delegate = self
        baseScrollView.addSubview(thirdQuizView)
    }
    
    func setUpFinalView() {
        finalView = FinalView(frame: CGRect(x: baseScrollView.frame.width * 4, y: 0, width: baseScrollView.frame.width, height: baseScrollView.frame.height))
        finalView.setParts()
        baseScrollView.addSubview(finalView)
    }
    
    func gameNotStartingAlert() {
        let alert = UIAlertController(title:"まだ始まってもいません", message: "とりあえず次へを押しましょう", preferredStyle: UIAlertControllerStyle.alert)
        
        let action1 = UIAlertAction(title: "OK牧場", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            self.gameReset()
        })
        
        alert.addAction(action1)
        
        self.present(alert, animated: true, completion: nil)
    }

    func gameFinishAlert() {
        let alert = UIAlertController(title:"もう試合終了してます", message: "またやるにはリセットしましょう", preferredStyle: UIAlertControllerStyle.alert)
        
        let action1 = UIAlertAction(title: "リセットする", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            self.gameReset()
        })
        
        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) in
        })
        
        alert.addAction(action1)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func optionBtnTapped(point: Int) {
        rightBarBtnItem.isEnabled = true
        self.quizPoint += point
    }
    
    func optionBtnTapped_Second(point: Int) {
        rightBarBtnItem.isEnabled = true
        self.quizPoint += point
    }
    
    func optionBtnTapped_Third(point: Int) {
        rightBarBtnItem.isEnabled = true
        self.quizPoint += point
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

