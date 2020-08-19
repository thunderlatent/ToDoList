//
//  ExtensionTableViewDelegate.swift
//  ToDoList
//
//  Created by 陳裕銘 on 2020/8/4.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit
extension ListViewController
{
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
           return true
       }
//       func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//           //拖動cell重新排序
//           listDatas.insert(listDatas.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
//       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
          let cell = toDoListTableView.cellForRow(at: indexPath)
          tableView.beginUpdates()
          cell?.textLabel?.numberOfLines = (cell?.textLabel?.numberOfLines == 1) ? 0 : 1
          cell?.detailTextLabel?.numberOfLines = (cell?.detailTextLabel?.numberOfLines == 1) ? 0 : 1
          tableView.endUpdates()
      }
      func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
          .delete
      }
      func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
      {
          let deleteAction = UIContextualAction(style: .destructive, title: "刪除") { (action, sourceView, complete) in
              self.listDatas.remove(at: indexPath.row)
              self.toDoListTableView.deleteRows(at: [indexPath], with: .top)
              self.saveData()
              complete(true)
          }
          deleteAction.image = UIImage(systemName: "trash")
          let modifyAction = UIContextualAction(style: .normal, title: "修改") { (action, sourceView, complete) in
              let oldValue = self.listDatas[indexPath.row]
              self.indexPath = indexPath
              let destinationVC = self.storyboard?.instantiateViewController(identifier: "ModifyViewController") as! ModifyViewController
              destinationVC.listData = oldValue
              destinationVC.passingToATVCClosure = {(listData) in
                  self.listDatas[indexPath.row] = listData
                  self.saveData()
              }
              self.show(destinationVC, sender: self)
              complete(true)
          }
          modifyAction.image = UIImage(systemName: "pencil.and.ellipsis.rectangle")
          modifyAction.backgroundColor = UIColor.systemPurple
          let insertAction = UIContextualAction(style: .normal, title: "插入") { (action, sourceView, complete) in
              self.creatAlert(alertTitle: "插入", alertMessage: "插入啥子？", actionTitle: "確認", cancleTitle: "取消", text0: "", text1: "", indexPath: indexPath)
              complete(true)
          }
          insertAction.image = UIImage(systemName: "text.insert")
          insertAction.backgroundColor = UIColor.lightGray
          
          let trailingSwipConfiguration = UISwipeActionsConfiguration(actions: [deleteAction,modifyAction,insertAction])
          return trailingSwipConfiguration
      }
      func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
          let shareAction = UIContextualAction(style: .destructive, title: "分享") { (action, sourceView, complete) in
              let defaultText = "我於\(self.listDatas[indexPath.row].subtitle)時，要\(self.listDatas[indexPath.row].title)"
              let shareController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
              self.present(shareController, animated: true, completion: nil)
              complete(true)
          }
          shareAction.image = UIImage(systemName: "square.and.arrow.up")
          shareAction.backgroundColor = UIColor.systemOrange
          let leadingSwipeConfiguration = UISwipeActionsConfiguration(actions: [shareAction])
          return leadingSwipeConfiguration
      }
}
