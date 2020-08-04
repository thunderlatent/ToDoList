//
//  ViewController.swift
//  ToDoList
//
//  Created by 陳裕銘 on 2020/7/31.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var toDoListTableView: UITableView!
    var listDatas = [ListModel]()
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        toDoListTableView.reloadData()
        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let indexPath = indexPath{
            self.toDoListTableView.reloadRows(at: [indexPath], with: .top)
        }
    }
    
    // MARK: - TableViewDataSource
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if listDatas.count > 0
        {
            cell.detailTextLabel?.text = listDatas[indexPath.row].subtitle
            cell.textLabel?.text = listDatas[indexPath.row].title
        }
        return cell
    }
  
    @IBAction func addList(_ sender: UIButton) {
        creatAlert(alertTitle: "新增", alertMessage: "要幹啥子？", actionTitle: "確認", cancleTitle: "取消", text0: nil, text1: nil, indexPath: nil)
    }
    
    func loadData()
    {
        //        UserDefaults.standard.array(forKey: "listData")
        //         解析struct，並且存入UserDefault
        //        if let loadData = UserDefaults.standard.object(forKey:"listData") as? Data {
        //            if let listData = try? PropertyListDecoder().decode([ListModel].self, from: loadData){
        //                self.listData = listData
        //                print("得到的data:\(listData)，實際的陣列內:\(self.listData)")
        //               self.toDoListTableView.reloadData()
        //
        //            }
        //
        //        }
        
        if let loadData = UserDefaults.standard.object(forKey: "listData") as? Data
        {
            let decoder = JSONDecoder()
            if let listData = try! decoder.decode([ListModel]?.self, from: loadData)
            {
                self.listDatas = listData
                toDoListTableView.reloadData()
            }
        }
    }
    func saveData()
    {
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.listData), forKey:"listData")
        let encoder = JSONEncoder()
        if let encodeListData = try? encoder.encode(listDatas)
        {
            UserDefaults.standard.set(encodeListData, forKey: "listData")
        }
    }
    
    //建立cell動畫
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //淡入淡出
        //        cell.alpha = 0
        //        UIView.animate(withDuration: 3)
        //        {
        //            cell.alpha = 1
        //        }
        //        //定義旋轉角度
        //        let rotationAngleInRadians = 90 * CGFloat(Double.pi/180.0)
        //        //定義動畫旋轉
        //        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, 0, 0, 1)
        //定義飛入動畫
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, -100, 0)
        
        //讓cell層執行動畫
        cell.layer.transform = rotationTransform
        
        // 定義最終狀態（動畫結束之後）
        UIView.animate(withDuration: 0.5, animations: { cell.layer.transform = CATransform3DIdentity })
        
    }
    
    @IBAction func sortBtn(_ sender: UIBarButtonItem) {
        self.toDoListTableView.isEditing.toggle()
        sender.image = self.toDoListTableView.isEditing ? UIImage(systemName: "xmark.square") : UIImage(systemName: "arrow.up.arrow.down")
    }
}

