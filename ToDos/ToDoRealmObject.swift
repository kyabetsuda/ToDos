//
//  ToDoRealmObject.swift
//  ToDos
//
//  Created by 津田準 on 2018/01/25.
//  Copyright © 2018 津田準. All rights reserved.
//

import RealmSwift

class ToDo: Object {
    @objc dynamic var date : Date! = nil
    @objc dynamic var title = ""
}
