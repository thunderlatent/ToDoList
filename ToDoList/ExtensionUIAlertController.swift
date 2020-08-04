//
//  ExtensionUIAlertController.swift
//  ToDoList
//
//  Created by 陳裕銘 on 2020/7/31.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit
extension ListViewController
{
    func creatAlert(alertTitle: String, alertMessage: String, actionTitle: String, cancleTitle: String, text0: String?, text1: String?, indexPath: IndexPath?)
    {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        //style為cancel的Action，不論添加順序怎樣，都是在最下面或最左面，不能改
        let cancleAction = UIAlertAction(title: cancleTitle, style: .cancel, handler: nil)
        
        let okAction = UIAlertAction(title: actionTitle, style: .destructive){ (action) in
            
            if let text0 = alert.textFields?[0].text, let text1 = alert.textFields?[1].text
            {
                let totalText = ListModel(title: text0, subtitle: text1)
                if alertTitle == "新增"
                {
                    self.listDatas.insert(totalText, at: 0)
                    print("新增")
//                    self.toDoListTableView.reloadData()
                    self.toDoListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
                }
                if let indexPath = indexPath{
//                    if alertTitle == "修改"
//                    {
//                        
//                        
////                        self.listDatas[indexPath.row] = totalText
//                    }else
                        if alertTitle == "插入"
                    {
                        self.listDatas.insert(totalText, at: indexPath.row)
                        print("indexPath.row\(indexPath.row)")
                        self.toDoListTableView.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            }
            self.saveData()
        }
        alert.addTextField { (titleTF) in
            if let text0 = text0
            {
                titleTF.text = text0
            }
            titleTF.placeholder = "輸入事項EX:人事時地物"
        }
        alert.addTextField { (subtitleTF) in
            
            if let text1 = text1
            {
                subtitleTF.text = text1
            }
            subtitleTF.placeholder = "輸入何時執行EX:么拐兩洞"
        }
        alert.addAction(okAction)
        alert.addAction(cancleAction)
        present(alert, animated: true, completion: nil)
    }
    
}
