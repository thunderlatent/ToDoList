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
    var listData = [ListModel]()
    var receiveTitleTF = ""
    var receiveSubtitleTF = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        toDoListTableView.reloadData()
        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
     
    // MARK: - TableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return listData.count
        listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if listData.count > 0
        {
            print("cellForRowAt")
        cell.detailTextLabel?.text = listData[indexPath.row].subtitle
        cell.textLabel?.text = listData[indexPath.row].title
        }
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            listData.remove(at: indexPath.row)
            toDoListTableView.deleteRows(at: [indexPath], with: .top)

        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (action, sourceView, complete) in
            self.listData.remove(at: indexPath.row)
            self.toDoListTableView.deleteRows(at: [indexPath], with: .top)
            self.saveData()
            complete(true)
        }
        let modifyAction = UIContextualAction(style: .normal, title: "修改") { (action, sourceView, complete) in
            let oldValue = self.listData[indexPath.row]
            self.creatAlert(alertTitle: "修改", alertMessage: "改啥子？", actionTitle: "確認", cancleTitle: "取消", text0: oldValue.title, text1: oldValue.subtitle, indexPath: indexPath)
            complete(true)
        }
        let insertAction = UIContextualAction(style: .normal, title: "插入") { (action, sourceView, complete) in
            self.creatAlert(alertTitle: "插入", alertMessage: "插入啥子？", actionTitle: "確認", cancleTitle: "取消", text0: "", text1: "", indexPath: indexPath)
            complete(true)
        }
        let trailingSwipConfiguration = UISwipeActionsConfiguration(actions: [deleteAction,modifyAction,insertAction])
        return trailingSwipConfiguration
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(style: .destructive, title: "分享") { (action, sourceView, complete) in
            let defaultText = "我於\(self.listData[indexPath.row].subtitle)時，要\(self.listData[indexPath.row].title)"
            let shareController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(shareController, animated: true, completion: nil)
            complete(true)
        }
        let leadingSwipeConfiguration = UISwipeActionsConfiguration(actions: [shareAction])
        return leadingSwipeConfiguration
    }
    @IBAction func addList(_ sender: UIButton) {
        creatAlert(alertTitle: "新增", alertMessage: "要幹啥子？", actionTitle: "確認", cancleTitle: "取消", text0: nil, text1: nil, indexPath: nil)
    }
    
    func loadData()
    {
//        UserDefaults.standard.array(forKey: "listData")
        if let loadData = UserDefaults.standard.value(forKey:"listData") as? Data {
            if let listData = try? PropertyListDecoder().decode([ListModel].self, from: loadData){
                self.listData = listData
                print("得到的data:\(listData)，實際的陣列內:\(self.listData)")
//                toDoListTableView.reloadData()
            }
            
        }
    }
    func saveData()
    {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.listData), forKey:"listData")
    }
}

