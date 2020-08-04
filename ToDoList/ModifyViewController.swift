//
//  ModifyViewController.swift
//  ToDoList
//
//  Created by 陳裕銘 on 2020/8/4.
//  Copyright © 2020 yuming. All rights reserved.
//

import UIKit

class ModifyViewController: UIViewController {
    @IBOutlet weak var modifyTV: UITextView!
    @IBOutlet weak var modifyTF: UITextField!
    var listData: ListModel!
    var passingToATVCClosure: ((ListModel) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyTV.text = listData.title
        modifyTF.text = listData.subtitle
    }
    func savingModify()
    {
        if let text0 = modifyTV.text, let text1 = modifyTF.text{
            let data = ListModel(title: text0, subtitle: text1)
            passingToATVCClosure?(data)
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    @IBAction func savingBtn(_ sender: UIBarButtonItem) {
        savingModify()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
