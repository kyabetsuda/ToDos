//
//  TableViewController.swift
//  ToDos
//
//  Created by 津田準 on 2018/01/24.
//  Copyright © 2018 津田準. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
    
    var todoItem: Results<ToDo>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        let attributes = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Light", size: 17)!]
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        
//        do{
//            let realm = try Realm()
//            try realm.write {
//                realm.deleteAll()
//            }
//        }catch{
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        let sections : [String] = makeSections()
        return sections.count
        
//        return 0

    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let sections : [String] = makeSections()
        var matrix : [[ToDo]] = makeMatrix()
        for i in 0...sections.count{
            if section == i {
                return matrix[i].count
            }else{
                continue
            }
        }

        return 0;
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 15)

        let sections : [String] = makeSections()
        var matrix : [[ToDo]] = makeMatrix()
        for i in 0...sections.count{
            if indexPath.section == i {
                cell.textLabel?.text = matrix[i][indexPath.row].title
            }else{
                continue
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        var matrix : [[ToDo]] = makeMatrix()

        if(editingStyle == UITableViewCellEditingStyle.delete) {
            do{
                let realm = try Realm()
                try realm.write {
                    realm.delete(matrix[indexPath.section][indexPath.row])
                }
                tableView.reloadData()
            }catch{
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var sections : [String] = makeSections()
        let header = UILabel(frame: CGRect(x: 0,y: 0,width: 1000,height: 100))
        header.text = " " + sections[section]
        header.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        header.backgroundColor = UIColor.lightGray
        return header
    }
    
    @IBAction func backToTop(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    
    func makeSections() -> [String] {
        do{
            let realm = try Realm()
            todoItem = realm.objects(ToDo.self).sorted(byKeyPath: "date", ascending: true)
        }catch{
            
        }
        
        var matrix : [[ToDo]] = []
        var sections : [String] = []
        var currentNum = 0
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd"
        if todoItem.count > 0 {
            for_i : for k in 0...(todoItem.count - 1) {
                //次の要素までずらす
                if k < currentNum {
                    continue
                }
                
                for j in k...(todoItem.count - 1) {
                    //jが最後に来た時の処理
                    if j == todoItem.count - 1{
                        //もし現在の要素と最後の要素が違うならば
                        if(todoItem[k].date != todoItem[j].date){
                            currentNum = j
                            matrix.append(Array(todoItem[k...j-1]))
                            sections.append(formatter.string(from: todoItem[k].date))
                            matrix.append(Array(todoItem[j...j]))
                            sections.append(formatter.string(from: todoItem[j].date))
                            break for_i
                            //同じならば
                        }else{
                            currentNum = j
                            matrix.append(Array(todoItem[k...j]))
                            sections.append(formatter.string(from: todoItem[k].date))
                            break for_i
                        }
                        //同じものが次にゆく
                    }else if todoItem[k].date == todoItem[j].date{
                        continue
                        //違うものが来た時点でそれまでの要素を配列にして代入
                    }else{
                        currentNum = j
                        matrix.append(Array(todoItem[k...(j-1)]))
                        sections.append(formatter.string(from: todoItem[k].date))
                        break
                    }
                }
                
            }
        }
        
        return sections
    }
    
    func makeMatrix() -> [[ToDo]] {
        do{
            let realm = try Realm()
            todoItem = realm.objects(ToDo.self).sorted(byKeyPath: "date", ascending: true)
        }catch{
            
        }
        
        var matrix : [[ToDo]] = []
        var sections : [String] = []
        var currentNum = 0
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd"
        if todoItem.count > 0 {
            for_i : for k in 0...(todoItem.count - 1) {
                //次の要素までずらす
                if k < currentNum {
                    continue
                }
                
                for j in k...(todoItem.count - 1) {
                    //jが最後に来た時の処理
                    if j == todoItem.count - 1{
                        //もし現在の要素と最後の要素が違うならば
                        if(todoItem[k].date != todoItem[j].date){
                            currentNum = j
                            matrix.append(Array(todoItem[k...j-1]))
                            sections.append(formatter.string(from: todoItem[k].date))
                            matrix.append(Array(todoItem[j...j]))
                            sections.append(formatter.string(from: todoItem[j].date))
                            break for_i
                            //同じならば
                        }else{
                            currentNum = j
                            matrix.append(Array(todoItem[k...j]))
                            sections.append(formatter.string(from: todoItem[k].date))
                            break for_i
                        }
                        //同じものが次にゆく
                    }else if todoItem[k].date == todoItem[j].date{
                        continue
                        //違うものが来た時点でそれまでの要素を配列にして代入
                    }else{
                        currentNum = j
                        matrix.append(Array(todoItem[k...(j-1)]))
                        sections.append(formatter.string(from: todoItem[k].date))
                        break
                    }
                }
                
            }
        }
        
        return matrix
    }
    
    
    
    

}
