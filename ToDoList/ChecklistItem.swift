//
//  ChecklistItem.swift
//  ToDoList
//
//  Created by Jonas Deichelmann on 07.05.17.
//  Copyright © 2017 JonasDeichelmann. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

final class ChecklistItem: Object {
    dynamic var text = ""
    dynamic var subText = ""
    dynamic var checked = false
    dynamic var date = "\(Date())"
    override static func primaryKey() -> String?{
        return "date";
    }
    func toggleChecked() {
        checked = !checked
    }

}
