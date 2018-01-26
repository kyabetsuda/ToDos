//
//  InputViewController.swift
//  ToDos
//
//  Created by 津田準 on 2018/01/24.
//  Copyright © 2018 津田準. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {

    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var memo: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var modalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        date.inputView = datePicker
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let toolBarBtn = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(self.doneBtn))
        toolBar.items = [toolBarBtn]
        date.inputAccessoryView = toolBar
        
        let toolBar2 = UIToolbar()
        toolBar2.sizeToFit()
        let toolBarBtn2 = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(self.doneBtn2))
        toolBar2.items = [toolBarBtn2]
        memo.inputAccessoryView = toolBar2
        
        date.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        date.text = formatter.string(from: Date())
        
        memo.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        
        dateLabel.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        memoLabel.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        
        addButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        
        modalView.layer.cornerRadius = 20
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
    }

    @IBAction func textFieldEditing(_ sender: UITextField) {
        
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd";
        date.text = dateFormatter.string(for: sender.date)
    }
    
    @objc func doneBtn(){
        date.resignFirstResponder()
    }
    
    @objc func doneBtn2(){
        memo.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "toFirstController") {
            if (date.text == nil || date.text == "") || (memo.text == nil || memo.text == "") {
                let alert: UIAlertController = UIAlertController(title: "Caution: ", message: "text is empty", preferredStyle:  UIAlertControllerStyle.alert)
                
                let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                    // ボタンが押された時の処理を書く（クロージャ実装）
                    (action: UIAlertAction!) -> Void in
                    print("OK")
                })
                
                alert.addAction(defaultAction)
                
                present(alert, animated: true, completion: nil)
                return false;
            }else{
                let newTodo = ToDo()
                
                let now = date.text
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                let date2 = formatter.date(from: now! + " 00:00:00")
                
                // textFieldに入力したデータをnewTodoのtitleに代入
                newTodo.date = date2
                newTodo.title = memo.text!
                
                // 上記で代入したテキストデータを永続化するための処理
                do{
                    let realm = try Realm()
                    try realm.write({ () -> Void in
                        realm.add(newTodo)
                        print("ToDo Saved")
                        print(newTodo.date)
                        print(newTodo.title)
                    })
                }catch{
                    print("Save is Faild")
                }
            }
        }
        return true;
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {

    }
    
    @objc func viewTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
