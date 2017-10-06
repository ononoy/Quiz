//
//  ViewController.swift
//  Quiz
//
//  Created by y on 2017/10/04.
//  Copyright © 2017年 /. All rights reserved.
//

import UIKit

//テーブルビューに関係する定数
struct GuidanceTableStruct {
    static let cellCount: Int = 5
    static let cellSectionCount: Int = 1
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    //Outlet接続をした部品
    @IBOutlet var guideTableView: UITableView!
    
    //テーブルビューに表示する文言の内容を入れておくメンバ変数
    var guidanceArray: NSMutableArray = []
    
    //画面出現のタイミングに読み込まれる処理
    override func viewWillAppear(_ animated: Bool) {
        
        //ガイダンス用のテーブルビューに表示するテキストを(CSV形式で準備)読み込む
        let csvBundle = Bundle.main.path(forResource: "guidance", ofType: "csv")
        
        //CSVデータの解析処理
        do {
            
            //CSVデータを読み込む
            var csvData: String = try String(contentsOfFile: csvBundle!, encoding: String.Encoding.utf8)
            
            csvData = csvData.replacingOccurrences(of: "\r", with: "")
            
            //改行を基準にしてデータを分割する読み込む
            let csvArray = csvData.components(separatedBy: "\n")
            
            //CSVデータの行数分ループさせる
            for line in csvArray {
                
                //カンマ区切りの1行を["aaa", "bbb", ... , "zzz"]形式に変換して代入する
                let parts = line.components(separatedBy: ",")
                guidanceArray.add(parts)
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ナビゲーションのデリゲート設定
        self.navigationController?.delegate = self
        self.navigationItem.title = "食べ合わせクイズ"
        
        //テーブルビューのデリゲート設定
        guideTableView.delegate = self
        guideTableView.dataSource = self
        
        //自動計算の場合は必要
        guideTableView.estimatedRowHeight = 48
        guideTableView.rowHeight = UITableViewAutomaticDimension
        
        //Xibのクラスを読み込む
        let nibDefault:UINib = UINib(nibName: "guidanceCell", bundle: nil)
        guideTableView.register(nibDefault, forCellReuseIdentifier: "guidanceCell")
    }
    
    //TableViewに関する設定一覧（セクション数）
    func numberOfSections(in tableView: UITableView) -> Int {
        return GuidanceTableStruct.cellSectionCount
    }
    
    //TableViewに関する設定一覧（セクションのセル数）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GuidanceTableStruct.cellCount
    }
    
    //TableViewに関する設定一覧（セルに関する設定）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Xibファイルを元にデータを作成する
        let cell = tableView.dequeueReusableCell(withIdentifier: "guidanceCell") as? guidanceCell
        
        //取得したデータを読み込ませる
        //配列 → 0番目：タイトル, 1番目：説明文,
        let guidanceData: NSArray = self.guidanceArray[indexPath.row] as! NSArray
        
        cell!.guidanceTitle.text = guidanceData[0] as? String
        cell!.guidanceDescription.text = guidanceData[1] as? String
        
        //セルのアクセサリタイプと背景の設定
        cell!.accessoryType = UITableViewCellAccessoryType.none
        cell!.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell!
    }
    
    //データをリロードした際に読み込まれるメソッド
    func reloadData() {
        guideTableView.reloadData()
    }
    
    //クイズ画面に遷移するアクション
    @IBAction func goQuizAction(_ sender: AnyObject) {
        performSegue(withIdentifier: "goQuiz", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

/*
    //グローバル変数
    var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view.frame viewControllerの持っている大きさかつ同じ位置に
        //viewの上にスクロールビューを置いた
        scrollView = UIScrollView(frame: view.frame)
        scrollView.contentSize = CGSize(width: view.frame.width * 4, height: view.frame.height)
        //2行目スクロールビューの中身viewの４倍（中身の幅）を指定、ハイトは自身の大きさと同じ
        view.addSubview(scrollView)
        
        //スクロールを制御する
        scrollView.isScrollEnabled = false
        
        
        
        
        
        let view1 = UIView(frame: CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: view.frame.height))
        view1.backgroundColor = UIColor.red
        scrollView.addSubview(view1)
        
        
        let view2 = UIView(frame: CGRect(x: view.frame.width * 2, y: 0, width: view.frame.width, height: view.frame.height ))
        view2.backgroundColor = UIColor.green
        scrollView.addSubview(view2)
        
        
        
        
        
        let button = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 30))
        button.backgroundColor = UIColor.blue
        scrollView.addSubview(button)
        button.addTarget(self, action: #selector(tappedBtn), for: UIControlEvents.touchUpInside)
        
        
        let button1 = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 30))
        button1.backgroundColor = UIColor.blue
        view1.addSubview(button1)
        button1.addTarget(self, action: #selector(tappedBtn), for: UIControlEvents.touchUpInside)
        
    }
    
    
    
    
    //1ボタンを押した時の挙動
    func tappedBtn() {
    //時間をかけて行いたい時にアニメーションをかける
        UIView.animate(withDuration: 0.3) { 
            self.scrollView.contentOffset.x += self.view.frame.width
            
            


        
        
        
        }
        
        
    }
        
}
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
